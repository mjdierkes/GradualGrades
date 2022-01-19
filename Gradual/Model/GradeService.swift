//
//  GradeService.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/15/22.
//

import Foundation


class GradeService {
    private(set) var isFetching = false
    
    private let store: GradeServiceStore
    
    public init(_ username: String, _ password: String) {
        store = GradeServiceStore(username: username, password: password)
    }
}

extension GradeService {
    @MainActor
    
    func fetchStudent() async throws -> Student {
        await store.loadStudent()
        let student: Student = try await fetchData()
        return student
    }
    
    func fetchData<T>() async throws -> T where T: Decodable {
        isFetching = true
        defer { isFetching = false }
        
        let loadedPackage: T = try await store.load()
        return loadedPackage
    }
}



private actor GradeServiceStore {
    
    private let username: String
    private let password: String
    private let queryParams: [String: String]
    private var path = "/students/currentclasses"
    
    private var url: URL {
//        urlComponents.url!
        return Bundle.main.url(forResource: "SampleGradeData", withExtension: "json")!
    }
    private var testURL = Bundle.main.url(forResource: "SampleGradeData", withExtension: "json")!
    
    public init(username: String, password: String) {
        self.username = username
        self.password = password
        
        queryParams = [
            "password" : password,
            "username" : username
        ]
    }
    
    private var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "gradualgrades.herokuapp.com"
        components.path = path
        components.setQueryItems(with: queryParams)
        return components
    }
    
    func load<T>() async throws -> T where T: Decodable {
                
        let (data, response) = try await URLSession.shared.data(from: testURL)
//        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
//        else {
//            throw DownloadError.statusNotOK
//        }

        print(response)

        do{
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Error \(error)")
            throw DownloadError.decoderError
        }
        
    }
    
    func loadStudent() {
        testURL = Bundle.main.url(forResource: "SampleStudentData", withExtension: "json")!
    }
    
}

enum DownloadError: Error {
    case statusNotOK
    case decoderError
}

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

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value)}
    }
}
