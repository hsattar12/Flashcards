//
//  ViewController.swift
//  Flashcards
//
//  Created by Heba Sattar on 2/15/20.
//  Copyright © 2020 Heba Sattar. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
    var extra1: String
    var extra2: String
}

class ViewController: UIViewController {

    
    @IBOutlet weak var QuestionLabel: UILabel!
    @IBOutlet weak var AnswerLabel: UILabel!
    @IBOutlet weak var Card: UIView!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    //Array to hold flashcards
    var flashcards = [Flashcard]()
    var currentIndex = 0
    var correctAnswerButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //First make flshcard slightly smaller and invisible
        Card.alpha = 0.0
        Card.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        button1.alpha = 0.0
        button1.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        button2.alpha = 0.0
        button2.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        button3.alpha = 0.0
        button3.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        //Animate
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.Card.alpha = 1.0
            self.Card.transform = CGAffineTransform.identity
            self.button1.alpha = 1.0
            self.button1.transform = CGAffineTransform.identity
            self.button2.alpha = 1.0
            self.button2.transform = CGAffineTransform.identity
            self.button3.alpha = 1.0
            self.button3.transform = CGAffineTransform.identity
        })
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Card.layer.cornerRadius = 20.0
        Card.layer.shadowRadius = 15.0
        Card.layer.shadowOpacity = 0.2
        //Card.clipsToBounds = true
        QuestionLabel.clipsToBounds = true
        QuestionLabel.layer.cornerRadius = 20.0
        AnswerLabel.clipsToBounds = true
        AnswerLabel.layer.cornerRadius = 20.0
        
        button1.layer.cornerRadius = 10.0
        button2.layer.cornerRadius = 10.0
        button3.layer.cornerRadius = 10.0
        
        button1.layer.borderWidth = 3.0
        button1.layer.borderColor = #colorLiteral(red: 0, green: 0.6222990155, blue: 0.6969066262, alpha: 1)
        button2.layer.borderWidth = 3.0
        button2.layer.borderColor = #colorLiteral(red: 0, green: 0.6222990155, blue: 0.6969066262, alpha: 1)
        button3.layer.borderWidth = 3.0
        button3.layer.borderColor = #colorLiteral(red: 0, green: 0.6222990155, blue: 0.6969066262, alpha: 1)

        //Bring back saved flashcards
        readSavedFlashCards()
        
        //Add initial if needed
        if flashcards.count == 0 {
            updateFlashCard(question: "Who won the first FIFA World Cup?", answer: "Uruguay", extraAns1: "Argentina", extraAns2: "Paraguay", isExisting: false)
        }
        
        else {
            updateLabels()
            
            updateNextPrevButtons()
        }

    }
    
    @IBAction func didTapFlashCard(_ sender: Any) {
        flipFlashcard()
    }
    
    func flipFlashcard() {
        
        UIView.transition(with: Card, duration: 0.3, options: .transitionFlipFromRight, animations: {
            if (self.QuestionLabel.isHidden) {
                self.QuestionLabel.isHidden = false
            }
            else {
                self.QuestionLabel.isHidden = true
                }
        })
        
    }
    
    @IBAction func didTapButtonOne(_ sender: Any) {
        if button1 == correctAnswerButton {
            flipFlashcard()
        }
        else {
            AnswerLabel.isHidden = false
            button1.isEnabled = false
            
        }
        
    }
    
    
    @IBAction func didTapButtonTwo(_ sender: Any) {
        if button2 == correctAnswerButton {
            flipFlashcard()
        }
        else {
            AnswerLabel.isHidden = false
            button2.isEnabled = false
            
        }
    }
    
    
    @IBAction func DidTapButtonThree(_ sender: Any) {
        if button3 == correctAnswerButton {
            flipFlashcard()
        }
        else {
            AnswerLabel.isHidden = false
            button3.isEnabled = false
            
        }
    }
    
    @IBAction func didTapPrev(_ sender: Any) {
        QuestionLabel.isHidden = false
        button1.isEnabled = true
        button2.isEnabled = true
        button3.isEnabled = true
        
        //Decrease Current Index
        currentIndex = currentIndex - 1
        
        //Update buttons
        updateNextPrevButtons()
        
        animateCardOutPrev()
    }
    
    @IBAction func didTapNext(_ sender: Any) {
        QuestionLabel.isHidden = false
        button1.isEnabled = true
        button2.isEnabled = true
        button3.isEnabled = true
        
        //Increase Current Index
        currentIndex = currentIndex + 1
        
        //Update buttons
        updateNextPrevButtons()
        
        animateCardOut()
    }
    
    func updateFlashCard(question: String, answer: String, extraAns1: String, extraAns2: String, isExisting: Bool) {
        
        let flashcard = Flashcard(question: question, answer: answer, extra1: extraAns1, extra2: extraAns2)
        
//        QuestionLabel.text = flashcard.question
//        AnswerLabel.text = flashcard.answer
        
        if isExisting {
            flashcards[currentIndex] = flashcard
            
        }

        else {
        //Adding flashcards to the flashcards array
            flashcards.append(flashcard)

        //Logging to Console
            print("😎 Added new Flashcard")
            print("😎 We know have \(flashcards.count) flashcards")
            currentIndex = flashcards.count - 1
            print("🥳 Our Current Index is \(currentIndex)")
        }
        
        updateNextPrevButtons()
        updateLabels()
        button1.setTitle(extraAns1, for: .normal)
        button2.setTitle(answer, for: .normal)
        button3.setTitle(extraAns2, for: .normal)
        
        saveAllFlashcardsToDisk()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self
        if segue.identifier == "EditSegue" {
            creationController.initialQuestion = QuestionLabel.text
            creationController.initialAnswer = AnswerLabel.text
            creationController.initialans1 = button1.titleLabel?.text
            creationController.initialans2 = button3.titleLabel?.text
        
        }
        //else {
         //   creationController.initialQuestion = "Question"
        //    creationController.initialAnswer = "Answer"
       // }
        
    }
    
    func updateNextPrevButtons() {
        //disable next button if at end
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        }
        else {
            nextButton.isEnabled = true
        }
        
        //disable prev button if at the beginning
        if currentIndex == 0 {
            prevButton.isEnabled = false
        }
        else {
            prevButton.isEnabled = true
        }
    }
    
    func updateLabels() {
        //get Current Flashcard
        let currentFlashcard = flashcards[currentIndex]
        
        //Update Labels
        QuestionLabel.text = currentFlashcard.question
        AnswerLabel.text = currentFlashcard.answer
        
        let buttons = [button1, button2, button3].shuffled()
        let answers = [currentFlashcard.answer, currentFlashcard.extra1, currentFlashcard.extra2].shuffled()
        
        for (button, answer) in zip(buttons,answers) {
            button?.setTitle(answer, for: .normal)
            if answer == currentFlashcard.answer {
                correctAnswerButton = button
            }
        }
//        button1.setTitle(currentFlashcard.extra1, for: .normal)
//        button2.setTitle(currentFlashcard.answer, for: .normal)
//        button3.setTitle(currentFlashcard.extra2, for: .normal)
        //button1.setTitle(extraAns1, for: .normal)
        //        button2.setTitle(answer, for: .normal)
        //        button3.setTitle(extraAns2, for: .normal)
        
    }
    
    func saveAllFlashcardsToDisk() {
        
        //from flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String:String] in return
            ["question": card.question, "answer": card.answer, "extra1": card.extra1, "extra2": card.extra2]
        }
        //Save array on disk using UserDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        //Log it
        print("🎉 Flashcards saved to UserDefaults")
        
    }
    
    func readSavedFlashCards() {
        
        //Read Dictionary Array from the disk
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            //we have a dictionary array
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, extra1: dictionary["extra1"]!, extra2: dictionary["extra2"]!)}
            
            //put all these cards into our flashcards array
            flashcards.append(contentsOf: savedCards)
    
    }
    }
    
    @IBAction func didTapDelete(_ sender: Any) {
        if flashcards.count == 1 {
            let alert = UIAlertController(title: "Error", message: "You cannot delete your only flashcard", preferredStyle: .alert)
            present(alert, animated: true)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
        }
        else {
        //show confirmation
            let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure you want to delete it?", preferredStyle: .actionSheet)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
                self.deleteCurrentFlashcard()
            }
            alert.addAction(deleteAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        }
    }
    
    func deleteCurrentFlashcard() {
        flashcards.remove(at: currentIndex)


        //Special Case: Last card deleted
        if currentIndex > flashcards.count - 1 {
            currentIndex = flashcards.count - 1
        
    }

        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
    }
    
    func animateCardOut() {
        UIView.animate(withDuration: 0.2, animations: {
            self.Card.transform = CGAffineTransform.identity.translatedBy(x: -400.0, y: 0.0)
        }, completion: {finished in
            
            //UpdateLabel
            self.updateLabels()
            
            self.animateCardIn()
        })
    }
    
    func animateCardIn() {
        //Start on right side, not animated
        Card.transform = CGAffineTransform.identity.translatedBy(x: 400.0, y: 0.0)
        
        //Card goes to original position
        UIView.animate(withDuration: 0.2) {
            self.Card.transform = CGAffineTransform.identity
        }
    }

    func animateCardOutPrev() {
        UIView.animate(withDuration: 0.2, animations: {
            self.Card.transform = CGAffineTransform.identity.translatedBy(x: 400.0, y: 0.0)
        }, completion: {finished in
            
            //UpdateLabel
            self.updateLabels()
            
            self.animateCardInPrev()
        })
    }
    
    func animateCardInPrev() {
        //Start on right side, not animated
        Card.transform = CGAffineTransform.identity.translatedBy(x: -400.0, y: 0.0)
        
        //Card goes to original position
        UIView.animate(withDuration: 0.2) {
            self.Card.transform = CGAffineTransform.identity
        }
    }
    
}
