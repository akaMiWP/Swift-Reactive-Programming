//
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
