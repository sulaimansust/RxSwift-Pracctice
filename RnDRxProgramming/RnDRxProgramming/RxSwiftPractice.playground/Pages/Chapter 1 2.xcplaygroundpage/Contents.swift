//: [Previous](@previous)

import Foundation
import RxSwift
import RxCocoa

var str = "Hello, playground"
print("hek")

//MARK: Create observable
let disposeBag = DisposeBag()

enum MyError : Error {
    case aError
}

let one  = 1
let two = 2
let three = 3

let observableOne = Observable.just(one)
let observableTwo = Observable.of(one,two,three)
let observablethree = Observable.from([one,two,three])
func example(of: String, _ handler:  () -> Void) -> Void {
    print("--- Example of: \(of) ---")
}

//MARK: Subscription

observableTwo.subscribe{
    event in
//    print(event)
    if let element = event.element {
        print(element)
    }
}
observableOne.subscribe(onNext: {
    value in
    print(value)
}, onCompleted: {
    print("completed one")
}
).disposed(by: disposeBag)

//MARK: Example of "Create"

example(of: "create") {
    

let disposeBag = DisposeBag()

Observable<String>.create { observer in
    return Disposables.create()
}
}


Observable<String>.create {
observer in
    observer.onNext("1")
    observer.onCompleted()
    observer.onNext("2")
    return Disposables.create()
    
    }.subscribe{
        event in
        print(event)
}

print("-----------------------------------")

Observable<String>.create { observer in
    observer.onError(MyError.aError)
    observer.onNext("1")
    observer.onCompleted()
    observer.onNext("2")
    return Disposables.create()
    
    }.subscribe(onNext: {print($0)},
                onError: {print($0)},
                onCompleted: {print("create -> Completed")},
                onDisposed: {print("create -> Disposed")})
.disposed(by: disposeBag)

print("-----------------------------------")
//Creating observable factories

example(of: "deferred") {

let disposeBag = DisposeBag()

// 1
var flip = false

// 2
let factory: Observable<Int> = Observable.deferred {
    
    // 3
    flip = !flip
    
    // 4
    if flip {
        return Observable.of(1, 2, 3)
    } else {
        return Observable.of(4, 5, 6)
    }
}
    for _ in 0...3 {
        factory.subscribe(onNext: {
            print($0, terminator: "")
        })
            .disposed(by: disposeBag)
        
        print()
    }
}

//Traits - single, maybe, completable

example(of: "Single") {

// 2
enum FileReadError: Error {
    case fileNotFound, unreadable, encodingFailed
}

// 3
func loadText(from name: String) -> Single<String> {
    // 4
    return Single.create { single in
        // 1
        let disposable = Disposables.create()
        
        // 2
        guard let path = Bundle.main.path(forResource: name, ofType: "txt") else {
            single(.error(FileReadError.fileNotFound))
            return disposable
        }
        
        // 3
        guard let data = FileManager.default.contents(atPath: path) else {
            single(.error(FileReadError.unreadable))
            return disposable
        }
        
        // 4
        guard let contents = String(data: data, encoding: .utf8) else {
            single(.error(FileReadError.encodingFailed))
            return disposable
        }
        
        // 5
        single(.success(contents))
        return disposable
    }
}
    loadText(from: "Copyright").subscribe{
        switch $0 {
        case .success(let string):
            print(string)
        case .error(let error):
            print(error)
        }
    }.disposed(by: disposeBag)
}

//Observable<String>.never().do(onNext: { (value) in
//    print(value)
//    }, onError: { (error) in
//        print("error")
//        }, onCompleted: {
//            print("completed")
//}, onSubscribe: {
//    print("subscribe done") }
//    , onSubscribed: {print("onSubscribe")} , onDispose: {
//        print("onDispose")
//        })

//

//: [Next](@next)
