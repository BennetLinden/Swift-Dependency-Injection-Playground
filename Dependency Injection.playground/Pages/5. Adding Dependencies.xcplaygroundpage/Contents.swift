/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # Adding Dependencies
 
 Let's add a **DataRepository** as a dependency to the **HomePresenter**:
 */
import Foundation

class HomePresenter {
    
    let dataRepository: DataRepository
    
    init(dataRepository: DataRepository) {
        self.dataRepository = dataRepository
    }
}
/*:
 The **DependencyProvider** is not limited to providing factory methods for ViewControllers and Presenters but can also define dependencies as properties. By defining the **DataRepository** as a property, it will act as a singleton because the **DependencyProvider** will only be created once, and will stay alive during the lifetime of the application.
 */
protocol DependencyProvider {
    
    var dataRepository: DataRepository { get }
    
    func makeHomePresenter() -> HomePresenter
}
/*:
 Add an implemention in the **DependencyContainer**:
 */
class DependencyContainer: DependencyProvider {
    
    // This dataRepository will act as a singleton during the lifetime of the DependencyContainer
    let dataRepository: DataRepository = DataRepository()
    
    func makeHomePresenter() -> HomePresenter {
        return HomePresenter(dataRepository: dataRepository)
    }
}
/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
