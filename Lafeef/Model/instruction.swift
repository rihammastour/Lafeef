//
//  instruction.swift
//  Lafeef
//
//  Created by Mihaf on 17/06/1442 AH.
//

import UIKit
class instruction {
    func Instruction() ->  InstructionViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let instructionVC = storyboard.instantiateViewController(identifier: "instruction") as InstructionViewController
      
      
        return instructionVC
      }
  
}
