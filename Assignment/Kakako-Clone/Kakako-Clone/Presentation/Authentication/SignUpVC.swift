//
//  SignUpVC.swift
//  Kakako-Clone
//
//  Created by 강윤서 on 2022/10/01.
//

import UIKit

class SignUpVC: UIViewController {
    
    //MARK: Properties
    let width = UIScreen.main.bounds.width

    //MARK: UI Components
    private let startKakao: UILabel = {
        let lb = UILabel()
        lb.text = I18N.Auth.startKakao
        lb.textColor = .black
        lb.font = .systemFont(ofSize: 22, weight: .medium)
        return lb
    }()
    
    private let emailNumberTextField: AuthTextField = {
        let tf = AuthTextField()
        tf.placeholder = I18N.Auth.emailOrPhone
        return tf
    }()
    
    private let passwordTextField: AuthTextField = {
        let tf = AuthTextField()
        tf.placeholder = I18N.Auth.password
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let checkPasswordTextField: AuthTextField = {
        let tf = AuthTextField()
        tf.placeholder = I18N.Auth.checkPassword
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let makeAccountButton: AuthButton = {
        let btn = AuthButton()
        btn.setTitle(I18N.Auth.newAccount, for: .normal)
        return btn
    }()
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setAddTarget()
    }
}

//MARK: Extension
extension SignUpVC {
    private func setUI() {
        view.backgroundColor = .white
    }
    
    private func setAddTarget() {
        makeAccountButton.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        emailNumberTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        checkPasswordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    private func setLayout() {
        view.addSubViews(startKakao, emailNumberTextField, passwordTextField,
                         checkPasswordTextField, makeAccountButton)
        
        startKakao.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(60)
            make.centerX.equalToSuperview()
        }
        
        emailNumberTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(startKakao.snp.bottom).offset(100)
            make.height.equalTo(width * (44/375))
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(emailNumberTextField.snp.bottom).offset(16)
            make.height.equalTo(width * (44/375))
        }
        
        checkPasswordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.height.equalTo(width * (44/375))
        }
        
        makeAccountButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(checkPasswordTextField.snp.bottom).offset(30)
            make.height.equalTo(width * (44/375))
        }
    }
    
    private func presentToOnBoardingView() {
        let nextVC = onBoardingVC()
        nextVC.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
    
    @objc
    private func touchUpInside() {
        presentToOnBoardingView()
    }
    
    @objc
    private func textFieldDidChange() {
        if emailNumberTextField.hasText,
           passwordTextField.hasText,
           checkPasswordTextField.hasText {
            makeAccountButton.isEnabled = true
            makeAccountButton.backgroundColor = .kakaoLogin
        } else {
            makeAccountButton.isEnabled = false
            makeAccountButton.backgroundColor = .systemGray6
        }
    }
}