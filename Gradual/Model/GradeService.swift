//
//  GradeService.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/15/22.
//

import Foundation


class GradeService: ObservableObject {
    @Published private(set) var student: Student?
    @Published private(set) var classes: [Class]?
    @Published private(set) var isFetching = false
    
    private let store: GradeServiceStore
    
    public init(username: String, password: String) {
        store = GradeServiceStore(username: username, password: password)
    }
}

extension GradeService {
    @MainActor
    func fetchData() async throws {
        isFetching = true
        defer { isFetching = false }
        
        let loadedResult: Result = try await store.load()
        student = loadedResult.studentData

        // TODO: Load classes
//        let loadedClasses: Classes = try await store.load()
//        classes = loadedClasses.currentClasses
    }
}



private actor GradeServiceStore {
    
    private let username: String
    private let password: String
    private let queryParams: [String: String]
    
    private var url: URL {
        urlComponents.url!
    }
    
    public init(username: String, password: String) {
        self.username = username
        self.password = password
        
        queryParams = [
            "username" : username,
            "password" : password
        ]
    }
    
    private var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "private-cornwall-affairs-landscape.trycloudflare.com"
        components.path = "/students/info"
        components.setQueryItems(with: queryParams)
        return components
    }
    
    func load<T>() async throws -> T where T: Decodable {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
        else {
            throw DownloadError.statusNotOK
        }
        guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data)
        else { throw DownloadError.decoderError }
        
        return decodedResponse
    }
    
}

enum DownloadError: Error {
    case statusNotOK
    case decoderError
}

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value)}
    }
}
