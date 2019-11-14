import Moya

enum NetworkService {
    case searchPhotos(q: String)
}


extension NetworkService: TargetType {

    var baseURL: URL { return URL(string: "https://images-api.nasa.gov")! }
    
    var path: String {
        switch self {
        case .searchPhotos(_):
            return "/search"
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
        case .searchPhotos(let q):
            return .requestParameters(parameters: ["q": q], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }

}
