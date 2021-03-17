//
//  RegisterViewModel.swift
//  MatchingApp
//
//  Created by Yong Jun Cha on 2021/03/16.
//

import Foundation
import RxSwift
import RxCocoa

protocol RegisterViewModelInputs {
    var nameTextInput : AnyObserver<String> {get}
    var emailTextInput : AnyObserver<String> {get}
    var passwordTextInput : AnyObserver<String> {get}
}

protocol RegisterViewModeloutputs {
    var nameTextOutput : PublishSubject<String> {get}
    var emailTextOutput : PublishSubject<String> {get}
    var passwordTextOutput : PublishSubject<String> {get}
}

class RegisterViewModel : RegisterViewModelInputs, RegisterViewModeloutputs{
    private let disposebag = DisposeBag()
    
    // MARK : observable
    var nameTextOutput = PublishSubject<String>()
    var emailTextOutput = PublishSubject<String>()
    var passwordTextOutput = PublishSubject<String>()
    var validRegisterSubject = BehaviorSubject<Bool>(value: false)
    
    var nameTextInput : AnyObserver<String> {
        nameTextOutput.asObserver()
    }
    
    var emailTextInput : AnyObserver<String> {
        emailTextOutput.asObserver()
    }
    
    var passwordTextInput : AnyObserver<String> {
        passwordTextOutput.asObserver()
    }
    
    var validRegisterDriver : Driver<Bool> = Driver.never()

    // MARK : observer
    init() {
       
        validRegisterDriver = validRegisterSubject
            .asDriver(onErrorDriveWith: Driver.empty())
        
        let nameValid = nameTextOutput
            .asObservable()
            .map { text -> Bool in
                return text.count >= 5
            }
        
        
       let emailValid = emailTextOutput
            .asObservable()
            .map { text -> Bool in
                return text.count >= 5
            }
        
        
       let paswordValid = passwordTextOutput
            .asObservable()
            .map { text -> Bool in
                return text.count >= 5
            }

        Observable.combineLatest(nameValid, emailValid, paswordValid) {$0 && $1 && $2}
            .subscribe { validAll in
                self.validRegisterSubject.onNext(validAll)
            }
            .disposed(by: disposebag)
    }
}

