import Foundation
import Networking
import Combine
import UIKit

public final class WorkbenchKit {
    
    public init() {}
    
    var bag: [AnyCancellable] = []
 
    public func fetchMovies() {
        FilmsApiClient()
            .fetchMovies()
            .sink { response in
                debugPrint(response)
            }.store(in: &self.bag)
    }
}

public extension UIView {
    
    var embeddedInViewController: UIViewController {
        let viewController = UIViewController()
        viewController.view = self
        return viewController
    }
}
