//
//  LoginViewModel.swift
//  LoginPracticalTest
//
//  Created by Mac-00014 on 29/04/21.
//

import Foundation
import RxSwift
import RxCocoa

struct LoginViewModel {

    var emailValidateObs : Observable<Bool> {
        return emailErrorObserver.asObservable()
    }
    
    var passwordValidateObs : Observable<Bool> {
        return passwordErrorObserver.asObservable()
    }
    
    var btnLoginEnableObs : Observable<Bool> {
        return btnLoginObserver.asObservable()
    }
    
    var progressLoaderObs : Observable<Bool> {
        return progressLoaderObserver.asObservable()
    }
    
    var loginSuccessObs : Observable<Bool> {
        return loginSuccessObserver.asObservable()
    }
    
    var loginFailObs : Observable<Bool> {
        return loginFailObserver.asObservable()
    }

    var loginFailMsgObs : Observable<String> {
        return loginFailMsgObserver.asObservable()
    }
    
    private var emailObserver =  BehaviorRelay<String>(value: "")
    private var passwordObserver = BehaviorRelay<String>(value: "")
    private var btnLoginObserver = BehaviorRelay<Bool>(value: false)
    private var progressLoaderObserver = BehaviorRelay<Bool>(value: false)
    
    private var emailErrorObserver =  BehaviorRelay<Bool>(value: false)
    private var passwordErrorObserver = BehaviorRelay<Bool>(value: false)
    
    private var loginSuccessObserver = BehaviorRelay<Bool>(value: false)
    private var loginFailObserver = BehaviorRelay<Bool>(value: false)
    private var loginFailMsgObserver = BehaviorRelay<String>(value: "")
    
    private let disposeBag = DisposeBag()
    
    init() {
        self.bindObservers()
    }
    
    func bindObservers() {
        
        //Show Email Error
        emailObserver.asObservable()
            .map { (email) in
                email.isEmpty || email.validateField(.email)
            }.bind(to: emailErrorObserver)
            .disposed(by: disposeBag)
        
        //Show Password Error
        passwordObserver.asObservable()
            .map { (password) in
                password.isEmpty || password.validateField(.password)
            }.bind(to: passwordErrorObserver)
            .disposed(by: disposeBag)
        
        //Enable/Disable Login Button
        Observable.combineLatest(emailObserver.asObservable(),
                                 passwordObserver.asObservable())
            .map { (email, password) in
                email.validateField(.email) && password.validateField(.password)
            }.bind(to: btnLoginObserver)
            .disposed(by: disposeBag)
    }
 
    func emailFieldValidate(_ email: String) {
        emailObserver.accept(email)
    }
    
    func PasswordFieldValidate(_ password: String) {
        passwordObserver.accept(password)
    }
    
    func btnLoginTapped() {
        
        progressLoaderObserver.accept(true)
        
        AsyncService.shared.authenticateUserLogin(
            .loginAPI(LoginModel(email: emailObserver.value,
                                 pasword: passwordObserver.value)))
            .subscribe { (event) in
                progressLoaderObserver.accept(false)
                switch event {
                case .next(let response):
                    print("response: \(response)")
                    
                    if response.error != nil {
                        loginFailObserver.accept(true)
                        loginFailMsgObserver.accept(response.error ?? "")
                    }
                    else {
                        loginSuccessObserver.accept(true)
                    }
                    
                    /*
                    if response.resCode == 1 {
                        loginSuccessObserver.accept(true)
                        UserDefaults.standard.userModel = response.data
                    }
                    else {
                        loginFailObserver.accept(true)
                        loginFailMsgObserver.accept(response.resError)
                    }*/
                    
                case .error(let error):
                    print("Obs Error: \(error)")
                    loginFailObserver.accept(true)
                    loginFailMsgObserver.accept(error.localizedDescription)
                case .completed:
                    print("completed")
                }
            }.disposed(by: disposeBag)
    }
    
}
