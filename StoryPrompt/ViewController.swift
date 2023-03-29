//
//  ViewController.swift
//  StoryPrompt
//
//  Created by Vinicius Pinheiro de Oliveira on 29/03/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nounTexField: UITextField!
    @IBOutlet weak var adjectiveTexField: UITextField!
    @IBOutlet weak var verbTextField: UITextField!
    @IBOutlet weak var numberSlider: UISlider!
    @IBOutlet weak var numberLabel: UILabel!
    
    let storyPrompt = StoryPromptEntry()
    
    @IBAction func changeNumber(_ sender: UISlider) {
        numberLabel.text = "Number: \(Int(sender.value))"
        storyPrompt.number = Int(sender.value)
    }
    
    @IBAction func changeStoryType(_ sender: UISegmentedControl) {
        if let genre = StoryPrompts.Genre(rawValue: sender.selectedSegmentIndex) {
            storyPrompt.genre = genre
        } else {
            storyPrompt.genre = .scifi
        }
        
    }
    
    @IBAction func genereateStoryPrompt(_ sender: Any) {
        updateStoryPrompt()
        print(storyPrompt)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        numberSlider.value = 7.5
        storyPrompt.noun = "toaster"
        storyPrompt.noun = "smelly"
        storyPrompt.noun = "burps"
        storyPrompt.number = Int(numberSlider.value)
        print(storyPrompt)
        
        
    }
    
    func updateStoryPrompt() {
        storyPrompt.noun = nounTexField.text ?? ""
        storyPrompt.adjective = adjectiveTexField.text ?? ""
        storyPrompt.verb = verbTextField.text ?? ""
    }
}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updateStoryPrompt()
       
        return true
    }
}
