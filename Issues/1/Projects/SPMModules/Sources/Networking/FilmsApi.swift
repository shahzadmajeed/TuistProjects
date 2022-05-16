import Foundation
import Alamofire
import Combine

public struct Films: Decodable {
  public let count: Int
  public let all: [Film]
  
  enum CodingKeys: String, CodingKey {
    case count
    case all = "results"
  }
}

public struct Film: Decodable {
  public let id: Int
  public let title: String
  public let openingCrawl: String
  public let director: String
  public let producer: String
  public let releaseDate: String
  public let starships: [String]
  
  public enum CodingKeys: String, CodingKey {
    case id = "episode_id"
    case title
    case openingCrawl = "opening_crawl"
    case director
    case producer
    case releaseDate = "release_date"
    case starships
  }
}

public struct FilmsApiClient {
    
    public init() {}
    
    public func fetchMovies() -> AnyPublisher<DataResponse<Films, AFError>, Never> {
        NetworkingClient
            .execute(AF.request("https://swapi.dev/api/films"))
    }
}
