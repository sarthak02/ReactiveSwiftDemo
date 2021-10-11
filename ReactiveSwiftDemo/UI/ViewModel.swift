import Foundation
import ReactiveSwift
public class ViewModel {
    private let pingPongUseCase: PingPongUseCase
    private let dingDongUseCase: DingDongUseCase
    // Inputs
    /*
     This UI has two buttons, hence two input signals.
     */
    let onPing = MutableProperty<Void?>(nil)
    let onDing = MutableProperty<Void?>(nil)
    
    // Outputs
    /*
     This UI has two labels, hence two output signals. Note, if you need to show and hide
     loading progress indicators, they should have their own output signals. Don't share
     signals
     */
    let pingLabelCount: Signal<String, Never>
    let dingLabelCount: Signal<String, Never>
    
    init(pingPongUseCase: PingPongUseCase, dingDongUseCase: DingDongUseCase) {
        self.pingPongUseCase = pingPongUseCase
        self.dingDongUseCase = dingDongUseCase
        
        // Transform button click into use case execution
        let onPingLoadedResult = onPing.signal
            .flatMap(.latest) { (_) -> SignalProducer<Loadable<String>, Never> in
                return pingPongUseCase.execute()
            }
        let onDingLoadedResult = onDing.signal
            .flatMap(.latest) { (_) -> SignalProducer<Loadable<String>, Never> in
                return dingDongUseCase.execute()
            }
        
        /*
         Intermediate "wiring" signals required to differentiate between loading, loaded and error.
         */
        let (onPingLoaded, onPingLoadedObserver) = Signal<String, Never>.pipe()
        let (onPingLoading, onPingLoadingObserver) = Signal<String, Never>.pipe()
        let (onPingLoadingError, onPingLoadingErrorObserver) = Signal<String, Never>.pipe()
        
        let (onDingLoaded, oDingLoadedObserver) = Signal<String, Never>.pipe()
        let (onDingLoading, onDingLoadingObserver) = Signal<String, Never>.pipe()
        let (onDingLoadingError, onDingLoadingErrorObserver) = Signal<String, Never>.pipe()
        
        /*
         Since this UI has only one label to display loading, loaded and error statues, we merge the
         intermdiate single into that one output signal.
         */
        self.pingLabelCount = Signal<String, Never>.merge(onPingLoaded, onPingLoading, onPingLoadingError)
    
        self.dingLabelCount = Signal<String, Never>.merge(onDingLoaded, onDingLoading, onDingLoadingError)
        
        onPingLoadedResult.observeValues { result in
            switch result {
            case .Success(data: let value):
                onPingLoadedObserver.send(value: value)
            case .Error(error: let error):
                // If there was an error, we display the error message
                onPingLoadingErrorObserver.send(value: error.localizedDescription)
            case .Loading:
                // While the use case execution is in progress, we show "..."
                onPingLoadingObserver.send(value: "Loading....")
            }
        }
        
        onDingLoadedResult.observeValues { result in
            switch result {
            case .Success(data: let value):
                oDingLoadedObserver.send(value: value)
            case .Error(error: let error):
                // If there was an error, we display the error message
                onDingLoadingErrorObserver.send(value: error.localizedDescription)
            case .Loading:
                // While the use case execution is in progress, we show "..."
                onDingLoadingObserver.send(value: "Loading....")
            }
        }
    }
}
