//
//  Network.swift
//  STL BFW
//
//  Created by Roger ADT on 10/2/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case decodingError
}

class Networking {
   static let shared = Networking()
    private init() {}
//    D247E555-6A8E-343A-FFEB-7DDC74647200/FE6FBDD5-4DAF-4E97-BB40-D8584A1971A8/data/Feedback"


    func post<T: Codable>(from path: String, body: T) async throws  -> T {
        guard let url = URL(string: "https://api.backendless.com/" + "\(appID)/" + apiKey  + path) else {
            throw NetworkError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json",
                         forHTTPHeaderField: "Content-Type")
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(body)
        } catch {
            throw NetworkError.decodingError
        }
        let (data, httpResponse) = try await URLSession.shared.data(for: request)
        guard let response = httpResponse as? HTTPURLResponse,
              response.statusCode > 199,
              response.statusCode < 300 else {
            throw NetworkError.invalidResponse
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }

    var apiKey: String {
        if let plistPath = Bundle.main.path(forResource: "Prod", ofType: "plist"),
           let plistData = FileManager.default.contents(atPath: plistPath) {
            do {
                let plistObject = try PropertyListSerialization.propertyList(from: plistData, options: [], format: nil)
                if let plistDictionary = plistObject as? [String: Any],
                let key = plistDictionary["APIKey"] as? String{
                    return key
                }
            } catch {
                print(error)
                return ""
            }
        }
        return ""
    }

    var appID: String {
        if let plistPath = Bundle.main.path(forResource: "Prod", ofType: "plist"),
           let plistData = FileManager.default.contents(atPath: plistPath) {
            do {
                let plistObject = try PropertyListSerialization.propertyList(from: plistData, options: [], format: nil)
                if let plistDictionary = plistObject as? [String: Any],
                   let key = plistDictionary["AppId"] as? String{
                    return key
                }
            } catch {
                print(error)
                return ""
            }
        }
        return ""
    }
}
