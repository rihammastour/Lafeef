//
//  LafeefTests.swift
//  LafeefTests
//
//  Created by Riham Mastour on 05/06/1442 AH.
//

import XCTest
@testable import Lafeef

class LafeefTests: XCTestCase {
    
    var emailVC: SignUpEmailViewController!
    var DOBVC: SignUpDOBViewController!
    var charectarVC: SignUpCharachterViewController!
    var nameVC: SignUpNameViewController!
    var loginVC : LoginViewController!
    var updatePasswordVC: UpdatePasswordViewController!
    var buyItem: StoreViewController!
    var editProfileVC: EditProfileViewConroller!
    var challengeVC: ChallengeViewController!
    var dailyReportVC: DailyReportViewController!
    
    override func setUp() {
        super.setUp()
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        emailVC = mainStoryboard.instantiateViewController(withIdentifier:Constants.Storyboard.signUpEmailViewController) as? SignUpEmailViewController
        emailVC.loadViewIfNeeded()

        DOBVC = mainStoryboard.instantiateViewController(withIdentifier:Constants.Storyboard.signUpDOBViewController) as? SignUpDOBViewController
        DOBVC.loadViewIfNeeded()

        charectarVC = mainStoryboard.instantiateViewController(withIdentifier:Constants.Storyboard.signupCharectarViewController) as? SignUpCharachterViewController
        charectarVC.loadViewIfNeeded()

        nameVC = mainStoryboard.instantiateViewController(withIdentifier:Constants.Storyboard.signUpNameViewController) as? SignUpNameViewController
       nameVC.loadViewIfNeeded()
        
        loginVC = mainStoryboard.instantiateViewController(withIdentifier:Constants.Storyboard.loginViewController) as? LoginViewController
        loginVC.loadViewIfNeeded()
        
        let homeViewStoryboard = UIStoryboard(name: "HomeView", bundle: nil)
        updatePasswordVC = homeViewStoryboard.instantiateViewController(withIdentifier:Constants.Storyboard.updatePasswordViewController) as? UpdatePasswordViewController
        updatePasswordVC.loadViewIfNeeded()
        
        buyItem = homeViewStoryboard.instantiateViewController(withIdentifier:Constants.Storyboard.storeViewController) as? StoreViewController
        buyItem.loadViewIfNeeded()
        
        editProfileVC = homeViewStoryboard.instantiateViewController(withIdentifier:Constants.Storyboard.editProfileViewController) as? EditProfileViewConroller
        editProfileVC.loadViewIfNeeded()
     
        let challengeStoryboard = UIStoryboard(name: "Challenge", bundle: nil)
        challengeVC = challengeStoryboard.instantiateViewController(withIdentifier:Constants.Storyboard.challengeViewController) as? ChallengeViewController
        challengeVC.loadViewIfNeeded()
        
        dailyReportVC = challengeStoryboard.instantiateViewController(withIdentifier:Constants.Storyboard.dailyReportViewController) as? DailyReportViewController
        dailyReportVC.loadViewIfNeeded()
    }
    
    override func tearDown() {
        emailVC = nil
        DOBVC = nil
        nameVC = nil
        loginVC = nil
        buyItem = nil
        editProfileVC = nil
        challengeVC = nil
        dailyReportVC = nil
        super.tearDown()
    }
    
    func testInvalidSignupEmail(){
        emailVC.emailTextfield.text = "g.com"
        emailVC.validator.validate(emailVC.self)
        emailVC.validation()
      
        XCTAssertFalse(emailVC.isValidated)
    }
    
    func testIsInvalidSignupDOB(){
        DOBVC.dayTextfield.text = ""
        DOBVC.yearTextfield.text = ""
        DOBVC.monthTextfield.text = ""
        
        XCTAssertFalse(DOBVC.isValidated)
    }
    
    func testIsInvalidSignupCharectar(){
        charectarVC.user.sex = ""
        let test = charectarVC.checkCharectar()
        
        XCTAssertFalse(test)
    }

