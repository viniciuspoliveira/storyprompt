//
//  ViewController.swift
//  StoryPrompt
//
//  Created by Vinicius Pinheiro de Oliveira on 29/03/23.
//

import UIKit
import PhotosUI

class ViewController: UIViewController {
    
    @IBOutlet weak var nounTexField: UITextField!
    @IBOutlet weak var adjectiveTexField: UITextField!
    @IBOutlet weak var verbTextField: UITextField!
    @IBOutlet weak var numberSlider: UISlider!
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var storyPromptImageView: UIImageView!
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
        storyPromptImageView.isUserInteractionEnabled = true
        let gestureRegonizer = UITapGestureRecognizer(target: self, action: #selector(changeImage))
        storyPromptImageView.addGestureRecognizer(gestureRegonizer)
        
        
    }
    
    func updateStoryPrompt() {
        storyPrompt.noun = nounTexField.text ?? ""
        storyPrompt.adjective = adjectiveTexField.text ?? ""
        storyPrompt.verb = verbTextField.text ?? ""
    }
    
    @objc func changeImage(){
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = self
        present(controller, animated: true)
    }
}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updateStoryPrompt()
       
        return true
    }
}

extension ViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if !results.isEmpty{
            let result = results.first!
            let itemProvider = result.itemProvider
            if itemProvider.canLoadObject(ofClass: UIImage.self){
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                    guard let image = image as? UIImage else {
                        return
                    }
                    DispatchQueue.main.async {
                        self?.storyPromptImageView.image = image
                    }
                }
            }
        }
    }
}
