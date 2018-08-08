

import Foundation

public class HomePresenter {
    
    private let loadHomeFeedUseCaseFactory: LoadHomeFeedUseCaseFactory
    
    public init(loadHomeFeedUseCaseFactory: LoadHomeFeedUseCaseFactory) {
        self.loadHomeFeedUseCaseFactory = loadHomeFeedUseCaseFactory
    }
}
