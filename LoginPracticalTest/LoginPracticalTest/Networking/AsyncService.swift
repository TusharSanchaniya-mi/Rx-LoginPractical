//
//  AsyncService.swift
//  LoginPracticalTest
//
//  Created by Mac-00014 on 29/04/21.
//

import Foundation
import RxCocoa
import RxSwift
import Moya


protocol AsyncServiceProtocol {
    func authenticateUserLogin(_ asyncAPIRouter: AsyncAPIRouter) -> Observable<LoginResponse>
}

fileprivate let asyncServiceprovider = MoyaProvider<AsyncAPIRouter>()

final class AsyncService: AsyncServiceProtocol {
    
    private let disposebag = DisposeBag()
    private init() {}
    static let shared = AsyncService()
    
    func authenticateUserLogin(_ asyncAPIRouter: AsyncAPIRouter) -> Observable<LoginResponse> {
        
        return Observable.create { (observer) -> Disposable in
        
            let _ = asyncServiceprovider.rx.request(asyncAPIRouter).asObservable().subscribe { (response) in
                switch response {
                
                case .next(let response):
                    do {
                        let responseModel = try JSONDecoder().decode(LoginResponse.self, from: response.data)
                        print("success")
                        observer.onNext(responseModel)
                        observer.onCompleted()
                        
                    } catch let exceptionMsg {
                        print("exceptionMsg>>> \(exceptionMsg)")
                        observer.onError(exceptionMsg)
                    }
                    
                case .error(let errorMsg):
                    print("Failed with Error: \(errorMsg)")
                    observer.onError(errorMsg)
                    
                case .completed:
                    print("completed")
                    observer.onCompleted()
                }
                
            }.disposed(by: self.disposebag)
            
            return Disposables.create()
        }
    }
}
