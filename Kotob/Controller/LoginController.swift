//
//  LoginController.swift
//  Kotob
//
//  Created by Mokhtar on 9/18/18.
//  Copyright © 2018 Mokhtar. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate {
    
    fileprivate func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self , selector: #selector(handleKeyboardAppearance), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDisappearance), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        view.backgroundColor = .white
        setupViewConstraints()
        addKeyboardDismessGesture()
        addKeyboardObservers()
        addTargetActionToButtons()
        setupTextFieldsDelegate()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        removeKeyboardObservers()
    }
    
    fileprivate func setupTextFieldsDelegate() {
        loginView.mailTextFailed.delegate = self
        loginView.passwordTextFiled.delegate = self
    }
    
    
    
    fileprivate func addTargetActionToButtons() {
        loginView.guestButton.addTarget(self, action: #selector(continueAsGuest), for: .touchUpInside)
        loginView.loginButton.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        loginView.regiesterationButton.addTarget(self, action: #selector(handleRegisteration), for: .touchUpInside)
        loginView.forgotPasswordButton.addTarget(self, action: #selector(presentForgotPassword), for: .touchUpInside)
    }
    
    fileprivate func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    fileprivate func addKeyboardDismessGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(gesture)
    }
    
    @objc fileprivate func dismissKeyboard() {
        view.endEditing(false)
    }
    
    
    @objc fileprivate func presentForgotPassword() {
        let forgotPassowrdController = ForgotPasswordControllerr()
        present(forgotPassowrdController, animated: true, completion: nil)
    }
    
    
    
    let loginView : LoginView = {
        let logView = LoginView()
        return logView
    }()
    
    
    fileprivate func setupViewConstraints() {
        view.addSubview(loginView)
        loginView.setupXYAnchors(top: view.safeAreaLayoutGuide.topAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor ,leading: view.leadingAnchor, trailing: view.trailingAnchor)
    }
    
    @objc fileprivate func handleLoginButton() {
        
        guard let mail = loginView.mailTextFailed.text else { return }
        guard let password = loginView.passwordTextFiled.text else { return }
        let jsonDict   =
        [ "userModel" : ["Email" : mail, "Password" : password]]
        guard let url = URL(string: "https://www.hindawi.org/users/signin/") else { return }
        HindawiAPI.postBody(to: url, of: jsonDict) { (loginResponse) in
            self.validateMail(loginResponse)
        }
        
    }
    
    @objc fileprivate func handleRegisteration() {
        let registerationController = RegisterationController()
        present(registerationController, animated: true, completion: nil)
    }
    
    fileprivate func validateMail(_ loginResponse: LoginResponse) {
        DispatchQueue.main.async {
            if !loginResponse.confirmed! {
                
                self.loginView.firstSeperatorView.backgroundColor = .red
                self.loginView.errorImageView.isHidden = false
                self.loginView.doneImageView.isHidden = true
                self.loginView.mailTextFailed.textColor = .red
                
                
            } else if loginResponse.confirmed! {
                
                self.loginView.firstSeperatorView.backgroundColor = UIColor.nagwaOrange
                self.loginView.errorImageView.isHidden = true
                self.loginView.doneImageView.isHidden = false
                self.loginView.mailTextFailed.textColor = .gray
                self.present(MainTabBarController(), animated: true)
            }
        }
        
    }
    
    
    @objc func handleKeyboardDisappearance(notification : NSNotification) {
       
        loginView.registerationButtonBottomAnchor?.constant = -30
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    @objc func handleKeyboardAppearance(notification : NSNotification) {
        if let info = notification.userInfo, let keyboardFrame = info[UIKeyboardFrameEndUserInfoKey] as? CGRect {
            let heightOffset = keyboardFrame.height
            loginView.registerationButtonBottomAnchor?.constant = -heightOffset
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc fileprivate func continueAsGuest() {
        self.present(MainTabBarController(), animated: true)

    }
    fileprivate func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    var charactersCountForMailTextFiled = 0
    var charactersCountForPasswordTextFiled = 0
    
    fileprivate func showHidePlaceHolders(text: String, counter: Int, placeHolderLabel : UILabel) {
        if (counter == 0 && text.count == 0) || (counter == 1 && text.count == 0){
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                placeHolderLabel.isHidden = false
            }, completion: nil)
        } else if (counter == 2 && text.count == 1) {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                placeHolderLabel.isHidden = true
            }, completion: nil)
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true }
        
        if textField == loginView.mailTextFailed {
            showHidePlaceHolders(text: text, counter: charactersCountForMailTextFiled, placeHolderLabel: loginView.mailPlaceHolderLabel)
            print(text.count, charactersCountForMailTextFiled)
            charactersCountForMailTextFiled = text.count
            
            if isValidEmail(testStr: text) {
                loginView.doneImageView.isHidden = false
                loginView.firstSeperatorView.backgroundColor = .nagwaOrange
            } else {
                loginView.doneImageView.isHidden = true
                loginView.firstSeperatorView.backgroundColor = UIColor(r: 221, g: 221, b: 221)
            }
            
        } else if textField == loginView.passwordTextFiled {
            showHidePlaceHolders(text: text, counter: charactersCountForPasswordTextFiled, placeHolderLabel: loginView.passwordPlaceHolderLabel)
            print(text.count, charactersCountForPasswordTextFiled)
            charactersCountForPasswordTextFiled = text.count
            
        }
        
        return true
    }
    
}
