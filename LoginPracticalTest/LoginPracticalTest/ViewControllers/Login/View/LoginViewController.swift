//
//  ViewController.swift
//  LoginPracticalTest
//
//  Created by Mac-00014 on 29/04/21.
//

import UIKit
import RxCocoa
import RxSwift

final class LoginViewController: UIViewController {
    
    @IBOutlet private weak var txtEmail : UITextField!
    @IBOutlet private weak var lblEmailError : UILabel!
    
    @IBOutlet private weak var txtPassword : UITextField!
    @IBOutlet private weak var lblPasswordError : UILabel!
    
    @IBOutlet weak var vwVisualBlurView: UIVisualEffectView!
    @IBOutlet private weak var btnLogin : UIButton!
    
    let viewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialisation()
        self.bindTextFieldObserver()
        self.binErrorFieldObserver()
        self.handleAsyncResponse()
    }
    
    //Mark: - Private Methods
    private func initialisation() {
        self.lblEmailError.text = LoginErrorMsg.emailError
        self.lblPasswordError.text = LoginErrorMsg.passwordError
    }
    
    private func bindTextFieldObserver() {
        
        self.txtEmail.rx.text
            .subscribe { [weak self] (obsEvent) in
                switch obsEvent {
                case .next(let email):
                    self?.viewModel.emailFieldValidate(email ?? "")
                case .error(let error):
                    print("Error: \(error)")
                case .completed:
                    print("completed")
                }
            }.disposed(by: disposeBag)
        
        self.txtPassword.rx.text
            .subscribe { [weak self] (obsEvent) in
                switch obsEvent {
                case .next(let password):
                    self?.viewModel.PasswordFieldValidate(password ?? "")
                case .error(let error):
                    print("Error: \(error)")
                case .completed:
                    print("completed")
                }
            }.disposed(by: disposeBag)
        
    }
    
    private func binErrorFieldObserver() {
        
        self.viewModel.emailValidateObs
            .takeUntil(rx.deallocated)
            .bind(to: self.lblEmailError.rx.isHidden)
            .disposed(by: disposeBag)
        
        self.viewModel.passwordValidateObs
            .takeUntil(rx.deallocated)
            .bind(to: self.lblPasswordError.rx.isHidden)
            .disposed(by: disposeBag)
        
        self.viewModel.btnLoginEnableObs
            .takeUntil(rx.deallocated)
            .subscribe({ (objEvent) in
                switch objEvent {
                case .next(let bResult):
                    self.btnLogin.alpha = bResult ? 1.0 : 0.2
                    self.btnLogin.isEnabled = bResult
                case .error(let error):
                    print("Error: \(error)")
                case .completed:
                    print("completed")
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func handleAsyncResponse() {
        
        self.viewModel.progressLoaderObs
            .takeUntil(rx.deallocated)
            .asObservable()
            .subscribe { (progressEvent) in
                switch progressEvent {
                case .next(let bProgress):
                    self.vwVisualBlurView.isHidden = !bProgress
                case .error(let ExError):
                    print("ExError:: \(ExError)")
                case .completed:
                    print("completed")
                }
            }.disposed(by: disposeBag)
        
        self.viewModel.loginFailMsgObs
            .takeUntil(rx.deallocated)
            .filter({ !(($0 ).isEmpty) })
            .asObservable()
            .subscribe { (errorMsgEvent) in
                switch errorMsgEvent {
                case .next(let strErrorMsg):
                    print("strErrorMsg:: \(strErrorMsg)")
                    self.showAlert(strErrorMsg)
                case .error(let ExError):
                    print("ExError:: \(ExError)")
                case .completed:
                    print("completed")
                }
            }.disposed(by: disposeBag)
        
        self.viewModel.loginSuccessObs
            .takeUntil(rx.deallocated)
            .asDriver(onErrorJustReturn: false)
            .drive { (bResult) in
                bResult.subscribe { (bEvent) in
                    switch bEvent {
                    case .next(let bResult):
                        print("bEvent:: \(bResult)")
                        print("user eligible to go forward")
                    case .error(let ExError):
                        print("ExError:: \(ExError)")
                    case .completed:
                        print("completed")
                    }
                }.disposed(by: disposeBag)
            }
        
    }
    
    @IBAction private func btnLoginClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        self.viewModel.btnLoginTapped()
    }
    
}

