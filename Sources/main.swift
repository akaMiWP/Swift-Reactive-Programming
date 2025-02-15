//
import Foundation
import RxCocoa
import RxSwift

var disposeBag: DisposeBag = .init()

example(of: "Observable") {
    example(of: "Cold Observable", level: .one) {
        example(of: "Just/ Of/ From", level: .two) {
            let just = Observable.just(1)
            let of = Observable.of(1, 2, 3)
            let from = Observable.from([4, 5])
            
            _ = just.subscribe { event in
                print("Just:", event)
            }
            
            _ = of.subscribe { event in
                print("Of:", event)
            }
            
            _ = from.subscribe { event in
                print("From:", event)
            }
        }
        
        example(of: "Empty", level: .two) {
            let observable = Observable<Int>.empty()
            observable.subscribe { value in
                print(value)
            }
            .disposed(by: disposeBag)
        }
        
        example(of: "Observable - don't share stream ❌", level: .three) {
            let observable = Observable<String>.create { observer in
                print("At the beginning of the stream 😅")
                observer.on(.next("Hello"))
                return Disposables.create()
            }
            
            let doubleMappedObservable = observable.map { $0 + $0 }
            let tripleMappedObservable = observable.map { $0 + $0 + $0}
            
            doubleMappedObservable.subscribe(onNext: { str in print(str) }).disposed(by: disposeBag)
            tripleMappedObservable.subscribe(onNext: { str in print(str) }).disposed(by: disposeBag)
        }
        
        example(of: "create", level: .three) {
            let observable = Observable<Int>.create { observer in
                observer.on(.next(1))
                return Disposables.create()
            }
            
            observable.subscribe({ event in
                switch event {
                case .next(let number): print(number)
                case .error, .completed: return
                }
            })
            .disposed(by: disposeBag)
        }
    }
    
    example(of: "Hot Observable", level: .one) {
        example(of: "Driver", level: .two) {
            example(of: "Map to Driver - share stream ✅", level: .three) {
                let driver = Observable<String>
                    .create { observer in
                        print("At the beginning of the stream 😄")
                        observer.on(.next("Hello"))
                        return Disposables.create()
                    }
                    .asDriver(onErrorJustReturn: "")
                
                let doubleMappedDriver = driver.map { $0 + $0 }
                let tripleMappedDriver = driver.map { $0 + $0 + $0}
                
                doubleMappedDriver.drive(onNext: { str in print(str) }).disposed(by: disposeBag)
                tripleMappedDriver.drive(onNext: { str in print(str) }).disposed(by: disposeBag)
            }
            
            example(of: "Map to Driver, Map back to Map - share stream ✅", level: .three) {
                let observable = Observable<String>
                    .create { observer in
                        print("At the beginning of the stream 😄")
                        observer.on(.next("Hello"))
                        return Disposables.create()
                    }
                    .asDriver(onErrorJustReturn: "")
                    .asObservable()
                
                let doubleMappedObservable = observable.map { $0 + $0 }
                let tripleMappedObservable = observable.map { $0 + $0 + $0}
                
                doubleMappedObservable.subscribe(onNext: { str in print(str) }).disposed(by: disposeBag)
                tripleMappedObservable.subscribe(onNext: { str in print(str) }).disposed(by: disposeBag)
            }
        }
        
        example(of: "Signal", level: .two) {
            let signal = Observable<String>
                .just("Hello")
                .asSignal(onErrorJustReturn: "")
            
            signal.emit(onNext: { str in print(str) }).disposed(by: disposeBag)
            
            example(of: "Delay subscription - don't receive the latest event ❌", level: .three) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    signal.emit(onNext: { str in print(str) }).disposed(by: disposeBag)
                }
            }
        }
        
        example(of: "PublishSubject", level: .two) {
            example(of: "do", level: .three) {
                let subject: PublishSubject<Int> = .init()
                subject.do { number in
                    print("Side effect -> onNext:", number)
                }
                .subscribe()
                .disposed(by: disposeBag)
                
                subject.on(.next(1))
                subject.on(.next(2))
            }
        }
    }
}

example(of: "Operator - startsWith") {
    
    example(of: "doesn't call startWith", level: .one) {
        let subject = PublishSubject<Void>()
        
        subject.subscribe(onNext: {
            print("onNext")
        })
        .disposed(by: disposeBag)
    }
    
    example(of: "call startWith", level: .one) {
        let subject = PublishSubject<Void>()
            .startWith(())
        
        subject.subscribe(onNext: {
            print("onNext")
        })
        .disposed(by: disposeBag)
    }
}
