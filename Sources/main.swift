//
import RxSwift

example(of: "Cold Observable") {
    let just = Observable.just(1)
    let of = Observable.of(1, 2, 3)
    let from = Observable.from([4, 5])
    
    _ = just.subscribe { event in
        print(">> Just:", event)
    }
    
    _ = of.subscribe { event in
        print(">> Of:", event)
    }
    
    _ = from.subscribe { event in
        print(">> From:", event)
    }
}

example(of: "Operator - startsWith") {
    
    subExample(of: "doesn't call startWith") {
        let subject = PublishSubject<Void>()
        
        _ = subject.subscribe(onNext: {
            print(">> onNext")
        })
    }
    
    subExample(of: "call startWith") {
        let subject = PublishSubject<Void>()
            .startWith(())
        
        _ = subject.subscribe(onNext: {
            print(">> onNext")
        })
    }
}
