//
//  WeatherViewModel.swift
//  Best Weather Forecast App
//
//  Created by Ian Castillo on 26/08/23.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var realtimeWeather: RealtimeWeather?
    @Published var forecast: [ForecastDay] = []
    @Published var isLoading = false
    @Published var error: NetworkError?
    
    // Store the last searched city to refresh the data.
    private var lastQueriedCity: String?

    private var weatherService = WeatherService()

    func fetchWeatherData(forCity city: String) {
        isLoading = true
        lastQueriedCity = city // Store the city
        
        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        weatherService.fetchRealtimeWeather(forCity: city) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    self?.realtimeWeather = weather
                case .failure(let error):
                    self?.error = error
                }
                dispatchGroup.leave()
            }
        }

        dispatchGroup.enter()
        weatherService.fetchForecast(forCity: city) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let forecastResponse):
                    self?.forecast = forecastResponse.forecast.forecastday
                case .failure(let error):
                    self?.error = error
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.isLoading = false
        }
    }
    
    // A function to refresh the data.
    func refreshData() {
        if let city = lastQueriedCity {
            fetchWeatherData(forCity: city)
        }
    }
}
