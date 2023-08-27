//
//  WeatherService.swift
//  Best Weather Forecast App
//
//  Created by Ian Castillo on 26/08/23.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case decodingError
    case networkRequestError(Error?)
    case serverError(Int?)
}

class WeatherService {
    let apiKey = "aaaabffe7abd4d7f92605415232708"
    let baseURL = "https://api.weatherapi.com/v1"
    
    struct WeatherApiResponse: Codable {
        let location: Location
        let current: RealtimeWeather
    }
        
    func fetchRealtimeWeather(forCity city: String, completion: @escaping (Result<RealtimeWeather, NetworkError>) -> Void) {
        let endpoint = "/current.json"
        
        fetch(forCity: city, endpoint: endpoint) { (result: Result<WeatherApiResponse, NetworkError>) in
            switch result {
            case .success(let response):
                completion(.success(response.current))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchForecast(forCity city: String, completion: @escaping (Result<ForecastResponse, NetworkError>) -> Void) {
        let endpoint = "/forecast.json"
        fetch(forCity: city, endpoint: endpoint, completion: completion)
    }
    
    private func fetch<T: Decodable>(forCity city: String, endpoint: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let urlString = "\(baseURL)\(endpoint)?key=\(apiKey)&q=\(city)&days=5"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                completion(.failure(.serverError(httpResponse.statusCode)))
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let decodedResponse = try decoder.decode(T.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    print("Decoding error: \(error)")
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("API Response: \(jsonString)")
                    }
                    completion(.failure(.decodingError))
                }
            } else {
                completion(.failure(.networkRequestError(error)))
                print("Network request error: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }
}
