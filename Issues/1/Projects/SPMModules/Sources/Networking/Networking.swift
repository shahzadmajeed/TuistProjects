import Alamofire
import Combine

public struct NetworkingClient {
    
    public static func execute<T: Decodable>(_ request: DataRequest) -> AnyPublisher<DataResponse<T, AFError>, Never> {
        request
            .validate()
            .publishDecodable(type: T.self)
            .eraseToAnyPublisher()
    }
}