    func testIsInvalidSignupName(){
        nameVC.nameTextfield.text = "riham2"
        nameVC.validator.validate(nameVC.self)
        nameVC.validation()
        
        XCTAssertFalse(nameVC.isValidated)
    }

    func testValidSignupFields(){
        let user = User(DOB: "12-12-2007", email: "rr@gmail.com", name: "رهام", sex: "girl")
        nameVC.user = user
        nameVC.nameTextfield.text =  nameVC.user.name
        nameVC.password = "kiwi123"
        nameVC.validator.validate(nameVC.self)
        nameVC.validation()
        
        XCTAssertTrue(nameVC.isValidated)
    }
    
    func testEmptyLoginFields(){
        loginVC.password = ""
        loginVC.emailTextfield.text = ""
        loginVC.validator.validate(loginVC.self)
        loginVC.validation()
        let test = loginVC.isFieldValidated()
      
        XCTAssertFalse(test)
    }
    
    func testValidLoginFields(){
        loginVC.password = "berry123"
        loginVC.emailTextfield.text = "riham@gmail.com"
        loginVC.validator.validate(loginVC.self)
        loginVC.validation()
        let test = loginVC.isFieldValidated()
      
        XCTAssertTrue(test)
    }
    
    func testInvalidEmailLogin(){
        loginVC.password = "berry123"
        loginVC.emailTextfield.text = "gmail.com"
        loginVC.validator.validate(loginVC.self)
        loginVC.validation()
        let test = loginVC.isFieldValidated()
      
        XCTAssertFalse(test)
    }
    
    func testUpdatePasswordWithSamePasswords(){
        updatePasswordVC.oldPassword = "berry123"
        updatePasswordVC.newPassword = "berry123"
        let test = updatePasswordVC.updatePassword()
        
        XCTAssertEqual(test,  "اختر رمز مرور جديد")
    }
    
    func testUpdatePasswordWithEmptyOldPassword(){
        updatePasswordVC.oldPassword = ""
        updatePasswordVC.newPassword = "berry123"
        let test = updatePasswordVC.updatePassword()
        
        XCTAssertEqual(test, "هلّا أدخلت رمز مرورك السابق؟")
    }
    
    func testUpdatePasswordWithEmptyNewPassword(){
        updatePasswordVC.oldPassword = "berry123"
        updatePasswordVC.newPassword = ""
        let test = updatePasswordVC.updatePassword()
        
        XCTAssertEqual(test, "هلّا أدخلت رمز مرورك الجديد؟")
    }
    
    func testValidUpdatePassword(){
        updatePasswordVC.oldPassword = "berry123"
        updatePasswordVC.newPassword = "kiwi123"
        let test = updatePasswordVC.updatePassword()
        
        XCTAssertEqual(test, "تم تغيير رمز مرورك بنجاح 🎉")
    }
    
    func testbuyItemWithEnoughMoney(){
        buyItem.money = 200
        let equipment = StoreEquipment(sex: "unisex", name: BackeryStore.cupcakeFrame.rawValue, cost: 50, label: "لوحة كب كيك")
        let test = buyItem.buyItem(equipment)
        
        XCTAssertTrue(test)
    }
    
    func testbuyItemWithNoMoneyEnough(){
        buyItem.money = 40
        let equipment = StoreEquipment(sex: "unisex", name: BackeryStore.cupcakeFrame.rawValue, cost: 50, label: "لوحة كب كيك")
        let test = buyItem.buyItem(equipment)
        
        XCTAssertFalse(test)
    }
    
    func testInvalidNameEditProfile(){
        editProfileVC.NameTextField.text = "123r"
        editProfileVC.validator.validate(editProfileVC.self)
        editProfileVC.validation()
        
        XCTAssertFalse(editProfileVC.isValidated)
    }
    
    func testValidEditProfile(){
        editProfileVC.NameTextField.text = "ريناد"
        editProfileVC.dayTextfield.text = "12"
        editProfileVC.monthTextfield.text = "02"
        editProfileVC.yearTextfield.text = "2017"
        editProfileVC.ProfilePic.image = UIImage(named: "BoyWithCircle")
        editProfileVC.validator.validate(editProfileVC.self)
        editProfileVC.validation()
        let test = editProfileVC.updateProfile()
        
        XCTAssertTrue(test)
    }
    
