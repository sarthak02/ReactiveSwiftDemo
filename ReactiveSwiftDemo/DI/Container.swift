import Foundation
import Swinject
import Moya
let container: Container = {
    let container = Container()
    // Services (should be singletons)
    container.register(MoyaProvider.self) { r in MoyaProvider<PingPongService>()}
        .inObjectScope(.container)
    
    // Repositories (should be singletons)
    container.register(Repository.self) { r in
        RepositoryImpl(provider: r.resolve(MoyaProvider<PingPongService>.self)!)
    }
    .inObjectScope(.container)
    
    // Use cases
    container.register(PingPongUseCase.self) { r in
        // E.g. Initializer Injection
        PingPongUseCase(repo: r.resolve(Repository.self)!) }
    
    container.register(DingDongUseCase.self) { r in
        // E.g. Initializer Injection
        DingDongUseCase(repo: r.resolve(Repository.self)!) }
    
    // View models
    container.register(ViewModel.self) { r in ViewModel(pingPongUseCase: r.resolve(PingPongUseCase.self)!, dingDongUseCase: r.resolve(DingDongUseCase.self)!) }
    
    // View controllers
    container.register(ViewController.self) { r in
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        // E.g. Property Injection
        viewController.viewModel = r.resolve(ViewModel.self)
        return viewController
    }
    
    return container
}()
