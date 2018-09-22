//
//  RegiesterationController.swift
//  Kotob
//
//  Created by Mokhtar on 9/19/18.
//  Copyright © 2018 Mokhtar. All rights reserved.
//

import UIKit

class RegisterationController : UIViewController, UITextFieldDelegate{
    
    
    var textFieldsDict = [Int : UITextField]()
    var seperatorViewsDict = [Int : UIView]()
    var placholderLabels = [Int : UILabel]()
    
    let placeholdersArray = ["الإسم الأول" , "الإسم الأخير", "البريد الإلكتروني", "كلمة السر" , "تأكيد كلمة السر"]
    
    let dismissButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "fill3"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.nagwaOrange
        button.layer.cornerRadius = 18
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.nagwaOrange.cgColor
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    let passwordMismatchLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.textStyle
        label.text = "كلمات المرور غير متطابقة"
        label.textColor = .red
        label.isHidden = true
        return label
    }()
    
    let errorImageView : UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "iconError"))
        imgView.contentMode = .scaleAspectFill
        imgView.isHidden = true
        return imgView
    }()
    
    
    let registerationButton : UIButton = {
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let attributedString = NSAttributedString(string: "سجل", attributes: [.font:UIFont.textStyle, .foregroundColor : UIColor.white])
        button.setAttributedTitle(attributedString, for: .normal)
        button.backgroundColor = UIColor.nagwaOrange
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.nagwaOrange.cgColor
        button.addTarget(self, action: #selector(handleRegiesteration), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleRegiesteration() {
        guard let url = URL(string: "https://www.hindawi.org/users/signup/") else { return }
        let payloadKeys = ["FirstName", "LastName", "Email", "Password"]
        var u = [String : String]()
        for i in 0...3 {
            guard let text = textFieldsDict[i + 1]?.text else { return }
            u[payloadKeys[3 - i]] = text
        }
        let registerationDict : [String : [String : String]] = ["userModel" : u]
        print(registerationDict)
        HindawiAPI.postBody(to: url, of: registerationDict) { (regResponse) in
            self.validateRegesteration(registeration: regResponse)
        }
        
    }
    
    fileprivate func validateRegesteration(registeration response : RegisterationResponse) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        view.backgroundColor = .white
        setUpRegisterationButton()
        setUpDismissButton()
        viewsGenerator()
        setupPasswordMismatchViews()
        addKeyboardObservers()
        addKeyboardDismessGesture()
        setupPlaceHolders()
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
        
        dismissButtonTopConstraint?.constant = 20
        registerrationButtonBottomAnchor?.constant = -20
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    
    @objc func handleKeyboardAppearance(notification : NSNotification) {
        if let info = notification.userInfo, let keyboardFrame = info[UIKeyboardFrameEndUserInfoKey] as? CGRect {
            let heightOffset = keyboardFrame.height
            dismissButtonTopConstraint?.constant = -heightOffset + 100
            registerrationButtonBottomAnchor?.constant = -heightOffset
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    fileprivate func addKeyboardDismessGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissLeyboard))
        view.addGestureRecognizer(gesture)
    }
    
    
    
    @objc fileprivate func dismissLeyboard() {
        view.endEditing(false)
    }
    
    
    
    @objc fileprivate func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    fileprivate func setUpConstraint(_ textFiled: UITextField, _ i: Int, _ seperatorView: UIView, _ placeHolderLabel : UILabel) {
        view.addSubview(seperatorView)
        seperatorViewsDict[i] = seperatorView
        
        view.addSubview(textFiled)
        textFieldsDict[i] = textFiled
        
        view.addSubview(placeHolderLabel)
        placholderLabels[i] = placeHolderLabel
        
        if i == 0 {
            seperatorView.bottomAnchor.constraint(equalTo: registerationButton.topAnchor, constant: -89.5).isActive = true
        } else {
            seperatorView.bottomAnchor.constraint(equalTo: (textFieldsDict[i - 1]?.topAnchor)!, constant: -10).isActive = true
        }
        seperatorView.setupXYAnchors(leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, leadingConstant: 20, trailingConstant: -20)
        seperatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        
        textFiled.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        textFiled.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        textFiled.heightAnchor.constraint(equalToConstant: 44).isActive = true
        textFiled.bottomAnchor.constraint(equalTo: seperatorView.topAnchor, constant: -10).isActive = true
        
        
    }
    
    fileprivate func viewsGenerator() {
        for i in 0...4 {
            let textFiled : UITextField = {
                let tf = UITextField()
                tf.placeholder = placeholdersArray[4 - i]
                tf.autocorrectionType = UITextAutocorrectionType.no
                tf.textAlignment = .right
                tf.delegate = self
                tf.translatesAutoresizingMaskIntoConstraints = false
                return tf
            }()
            
            if i < 2 {
                textFiled.isSecureTextEntry = true
            }
            
            let seperatorView : UIView = {
                let seperatorView = UIView()
                seperatorView.backgroundColor = UIColor(r: 221, g: 221, b: 221)
                seperatorView.translatesAutoresizingMaskIntoConstraints = false
                return seperatorView
            }()
            
            let placeHolderLabel : UILabel = {
                let label = UILabel()
                label.text = placeholdersArray[4 - i]
                label.font = .textStyle
                label.textColor = UIColor(r: 165, g: 165, b: 165)
                label.isHidden = true
                return label
            }()
            
            setUpConstraint(textFiled, i, seperatorView, placeHolderLabel)
        }
    }
    

    var registerrationButtonBottomAnchor : NSLayoutConstraint?
    
    
    fileprivate func setUpRegisterationButton() {
        view.addSubview(registerationButton)
        registerationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        registerationButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        registerrationButtonBottomAnchor = registerationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        registerrationButtonBottomAnchor?.isActive = true
        registerationButton.heightAnchor.constraint(equalToConstant: 42).isActive = true
    }
    
    fileprivate func setUpDismissButton() {
        view.addSubview(dismissButton)
        dismissButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: 67 + 20).isActive = true
        dismissButtonTopConstraint = dismissButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        dismissButtonTopConstraint?.isActive = true
        dismissButton.setupXYAnchors(leading: view.safeAreaLayoutGuide.leadingAnchor, leadingConstant: -20)
    }
    
    var dismissButtonTopConstraint: NSLayoutConstraint?
    
    fileprivate func setupPasswordMismatchViews() {
        view.addSubview(errorImageView)
        view.addSubview(passwordMismatchLabel)
        
        errorImageView.setupXYAnchors(top: seperatorViewsDict[0]?.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, topConstant: 6.5, trailingConstant: -20)
        errorImageView.widthAnchor.constraint(equalToConstant: 18.4).isActive = true
        errorImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        passwordMismatchLabel.setupXYAnchors( trailing: errorImageView.leadingAnchor,centerY: errorImageView.centerYAnchor, trailingConstant: -4.5)
        passwordMismatchLabel.widthAnchor.constraint(equalToConstant: 151).isActive = true
        passwordMismatchLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    fileprivate func setupPlaceHolders() {
        for i in 0...4 {
            placholderLabels[4 - i]?.setupXYAnchors(bottom: seperatorViewsDict[4 - i]?.topAnchor, leading: view.leadingAnchor, bottomConstant: -35, leadingConstant: 20)
        }
    }
    
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
    
    var counterArrays = [0, 0, 0, 0, 0]
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true }
        
        for i in 0...4 {
            if textField == textFieldsDict[i] {
                showHidePlaceHolders(text: text, counter: counterArrays[i], placeHolderLabel: placholderLabels[i]!)
                counterArrays[i] = text.count
                
            }
        }
        
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let password = textFieldsDict[0]?.text , let confirmedPassword = textFieldsDict[1]?.text {
            if password != confirmedPassword {
                errorImageView.isHidden = false
                passwordMismatchLabel.isHidden = false
                registerationButton.isEnabled = false
            } else {
                errorImageView.isHidden = true
                passwordMismatchLabel.isHidden = true
                registerationButton.isEnabled = true
            }
        }
    }
    
}
