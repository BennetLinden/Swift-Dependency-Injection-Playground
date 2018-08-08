/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # Conclusion
 The **DependencyContainer** is ultimately the one managing and creating all the dependencies in the app. It implemements all the properties and methods defined in the **DependencyProvider**.
 
 With properties, the **DependencyContainer** can provide a shared single instance of an object, allowing multiple components to access it.
 
 Through **ViewControllerFactory** protocols it can mask its functionalities and only expose the method needed to create a specific **ViewController**, without knowing anything about its dependencies. **Factory** protocols are not limited to **ViewControllers**, but can be used to expose any method of the **DependencyContainer**. 
 
 ## Example Dependency Provider
 An example of a **DependencyProvider** with multiple dependency properties and factory methods, and acts as Factory for ViewControllers and UseCases:
 */
import Foundation
import UIKit

protocol DependencyProvider: HomeViewControllerFactory, LoadHomeFeedUseCaseFactory, SettingsViewControllerFactory {
    
    var dataRepository: DataRepository { get }
    var remoteAPI: RemoteAPI { get }
    
    func makeHomeViewController() -> UIViewController
    func makeHomePresenter() -> HomePresenter
    func makeLoadHomeFeedUseCase() -> UseCase
    
    func makeSettingsViewController() -> UIViewController
    func makeSettingsPresenter() -> SettingsPresenter
}
/*:
 With corresponsing **DependencyContainer**:
 */
class DependencyContainer: DependencyProvider {
    
    let dataRepository: DataRepository = DataRepository()
    let remoteAPI: RemoteAPI = RemoteAPI()
    
    func makeHomeViewController() -> UIViewController {
        return HomeViewController(presenter: makeHomePresenter(),
                                  settingsViewControllerFactory: self)
    }
    
    func makeHomePresenter() -> HomePresenter {
        return HomePresenter(loadHomeFeedUseCaseFactory: self)
    }
    
    func makeLoadHomeFeedUseCase() -> UseCase {
        return LoadHomeDataUseCase(dataRepository: dataRepository,
                                   remoteAPI: remoteAPI)
    }
    
    func makeSettingsViewController() -> UIViewController {
        return SettingsViewController(presenter: makeSettingsPresenter())
    }
    
    func makeSettingsPresenter() -> SettingsPresenter {
        return SettingsPresenter(dataRepository: dataRepository)
    }
}
/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
