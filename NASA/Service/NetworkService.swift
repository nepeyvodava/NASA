import Moya

enum NetworkService {
    case searchPhotos(q: String)
    case searchVideos(q: String)
    case fetchPhoto(id: String)
}


extension NetworkService: TargetType {

    var baseURL: URL { return URL(string: "https://images-api.nasa.gov")! }
    
    var path: String {
        switch self {
        case .searchPhotos(_), .searchVideos(_):
            return "/search"
        case .fetchPhoto(let id):
            return "/asset/\(id)"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .searchPhotos(_), .searchVideos(_):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .fetchPhoto(_):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var parameters: [String: Any] {
        switch self {
        case .searchPhotos(let q):
            return ["q": q, "media_type": "image"]
        case .searchVideos(let q):
            return ["q": q, "media_type": "video"]
        default:
            return [String: Any]()
        }
    }

}

class Network {
    
    static var provider: MoyaProvider<NetworkService> { return MoyaProvider<NetworkService>() }
    
}
