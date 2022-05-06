import Foundation
import Kingfisher
import Combine
import UIKit

public struct ImageDownloader {
    
    public init() {}
    
    public func downloadImage(url: URL, defaultImage: UIImage = UIImage()) -> AnyPublisher<UIImage, Never> {
        Future<UIImage, Never> { promise in
            _ = KingfisherManager
                .shared
                .retrieveImage(with: .network(url)) { result in
                    switch result {
                    case .success(let value):
                        promise(.success(value.image))
                    case .failure(let error):
                        print(error)
                        promise(.success(defaultImage))
                    }
                }
        }
        .print()
        .eraseToAnyPublisher()
    }
}
