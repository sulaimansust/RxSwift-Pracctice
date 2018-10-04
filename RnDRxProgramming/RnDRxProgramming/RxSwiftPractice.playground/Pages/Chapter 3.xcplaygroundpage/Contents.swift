//: Playground - noun: a place where people can play

import UIKit
import RxSwift
import RxCocoa

//This chapter is all about subject
//SUBJECT -> PublishSubject , BehaviorSubject , ReplaySubject, Variable


//MARK: Create observable
let disposeBag = DisposeBag()

func example(of: String, _ handler:  () -> Void) -> Void {
    print("--- Example of: \(of) ---")
}

enum MyError : Error {
    case firstError, secondError, thirdError
}

example(of: "PublishSubject") {
    let publishSubject = PublishSubject<String>()
    publishSubject.onNext("first message ")
    let subscription = publishSubject.subscribe(onNext: {
        string in
        print(string)
    }, onDisposed: {
        print("disposed")
    }).disposed(by: disposeBag)
    publishSubject.onNext("second message")
    publishSubject.on(.next("1"))
    
}
let publishSubject = PublishSubject<String>()
publishSubject.onNext("first message ")
let subscriptionOne = publishSubject.subscribe(onNext: {
    string in
    print(string)
},onDisposed: {print("subscription1 disposed")}).disposed(by: disposeBag)
let subscriptionTwo = publishSubject.subscribe(onNext: {
    string in
    print("2-> \(string)")
},onDisposed: {print("subscription2 disposed")}).disposed(by: disposeBag)
publishSubject.onNext("second message")
publishSubject.on(.next("1"))
publishSubject.onNext("2")
publishSubject.onError(MyError.firstError)
publishSubject.onNext("after disposed")
