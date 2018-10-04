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
print("-----------------PublishSubject------------------")

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
print("----------------BehaviorSubject-------------------")

let behavSubject = BehaviorSubject.init(value: "Initial Value")
let subscription1 = behavSubject.subscribe(onNext: {
    value in
    print("1 -> \(value)")
}).disposed(by: disposeBag)
behavSubject.onNext("second value")
let subscription2 = behavSubject.subscribe(onNext: {
    value in
    print("2 -> \(value)")
}).disposed(by: disposeBag)


print("----------------ReplaySubject-------------------")

example(of: "ReplaySubject") {

let subject = ReplaySubject<String>.create(bufferSize: 2)

subject.onNext("1")
subject.onNext("2")
subject.onNext("3")

// 3
subject
    .subscribe {
        print("1) : \($0)")
    }
    .disposed(by: disposeBag)

subject
    .subscribe {
        print("2) : \($0)")
    }
    .disposed(by: disposeBag)
}

let repSubject = ReplaySubject<String>.create(bufferSize: 3)
repSubject.subscribe{
    event in
    print(event)
    }.disposed(by: disposeBag)


repSubject.onNext("one")
repSubject.onNext("two")
repSubject.subscribe{
    event in
    print("2 \(event)")
    }.disposed(by: disposeBag)


repSubject.onNext("three")
repSubject.onError(MyError.firstError)

repSubject.onNext("four")


print("----------------Variable-------------------")

example(of: "Variable") {

let variable = Variable("Initial value")


variable.value = "New initial value"

variable.asObservable()
    .subscribe {
        print( "1)    \($0)")
    }
    .disposed(by: disposeBag)
}


print("-----------------------------------")


print("-----------------------------------")



print("-----------------------------------")



print("-----------------------------------")



print("-----------------------------------")



print("-----------------------------------")


print("-----------------------------------")

