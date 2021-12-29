//
//  ViewController.swift
//  project-2
//
//  Created by Rogério Tavares on 25/12/21.
//

import UIKit

enum Answer {
    case correct
    case wrong
}

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var round = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showScore))
    }
    
    @objc func showScore() {
        let alertController = UIAlertController(title: "Score", message: score.formatted(), preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Close", style: .cancel))
        
        present(alertController, animated: true)
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        round += 1
        
        updateTitle()
    }
    
    func updateTitle() {
        title = "\(countries[correctAnswer].uppercased()) - Round: \(round)"
    }
    
    func getTitle(_ answer: Answer) -> String {
        if answer == .correct {
            return "Correct"
        } else {
            return "Wrong"
        }
    }
    
    func getMessage(_ answer: Answer) -> String {
        if answer == .correct {
            return "Your score is \(score)"
        } else {
            return "That’s the flag of \(countries[correctAnswer].capitalized)"
        }
    }
    
    func resetGame(_ answer: Answer) -> UIAlertController {
        if answer == .correct {
            score += 1
        } else {
            if score > 0 {
                score -= 1
            } else {
                score = 0
            }
        }
        
        let title = getTitle(answer)
        let message = getMessage(answer)
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: askQuestion))
        
        score = 0
        round = 0
        
        return ac
    }
    
    func verifyAnswer(tag: Int) -> Answer {
        if tag == correctAnswer {
            return .correct
        } else {
            return .wrong
        }
    }
    
    func nextRound(_ answer: Answer) -> UIAlertController {
        if answer == .correct {
            score += 1
        } else {
            if score > 0 {
                score -= 1
            } else {
                score = 0
            }
        }
        
        let title = getTitle(answer)
        let message = getMessage(answer)
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        updateTitle()
        
        return ac
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var ac: UIAlertController
        let answer = verifyAnswer(tag: sender.tag)
        
        if round < 10 {
            ac = nextRound(answer)
        } else {
            ac = resetGame(answer)
        }
        
        present(ac, animated: true)
    }
    
}

