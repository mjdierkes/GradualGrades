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
    func fetchData<T>(from root: AvailableRoot, with quarter: Quarter? = nil) async throws -> T where T: Decodable {
        isFetching = true
        defer { isFetching = false }
        let loadedPackage: T = try await store.load(with: root, quarter: quarter)
        return loadedPackage
    }
}


/// Holds the credentials of the user to send up to the server.
private actor GradeServiceStore {
    
    private let username: String
    private let password: String
    private var path = ""
    
    private var url: String {
        urlComponents.url!.absoluteString.removingPercentEncoding!
    }
    
    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    /// Builds a URL to connect to the API sever.
    private var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "gradual-deploy.vercel.app"
        components.path = path
        return components
    }
    
    /// Attempts to decode the data returned from the server.
    func load<T>(with root: AvailableRoot, quarter: Quarter?) async throws -> T where T: Decodable {
        
        self.path = getPath(for: root, and: quarter)
        let (data, response) = try await URLSession.shared.data(from: URL(string: url)!)
        
        print(url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
        else { throw DownloadError.statusNotOK }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Error \(error)")
            throw DownloadError.decoderError
        }
    }
    
    func getPath(for root: AvailableRoot, and quarter: Quarter?) -> String {
        if root != .satDates {
            if let quarter = quarter {
                return root.rawValue + "?username=\(username)&password=\(password)&quarter=\(quarter.rawValue)"
            }
            return root.rawValue + "?username=\(username)&password=\(password)"
        }
        return root.rawValue
    }
    
}

/// All the available roots on the server.
enum AvailableRoot: String {
    case currentClasses = "/students/currentclasses"
    case schedule = "/students/schedule"
    case studentInfo = "/students/info"
    case GPA = "/students/gpa"
    case satDates = "/satdates"
    case pastAssignments = "/students/pastassignments"
}

enum Quarter: String {
    case first = "1"
    case second = "2"
    case third = "3"
    case fourth = "4"
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
