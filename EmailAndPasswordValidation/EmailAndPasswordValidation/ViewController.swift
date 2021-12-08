//
//  ViewController.swift
//  EmailAndPasswordValidation
//
//  Created by Hayk Aghavelyan on 08.12.21.
//

import UIKit

class ViewController: UIViewController {
    
    enum Constants {
        static let emailCorrectText = "Correct email"
        static let passCorrectText = "Correct pass"
        static let successVC = "successVC"
    }
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passTxtField: UITextField!
    @IBOutlet weak var emailHint: UILabel!
    @IBOutlet weak var passHint: UILabel!
    
    var passRegex = RegexFor(patterns: [Regex(name: #"(?=.{8,})"#, desc: "At least 8 characters"),
                                Regex(name: #"(?=.*[A-Z])"#, desc: "At least one capital letter"),
                                Regex(name: #"(?=.*[a-z])"#, desc: "At least one lowercase letter"),
                                Regex(name: #"(?=.*\d)"#, desc: "At least one digit"),
                                Regex(name: #"(?=.*[ !$%&?._-])"#, desc: "At least one special character")])
  
    var emailRegex = RegexFor(patterns: [Regex(name: #"^\S+@\S+\.\S+$"#, desc: "Correct email example: test@test.com")])
    
    private func setUpUI() {
        emailHint.isHidden = true
        passHint.isHidden = true
    }
    
    private func addTargets() {
        emailTxtField.addTarget(self, action: #selector(ViewController.emailTxtFieldDidChange(_:)),for: .editingChanged)
        passTxtField.addTarget(self, action: #selector(ViewController.passTxtFieldDidChange(_:)), for: .editingChanged)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUI()
        addTargets()
        hideKeyboardWhenTappedAround()
    }

    
    
    @objc func emailTxtFieldDidChange(_ textField: UITextField) {
       guard let text = textField.text else { return }
        emailHint.isHidden = false
        if emailRegex.validation(of: text) {
            emailHint.text = Constants.emailCorrectText
            emailHint.textColor = .green
        } else {
            emailHint.text = emailRegex.error
            emailHint.textColor = .red
        }
       
    }
    
    @objc func passTxtFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        passHint.isHidden = false
        if passRegex.validation(of: text) {
            passHint.text = Constants.passCorrectText
            passHint.textColor = .green
        } else {
            passHint.text = passRegex.error
            passHint.textColor = .red
        }
        
    }
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        if emailHint.text == Constants.emailCorrectText && passHint.text == Constants.passCorrectText {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: Constants.successVC)
            if let vc = vc {
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

