//
//  LoginView.swift
//  Kotob
//
//  Created by Mokhtar on 9/22/18.
//  Copyright © 2018 Mokhtar. All rights reserved.
//

import UIKit

class LoginView : UIView {
    
    let logo : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "logo")
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    lazy var mailTextFailed : UITextField = {
        let tf = UITextField()
        tf.placeholder = "البريد الإلكتروني"
        tf.textAlignment = .right
        tf.autocorrectionType = UITextAutocorrectionType.no
        return tf
    }()
    
    let mailPlaceHolderLabel : UILabel = {
        let label = UILabel()
        label.text = "البريد الإلكتروني"
        label.font = .textStyle
        label.textColor = UIColor(r: 165, g: 165, b: 165)
        label.isHidden = true
        return label
    }()
    
    let passwordPlaceHolderLabel : UILabel = {
        let label = UILabel()
        label.text = "كلمة السر"
        label.font = .textStyle
        label.textColor = UIColor(r: 165, g: 165, b: 165)
        label.isHidden = true
        return label
    }()
    
    let firstSeperatorView : UIView = {
        let seperatorView = UIView()
        seperatorView.backgroundColor = UIColor(r: 221, g: 221, b: 221)
        return seperatorView
    }()
    
    lazy var passwordTextFiled : UITextField = {
        let tf = UITextField()
        tf.placeholder = "كلمة السر"
        tf.isSecureTextEntry = true
        tf.autocorrectionType = UITextAutocorrectionType.no
        tf.textAlignment = .right
        return tf
    }()
    
    
    let secondSeperatorView : UIView = {
        let seperatorView = UIView()
        seperatorView.backgroundColor = UIColor(r: 221, g: 221, b: 221)
        return seperatorView
    }()
    
    
    let forgotPasswordButton : UIButton = {
        let button = UIButton(type: .system)
        let attributedString = NSAttributedString(string: "هل نسيت كلمة المرور؟", attributes: [.font : UIFont.textStyle])
        button.setAttributedTitle(attributedString, for: .normal)
        button.tintColor = UIColor(r: 165, g: 165, b: 165)
        return button
    }()
    
    
    let loginButton : KotobButton = {
        let button = KotobButton(type: .custom)
        let attributedStringForNormal = NSAttributedString(string: "تسجيل الدخول", attributes: [.font : UIFont.textStyle, .foregroundColor : UIColor.nagwaOrange])
        let attributedStringForHeighlited = NSAttributedString(string: "تسجيل الدخول", attributes: [.font : UIFont.textStyle, .foregroundColor : UIColor.white])
        button.setAttributedTitle(attributedStringForNormal, for: .normal)
        button.setAttributedTitle(attributedStringForHeighlited, for: .highlighted)
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(r: 255, g: 122, b: 79).cgColor
        return button
    }()
    
    
    let guestButton : KotobButton = {
        let button = KotobButton(type: .custom)
        let highlightedAttributedString = NSAttributedString(string: "المتابعة كضيف", attributes: [.font : UIFont.textStyle, .foregroundColor : UIColor.white])
        let attributedString = NSAttributedString(string: "المتابعة كضيف", attributes: [.font:UIFont.textStyle, .foregroundColor : UIColor.nagwaOrange])
        button.setAttributedTitle(highlightedAttributedString, for: .highlighted)
        button.setAttributedTitle(attributedString, for: .normal)
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(r: 255, g: 122, b: 79).cgColor
        return button
    }()
    
    let regiesterationButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let attributedString = NSAttributedString(string: "إنشاء حساب", attributes: [.font:UIFont.textStyle, .foregroundColor : UIColor.nagwaOrange])
        button.setAttributedTitle(attributedString, for: .normal)
        return button
    }()
    
    
    let registerationLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.textStyle
        label.text = "ليس لديك حساب؟"
        label.textColor = UIColor(r: 80, g: 80, b: 80)
        return label
    }()
    
    lazy var registerationStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [registerationLabel, regiesterationButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var errorImageView : UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "iconError"))
        imgView.contentMode = .scaleAspectFill
        imgView.isHidden = true
        return imgView
    }()
    
    var doneImageView : UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "iconDone"))
        imgView.contentMode = .scaleAspectFill
        imgView.isHidden = true
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViewConstraints() {
        setupRegiesterationStackView()
        setUpGuestButton()
        setUpLoginButton()
        settingUpforgotPasswordButton()
        settingUpSeconSeperator()
        settingUpPasswordTextFiled()
        settingUpFirstSeperatorView()
        settingUpMailTextFailed()
        setingUPhindawiLogoConstraint()
        setUpErrorIcon()
        setUpDoneIcon()
        setupMailPlaceHolder()
        setupPasswordPlaceHolder()
    }
    
    fileprivate func setingUPhindawiLogoConstraint() {
        addSubview(logo)
        logo.heightAnchor.constraint(equalToConstant: 96.5).isActive = true
        logo.setupXYAnchors(bottom: mailTextFailed.topAnchor, centerX: centerXAnchor, centerY: nil, bottomConstant: -70)
    }
    
    fileprivate func settingUpMailTextFailed() {
        addSubview(mailTextFailed)
        mailTextFailed.heightAnchor.constraint(equalToConstant: 44).isActive = true
        mailTextFailed.setupXYAnchors(bottom: firstSeperatorView.topAnchor,leading: leadingAnchor, trailing: trailingAnchor, leadingConstant: 20, trailingConstant: -20 )
    }
    
    fileprivate func settingUpFirstSeperatorView() {
        addSubview(firstSeperatorView)
        firstSeperatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        firstSeperatorView.setupXYAnchors(bottom: passwordTextFiled.topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottomConstant: -20, leadingConstant: 20, trailingConstant: -20)
        
    }
    
    fileprivate func settingUpPasswordTextFiled() {
        addSubview(passwordTextFiled)
        passwordTextFiled.heightAnchor.constraint(equalToConstant: 44).isActive = true
        passwordTextFiled.setupXYAnchors(bottom: secondSeperatorView.topAnchor, leading : leadingAnchor, trailing: trailingAnchor, leadingConstant: 20, trailingConstant: -20)
    }
    
    fileprivate func settingUpSeconSeperator() {
        addSubview(secondSeperatorView)
        secondSeperatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        secondSeperatorView.setupXYAnchors( bottom: forgotPasswordButton.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, bottomConstant: -5.5, leadingConstant: 20, trailingConstant: -20)
    }
    
    fileprivate func settingUpforgotPasswordButton() {
        addSubview(forgotPasswordButton)
        forgotPasswordButton.widthAnchor.constraint(equalToConstant: 126.5).isActive = true
        forgotPasswordButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        forgotPasswordButton.setupXYAnchors( bottom: loginButton.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor,bottomConstant: -85, trailingConstant: -20)
    }
    
    
    var registerationButtonBottomAnchor : NSLayoutConstraint?
    
    
    fileprivate func setupRegiesterationStackView() {
        addSubview(registerationStackView)
        registerationButtonBottomAnchor = registerationStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30)
        registerationButtonBottomAnchor?.isActive = true
        registerationStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        registerationStackView.heightAnchor.constraint(equalToConstant: 24.5).isActive = true
        registerationStackView.widthAnchor.constraint(equalToConstant: 183).isActive = true
    }
    
    fileprivate func setUpGuestButton() {
        addSubview(guestButton)
        guestButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        guestButton.setupXYAnchors(bottom: registerationStackView.topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottomConstant: -30, leadingConstant: 20, trailingConstant : -20)
    }
    
    fileprivate func setUpLoginButton() {
        addSubview(loginButton)
        loginButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        loginButton.setupXYAnchors(bottom : guestButton.topAnchor,leading : leadingAnchor, trailing: trailingAnchor ,bottomConstant: -12.5 , leadingConstant: 20, trailingConstant: -20)
    }
    
    fileprivate func setUpErrorIcon() {
        addSubview(errorImageView)
        errorImageView.widthAnchor.constraint(equalToConstant: 18.4).isActive = true
        errorImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        errorImageView.setupXYAnchors(trailing: mailTextFailed.trailingAnchor, centerY: mailTextFailed.centerYAnchor)
    }
    
    fileprivate func setUpDoneIcon() {
        addSubview(doneImageView)
        doneImageView.widthAnchor.constraint(equalToConstant: 18.4).isActive = true
        doneImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        doneImageView.setupXYAnchors(trailing: mailTextFailed.trailingAnchor, centerY: mailTextFailed.centerYAnchor)
    }
    
    fileprivate func setupMailPlaceHolder() {
        addSubview(mailPlaceHolderLabel)
        mailPlaceHolderLabel.setupXYAnchors(bottom: firstSeperatorView.topAnchor, leading: leadingAnchor, bottomConstant: -30, leadingConstant: 20)
    }
    
    fileprivate func setupPasswordPlaceHolder() {
        addSubview(passwordPlaceHolderLabel)
        passwordPlaceHolderLabel.setupXYAnchors(bottom: secondSeperatorView.topAnchor, leading: leadingAnchor, bottomConstant: -30, leadingConstant: 20)
    }
    
}
