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
    case networkRequestError
}

class WeatherService {
    let apiKey = "aaaabffe7abd4d7f92605415232708"
    
    func fetchRealtimeWeather(forCity city: String, completion: @escaping (Result<RealtimeWeather, NetworkError>) -> Void) {
        let urlString = "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(city)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let weatherResponse = try decoder.decode(RealtimeWeather.self, from: data)
                    completion(.success(weatherResponse))
                } catch {
                    completion(.failure(.decodingError))
                }
            } else {
                completion(.failure(.networkRequestError))
            }
        }.resume()
    }
    
    func fetchForecast(forCity city: String, completion: @escaping (Result<ForecastResponse, NetworkError>) -> Void) {
        let urlString = "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(city)&days=5"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let forecastResponse = try decoder.decode(ForecastResponse.self, from: data)
                    completion(.success(forecastResponse))
                } catch {
                    completion(.failure(.decodingError))
                }
            } else {
                completion(.failure(.networkRequestError))
            }
        }.resume()
    }
}
