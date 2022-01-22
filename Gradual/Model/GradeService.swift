//
//  GradeService.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/15/22.
//

import Foundation


/// Provides an easy way to interact with the API.
class GradeService {
    private let store: GradeServiceStore
    private(set) var isFetching = false
    
    public init(_ username: String, _ password: String) {
        store = GradeServiceStore(username: username, password: password)
    }
}

@MainActor extension GradeService {
    /// Returns the decoded value of the type provided.
    /// To implement set your variable to the value that fetch data returns.
    /// Make sure to pass in the correct root or this function will throw an error.
    func fetchData<T>(from root: AvailableRoot) async throws -> T where T: Decodable {
        isFetching = true
        defer { isFetching = false }
        let loadedPackage: T = try await store.load(with: root)
        return loadedPackage
    }
}


/// Holds the credentials of the user to send up to the server.
private actor GradeServiceStore {
    
    private let username: String
    private let password: String
    private var path = ""
    
    private var url: URL {
        urlComponents.url!
    }
    
    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    /// Builds a URL to connect to the API sever.
    private var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "gradualgrades-env.eba-dkw3kc3t.us-east-2.elasticbeanstalk.com"
        components.path = path
        return components
    }
    
    /// Attempts to decode the data returned from the server.
    func load<T>(with root: AvailableRoot) async throws -> T where T: Decodable {
        
        self.path = root.rawValue
        if root != .satDates {
            path += "/\(username)/\(password)"
        }
                
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
        else { throw DownloadError.statusNotOK }
        
        print(url)
        print(response)
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Error \(error)")
            throw DownloadError.decoderError
        }
    }
}

/// All the available roots on the server.
enum AvailableRoot: String {
    case currentClasses = "/students/currentclasses"
    case studentInfo = "/students/info"
    case GPA = "/students/gpa"
    case satDates = "/satdates"
}


//  MARK: ERROR Handling
/// The most common errors that the JSON data can throw.
enum DownloadError: Error {
    case statusNotOK
    case decoderError
}

/// Adds a description to the error.
extension DownloadError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .statusNotOK:
            return NSLocalizedString(
                "Invalid Credentials",
                comment: ""
            )
        case .decoderError:
            let format = NSLocalizedString(
                "JSON Parse Error",
                comment: ""
            )
            return String(format: format)
        }
    }
}
