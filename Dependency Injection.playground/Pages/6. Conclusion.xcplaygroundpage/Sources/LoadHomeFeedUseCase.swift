import Foundation

public protocol UseCase {
    func start()
}

public class LoadHomeDataUseCase: UseCase {
    
    private let dataRepository: DataRepository
    private let remoteAPI: RemoteAPI
    
    public init(dataRepository: DataRepository,
                remoteAPI: RemoteAPI) {
        self.dataRepository = dataRepository
        self.remoteAPI = remoteAPI
    }
    
    public func start() {
        dataRepository.fetchData()
    }
}
