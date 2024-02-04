//
//  ViewController.swift
//  Quiz
//
//  Created by Yusuf Bayindir on 1/27/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    
    @IBOutlet weak var flag: UIImageView!
    @IBOutlet weak var tryAgain: UIButton!

    lazy var keysArray = Array(questions.keys)
    var countryNames = [String]()
    var index = -1
    var trueCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        trueButton.layer.cornerRadius = 20.0
        trueButton.layer.borderWidth = 6.0
        trueButton.layer.borderColor = CGColor(red: 0.0, green: 15.0, blue: 150.0, alpha: 0.5)
        falseButton.layer.cornerRadius = 20.0
        falseButton.layer.borderWidth = 6.0
        falseButton.layer.borderColor = CGColor(red: 0.0, green: 15.0, blue: 150.0, alpha: 0.5)
        
        tryAgain.isEnabled = false
        progressBar.setProgress(0.0, animated: true)
        
        
        for question in questions.keys {
            let components = question.components(separatedBy: " is ")
            if let firstComponent = components.first {
                let countryComponents = firstComponent.components(separatedBy: "The capital city of ")
                if countryComponents.count > 1 {
                    let countryName = countryComponents[1]
                    countryNames.append(countryName)
                }
            }
        }
        changeQuestion()
        
    }
    @IBAction func buttons(_ sender: UIButton) {
        index += 1
        if index<questions.count-1 {
            if sender.titleLabel!.text!.lowercased() ==
                String(questions[keysArray[index]]!) {
                trueCount += 1
                sender.backgroundColor = UIColor.green
            }
            else{
                sender.backgroundColor = UIColor.red
            }
            Timer.scheduledTimer (timeInterval: 0.2, target:self, selector:
                #selector (changeQuestion), userInfo:nil, repeats: false)
            
        }else{
            if sender.titleLabel!.text!.lowercased() ==
                String(questions[keysArray[index]]!) {
                trueCount += 1
            }
            flag.image = nil
            textLabel.text = "Your total point is  \(trueCount)/\(keysArray.count)"
            trueButton.isHidden = true
            falseButton.isHidden = true
            tryAgain.isEnabled = true
        }
        progressBar.setProgress((Float(index)+1)/Float(keysArray.count), animated: true)
    }
    @IBAction func tryAgain(_ sender: UIButton) {
        index = -1
        trueCount = 0
        falseButton.isHidden = false
        trueButton.isHidden = false
        changeQuestion()
        tryAgain.isEnabled = false
        progressBar.setProgress(0.0, animated: true)
    }
    
    @objc func changeQuestion(){
        var country = countryNames[0]
        if index == -1 {
            textLabel.text = keysArray[0]
        }else if index<questions.count-1{
            textLabel.text = keysArray[index+1]
            country = countryNames[index+1]
        }
        flag.image = UIImage(named: country)
        trueButton.backgroundColor = UIColor.clear
        falseButton.backgroundColor = UIColor.clear
        
        

    }

}