    func testInvalidBaseTotalScore(){
        let order = Order(base: Base.cake, customerPaid: 50, toppings: nil)
        challengeVC.setOrder(order: order)
        
        /// to calculate order bill
        challengeVC.calculateTotalBill(at: 0)
        challengeVC.calculateTotalBillWithTax(at: 0)
        
        let answer = Answer(base: Base.chocolateCupcake, change: 0, atTime: 12, toppings: nil)
        challengeVC.calculateOrderScore(for: answer)
        challengeVC.calculatePaymentScore(with: answer.change)
        
        let test = challengeVC.calculateTotalScore()
        
        XCTAssertEqual(test, 1)
    }
    
    func testInvalidToppingsTypeAndNumberTotalScore(){
        let order = Order(base: Base.cake, customerPaid: 50, toppings: nil)
        challengeVC.setOrder(order: order)
        
        /// to calculate order bill
        challengeVC.calculateTotalBill(at: 0)
        challengeVC.calculateTotalBillWithTax(at: 0)
        
        let answer = Answer(base: Base.cake, change: 0, atTime: 12, toppings: [Topping.kiwi, Topping.darkChocolate])
        challengeVC.calculateOrderScore(for: answer)
        challengeVC.calculatePaymentScore(with: answer.change)
        
        let test = challengeVC.calculateTotalScore()
        
        XCTAssertEqual(test, 2)
    }
    
    func testInvalidToppingsNumberTotalScore(){
        let order = Order(base: Base.cake, customerPaid: 53, toppings: [Topping.strawberry])
        challengeVC.setOrder(order: order)
        
        /// to calculate order bill
        challengeVC.calculateTotalBill(at: 0)
        challengeVC.calculateTotalBillWithTax(at: 0)
        
        let answer = Answer(base: Base.cake, change: 0, atTime: 12, toppings: [Topping.strawberry, Topping.strawberry])
        challengeVC.calculateOrderScore(for: answer)
        challengeVC.calculatePaymentScore(with: answer.change)
        
        let test = challengeVC.calculateTotalScore()
        
        XCTAssertEqual(test, 3)
    }
    
    func testInvalidChangeTotalScore(){
        let order = Order(base: Base.cake, customerPaid: 50, toppings: nil)
        challengeVC.setOrder(order: order)
        
        /// to calculate order bill
        challengeVC.calculateTotalBill(at: 0)
        challengeVC.calculateTotalBillWithTax(at: 0)
        
        let answer = Answer(base: Base.cake, change: 30, atTime: 12, toppings: nil)
        challengeVC.calculateOrderScore(for: answer)
        challengeVC.calculatePaymentScore(with: answer.change)
        
        let test = challengeVC.calculateTotalScore()
        
        XCTAssertEqual(test, 3)
    }
    
    func testValidTotalScore(){
        let order = Order(base: Base.cake, customerPaid: 50, toppings: nil)
        challengeVC.setOrder(order: order)
        
        /// to calculate order bill
        challengeVC.calculateTotalBill(at: 0)
        challengeVC.calculateTotalBillWithTax(at: 0)
        
        let answer = Answer(base: Base.cake, change: 0, atTime: 12, toppings: nil)
        challengeVC.calculateOrderScore(for: answer)
        challengeVC.calculatePaymentScore(with: answer.change)
        
        let test = challengeVC.calculateTotalScore()
        
        XCTAssertEqual(test, 4)
    }
    
    func testLessThanGoalScoreGenerateReward(){
        dailyReportVC.report.levelNum = "1"
        dailyReportVC.report.collectedScore = 30
        dailyReportVC.calculateReward()
        
        XCTAssertFalse(dailyReportVC.report.isRewarded)
    }
    
    func testValidGenerateReward(){
        dailyReportVC.report.levelNum = "1"
        dailyReportVC.report.collectedScore = 70
        dailyReportVC.calculateReward()
        
        XCTAssertTrue(dailyReportVC.report.isRewarded)
    }

}
