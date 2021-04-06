//
//  TrainingBoardViewController.swift
//  Lafeef
//
//  Created by Raghad alfuhaid on 20/08/1442 AH.
//

import Foundation
import UIKit
import CodableFirebase

class TrainingBoardViewController: UIViewController {
    @IBOutlet weak var nextlOutlet: UIButton!
    @IBOutlet weak var skiplOutlet: UIButton!
    @IBOutlet weak var QuestionLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var section:String = "colors" // must be passed from training sections viewcontroller
    var questionDetailes: [TrainingQuestions]?
    var questionId: Int = 0 // update it in next button or skip
    var answer: String!

    @IBOutlet weak var strawberry: UIImageView!
    var infoView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "blank-bakery")
        backgroundImage.contentMode = UIView.ContentMode.scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
        nextlOutlet.layer.cornerRadius =  nextlOutlet.frame.size.height/2
        
        skiplOutlet?.layer.cornerRadius =  skiplOutlet.frame.size.height/2
        
        
        // make multiline
        QuestionLabel.numberOfLines = 0
        QuestionLabel.lineBreakMode = .byWordWrapping
        QuestionLabel.frame.size.width = 300
        QuestionLabel.sizeToFit()
        
        getTrainingQuestion()
        setInfoView()
//        infoLabel?.isHidden = true
    }
    
    func setInfoView(){
//        self.stack.frame.size.width = width
        let viewFrame = CGRect(x: 143, y: 1000, width: 0, height: 119)
              let view = UIView(frame: viewFrame)
              self.infoView = view
        self.infoView.backgroundColor = UIColor(named: "whiteApp")
        self.strawberry.layer.zPosition = 1
              self.view.addSubview(self.infoView!)
    }
    
    
    func getTrainingQuestion(){
        FirebaseRequest.getTrainingQuestionsData(for: section, completion: feachTrainingQuestionHandler(_ :_:))
    }
    
    //feachTrainingQuestionHandler
    func feachTrainingQuestionHandler(_ data:Any?,_ err:Error?) -> Void {
        
        if err != nil{
            print("Training board View Controller",err!)
            
            if err?.localizedDescription == "Failed to get document because the client is offline."{
                print("تأكد من اتصال الانترنيت")
                //TODO: Alert and update button and go back
                
            }
            print("No  questions")
            
        }else{
            
            do{
                //Convert data to type Question
                let question = try FirebaseDecoder().decode(Questions.self, from: data!)
                self.setTrainingQuestionInfo(question: question)
            }catch{
                print("error while decoding ",error.localizedDescription)
        
            }
            
        }
    }
    
    func setTrainingQuestionInfo(question:Questions){
        self.questionDetailes = question.qeustionDetailes
        QuestionLabel.text = question.questionText
        showQuestion(at: questionId)
    }
    
    func showQuestion(at index:Int){
        
        //check if questionDetailes not null
        guard let detailes = self.questionDetailes else {
            print("there is no detailes") //replace it with alert
            return
        }
        
        switch section {
        case "shapes":
            if detailes[index].type == "circle"{
                image.image = UIImage(named: "Training-yellowCircle")
                self.answer = detailes[index].answer
            } else  if detailes[index].type == "triangle" {
                image.image = UIImage(named: "Training-blueTriangle")
                self.answer = detailes[index].answer
            }
            break

        case "colors":
            if detailes[index].type == "brown"{
                image.image = UIImage(named: "Training-brownColor")
                self.answer = detailes[index].answer
            } else  if detailes[index].type == "red" {
                image.image = UIImage(named: "Training-redColor")
                self.answer = detailes[index].answer
            }
            break
            
        case "calculations":
            if detailes[index].type == "addition"{
                image.image = UIImage(named: "Training-yellowCircle")
                self.answer = detailes[index].answer
            } else  if detailes[index].type == "subtraction" {
                image.image = UIImage(named: "Training-bleuTriangle")
                self.answer = detailes[index].answer
            } else  if detailes[index].type == "muliplication" {
                image.image = UIImage(named: "Training-bleuTriangle")
                self.answer = detailes[index].answer
            }
            break
            
        default:
            print("there is no section")
        }
    }
    
    func nextQuestion() {

        // handling index out of range
        if (questionDetailes!.count-1) == self.questionId  {
            self.questionId = 0
        } else {
            //next Question
            self.questionId += 1
        }

        showQuestion(at: questionId)
    }
    
    @IBAction func answerButton(_ sender: Any) {
        UIView.animate(
                 withDuration: 0.4,
                 delay: 0.0,
                 options: .curveLinear,
                 animations: {
 
                   self.infoView.frame.size.width = 655
 
             }) { (completed) in

             }
    }
    @IBAction func skipButton(_ sender: Any) {

        nextQuestion()
    }
    
  
}
