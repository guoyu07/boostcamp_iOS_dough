//
//  PlayViewController.swift
//  OneToTwentyfive
//
//  Created by Kangsoo on 23/07/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {
    @IBOutlet weak var bestRecordLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet weak var buttonsStackView: UIStackView!
    @IBOutlet weak var historyButton: UIButton!
    
    weak var timer: Timer?
    var startTime: Double = 0.0
    var finishTime: Double = 0.0
    
    var targetNumber: Int = 1
    
    @IBAction func pressStartButton(_ sender: UIButton) {
        resetGame()
        disableHistoryButton()
        allocateNumbers()
        runTimer()
    }
    
    @IBAction func showBackToHome(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberButtons.forEach { numberButton in
            numberButton.addTarget(self, action: #selector(pressNumberButton(numberButton:)),
                                   for: .touchUpInside)
        }
    }
    
    private func resetGame() {
        timer?.invalidate()
        timerLabel.text = "00:00:00"
        targetNumber = 1
        
        startButton.isHidden = true
        buttonsStackView.isHidden = false
        
        let navyColor = UIColor(red: 44 / 255, green: 93 / 255, blue: 163 / 255, alpha: 1.0)
        numberButtons.forEach { numberButton in
            numberButton.isUserInteractionEnabled = true
            numberButton.setTitle("-", for: .normal)
            numberButton.backgroundColor = navyColor
        }
    }
    
    private func runTimer() {
        startTime = Date().timeIntervalSinceReferenceDate
        timer = Timer.scheduledTimer(timeInterval: 0.02,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc private func updateTimer() {
        finishTime = Date().timeIntervalSinceReferenceDate
        let timeGap = ((finishTime - startTime) * 1000)
        
        let minutes = (Int(timeGap) / 1000 / 60 % 60)
        let seconds = (Int(timeGap) / 1000 % 60)
        let milliSeconds = (Int(timeGap) % 1000 / 10)
        
        timerLabel.text = String(format: "%02d:%02d:%02d",
                                 arguments: [minutes, seconds, milliSeconds])
    }
    
    private func disableHistoryButton() {
        historyButton.isUserInteractionEnabled = false
        historyButton.alpha = 0.5
    }
    
    private func enableHistoryButton() {
        historyButton.isUserInteractionEnabled = true
        historyButton.alpha = 0.9
    }
    
    private func allocateNumbers() {
        var numbersArray = Array(1...25)
        numbersArray.shuffle()
        
        for (index, number) in numbersArray.enumerated() {
            numberButtons[index].setTitle(String(number), for: .normal)
        }
    }
    
    @objc private func pressNumberButton(numberButton: UIButton) {
        guard let stringTitle = numberButton.currentTitle else {
            print("The title of the button you pressed is nil.")
            return
        }
        
        let integerTitle = Int(stringTitle)
        
        guard integerTitle == targetNumber else {
            startTime -= 1.5
            return
        }
        numberButton.isUserInteractionEnabled = false
        numberButton.backgroundColor = UIColor.white
        targetNumber += 1
        
        if targetNumber > 25 {
            timer?.invalidate()
            
            buttonsStackView.isHidden = true
            startButton.isHidden = false
            enableHistoryButton()
            
            alertWhenClear()
        }
    }
    
    private func alertWhenClear() {
        let alertController = UIAlertController(title: "Clear!", message: "Enter your name",
                                                preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter your name"
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            guard let stringFromTextField = alertController.textFields?[0].text,
                !stringFromTextField.isEmpty else {
                    print("The String from text field is nil or empty.")
                    return
            }
            
            let userName = stringFromTextField
            let recordDate = self.formatDate(date: Date())
            guard let timeRecord = self.timerLabel.text else {
                print("The text from timer label is nil.")
                return
            }
            
            let newRecord = Record(userName, recordDate, timeRecord)
            dump(newRecord)
            
            self.updateBestRecord(record: newRecord)
        })
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func updateBestRecord(record: Record) {
        bestRecordLabel.text = "\(record.userName) \(record.timeRecord)"
    }
    
    private func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
        
        return dateFormatter.string(from: date)
    }
}

extension Array {
    mutating func shuffle()	{
        for _ in 0..<25 {
            sort { (_, _) in
                arc4random() < arc4random() }
        }
    }
}
