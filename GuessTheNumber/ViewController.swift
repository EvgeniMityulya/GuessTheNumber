//
//  ViewController.swift
//  GuessTheNumber
//
//  Created by Евгений Митюля on 1/5/24.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var randomNumberLabel: UILabel!
    @IBOutlet weak var attempsLabel: UILabel!
    @IBOutlet weak var winLostLabel: UILabel!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var hideShowSwitch: UISwitch!
    
    private let range = 10
    
    var randomNumber: Int {
        didSet {
            UserDefaults.standard.setValue(randomNumber, forKey: UserDefaultsKeys.randomNum.rawValue)
        }
    }
    
    var win: Int {
        didSet {
            UserDefaults.standard.setValue(win, forKey: UserDefaultsKeys.win.rawValue)
        }
    }
    
    var lost: Int {
        didSet {
            UserDefaults.standard.setValue(lost, forKey: UserDefaultsKeys.lost.rawValue)
        }
    }
    
    var attemps: Int {
        didSet {
            UserDefaults.standard.setValue(attemps, forKey: UserDefaultsKeys.attempsAmount.rawValue)
        }
    }
    var switchStatus: Bool {
        didSet {
            UserDefaults.standard.setValue(switchStatus, forKey: UserDefaultsKeys.switchStatus.rawValue)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        let defaults: [String: Any] = [
            UserDefaultsKeys.randomNum.rawValue: 0,
            UserDefaultsKeys.attempsAmount.rawValue: 0,
            UserDefaultsKeys.win.rawValue: 0,
            UserDefaultsKeys.lost.rawValue: 0,
            UserDefaultsKeys.switchStatus.rawValue: false,
            UserDefaultsKeys.isNewGame.rawValue: true
        ]
        
        UserDefaults.standard.register(defaults: defaults)
        
        self.randomNumber = UserDefaults.standard.integer(forKey: UserDefaultsKeys.randomNum.rawValue)
        self.win = UserDefaults.standard.integer(forKey: UserDefaultsKeys.win.rawValue)
        self.lost = UserDefaults.standard.integer(forKey: UserDefaultsKeys.lost.rawValue)
        self.attemps = UserDefaults.standard.integer(forKey: UserDefaultsKeys.attempsAmount.rawValue)
        self.switchStatus = UserDefaults.standard.bool(forKey: UserDefaultsKeys.switchStatus.rawValue)
        
        super.init(coder: aDecoder)
        
    }
    
    @IBAction func guessButtonTapped(_ sender: Any) {
        guard let numberStr = numberTextField.text, !numberStr.isEmpty else { return }
        guard let number = Int(numberStr) else { return }
        
        if self.randomNumber == number {
            self.win += 1
            UserDefaults.standard.setValue(self.win, forKey: UserDefaultsKeys.win.rawValue)
            generateIntNum(self.range)
            print("Success")
        } else {
            self.lost += 1
            UserDefaults.standard.setValue(self.lost, forKey: UserDefaultsKeys.lost.rawValue)
            print("Lost")
        }
        self.attemps += 1
        attempsLabel.text = String(self.attemps)
        winLostLabel.text = "\(self.win)/\(self.lost)"
        UserDefaults.standard.setValue(self.attemps, forKey: UserDefaultsKeys.attempsAmount.rawValue)
    }
    
    @IBAction func switchValueChanged(_ sender: Any) {
        let switchStatus = hideShowSwitch.isOn
        randomNumberLabel.isHidden = switchStatus ? false : true
        print(switchStatus)
        UserDefaults.standard.setValue(switchStatus, forKey: UserDefaultsKeys.switchStatus.rawValue)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkFirstLaunch()
        configureUI()
    }
    
    private func configureUI() {
        randomNumberLabel.text = String(self.randomNumber)
        attempsLabel.text = String(self.attemps)
        winLostLabel.text = "\(self.win)/\(self.lost)"
        randomNumberLabel.isHidden = self.switchStatus ? false : true
        hideShowSwitch.isOn = self.switchStatus
    }
    
    private func generateIntNum(_ lastNum: Int) {
        let number = Int.random(in: 1...lastNum)
        self.randomNumber = number
        randomNumberLabel.text = String(self.randomNumber)
        UserDefaults.standard.setValue(number, forKey: UserDefaultsKeys.randomNum.rawValue)
        print(number)
    }
    
    private func checkFirstLaunch() {
        if UserDefaults.standard.bool(forKey: UserDefaultsKeys.isNewGame.rawValue) {
            print("First launch")
            UserDefaults.standard.set(false, forKey: UserDefaultsKeys.isNewGame.rawValue)
            generateIntNum(self.range)
        }
    }
}

