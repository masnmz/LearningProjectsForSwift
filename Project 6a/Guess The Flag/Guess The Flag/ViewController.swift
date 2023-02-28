//
//  ViewController.swift
//  Guess The Flag
//
//  Created by Mehmet Alp Sönmez on 24.12.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
   

    
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        let showScore = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(showScore))
     
        theQuestion()
        navigationItem.rightBarButtonItem = showScore
        
        // Do any additional setup after loading the view.
    }
    func theQuestion(action: UIAlertAction! = nil){
//        guard questionCounter != 11 else {exit(0)}
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        title = countries[correctAnswer].uppercased() + " , " + " Score : \(score)"
        questionCounter += 1
        if questionCounter == 11{
            let alert2 = UIAlertController(title: "Final Score", message: "\(score)", preferredStyle: .alert)
            alert2.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: theQuestion))
            present(alert2, animated: true)
            questionCounter = 0
            score = 0
            
        }
        
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title : String
        
        if sender.tag == correctAnswer{
            title = "Correct!"
            score += 1
        }else{
            title = "Wrong!"
            score -= 1
            let alert2 = UIAlertController(title: title, message: "That is the flag of \(countries[sender.tag].uppercased())", preferredStyle: .alert)
            alert2.addAction(UIAlertAction(title: "Continue", style: .default, handler: theQuestion))
            present(alert2, animated: true)
        }
        let alert = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: theQuestion))
        present(alert, animated: true)
        
    }
 
    @objc func showScore(){
        let alertScore = UIAlertController(title: "Your Score is", message: "\(score)", preferredStyle: .alert)
        alertScore.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        present(alertScore, animated: true)
    }

}

