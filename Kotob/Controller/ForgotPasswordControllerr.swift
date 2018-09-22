//
//  ForgotPasswordControllerr.swift
//  Kotob
//
//  Created by Mokhtar on 9/20/18.
//  Copyright © 2018 Mokhtar. All rights reserved.
//

import UIKit

class ForgotPasswordControllerr : UIViewController {
    
    let logo : UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(named: "iconForget")
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    let resetButton : UIButton = {
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let attributedString = NSAttributedString(string: "إعادة كلمة السر", attributes: [.font:UIFont.textStyle, .foregroundColor : UIColor.white])
        button.setAttributedTitle(attributedString, for: .normal)
        button.backgroundColor = UIColor.nagwaOrange
        button.layer.cornerRadius = 21
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.nagwaOrange.cgColor
        button.addTarget(self, action: #selector(handleResetButton), for: .touchUpInside)
        return button
    }()
    
    let mailTextFiled : UITextField = {
        let tf = UITextField()
        tf.placeholder = "البريد الإلكتروني"
        tf.textAlignment = .right
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let seperatorView : UIView = {
        let seperatorView = UIView()
        seperatorView.backgroundColor = UIColor(r: 221, g: 221, b: 221)
        seperatorView.translatesAutoresizingMaskIntoConstraints = false
        return seperatorView
    }()
    
    @objc fileprivate func handleResetButton() {
        guard let mail = mailTextFiled.text else { return }
        guard let url = URL(string: "https://www.hindawi.org/users/forgotpassword/") else { return }
        let mailDict = ["email" : mail]
        HindawiAPI.postBody(to: url, of: mailDict) { (response) in
            self.validateForgetResponse(response: response)
        }
        
    }
    
    fileprivate func validateForgetResponse(response: ForgetResponse) {
        print(response.success ?? "response changed")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        view.backgroundColor = .white
        setupResetButton()
        setupLineSeperator()
        setupmailTextField()
        setupLogo()
        
        addKeyboardDismessGesture()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
    
    
    fileprivate func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    fileprivate func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self , selector: #selector(handleKeyboardAppearance), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDisappearance), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    @objc func handleKeyboardDisappearance(notification : NSNotification) {
        
        resetBottonBottomAnchor?.constant = -20
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    
    @objc func handleKeyboardAppearance(notification : NSNotification) {
        if let info = notification.userInfo, let keyboardFrame = info[UIKeyboardFrameEndUserInfoKey] as? CGRect {
            let heightOffset = keyboardFrame.height
            resetBottonBottomAnchor?.constant = -heightOffset
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    fileprivate func addKeyboardDismessGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(gesture)
    }
    
    @objc fileprivate func dismissKeyboard() {
        view.endEditing(false)
    }
    
    var resetBottonBottomAnchor : NSLayoutConstraint?
    
    fileprivate func setupResetButton() {
        view.addSubview(resetButton)
        resetBottonBottomAnchor = resetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        resetBottonBottomAnchor?.isActive = true
        resetButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        resetButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        resetButton.heightAnchor.constraint(equalToConstant: 42).isActive = true
    }
    
    fileprivate func setupLineSeperator() {
        view.addSubview(seperatorView)
        seperatorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        seperatorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        seperatorView.bottomAnchor.constraint(equalTo: resetButton.topAnchor, constant: -157).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
    }
    
    fileprivate func setupmailTextField() {
        view.addSubview(mailTextFiled)
        mailTextFiled.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        mailTextFiled.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        mailTextFiled.bottomAnchor.constraint(equalTo: seperatorView.topAnchor).isActive = true
        mailTextFiled.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    fileprivate func setupLogo() {
        view.addSubview(logo)
        logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logo.bottomAnchor.constraint(equalTo: mailTextFiled.topAnchor, constant: -149.5).isActive = true
        logo.widthAnchor.constraint(equalToConstant: 108).isActive = true
        logo.heightAnchor.constraint(equalToConstant: 89).isActive = true
        
    }
    
}
