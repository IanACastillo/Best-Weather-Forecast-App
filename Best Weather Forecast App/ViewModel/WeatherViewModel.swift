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

    private var weatherService = WeatherService()

    func fetchWeatherData(forCity city: String) {
        isLoading = true
        weatherService.fetchRealtimeWeather(forCity: city) { [weak self] result in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    self?.realtimeWeather = weather
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.error = error
                }
            }

            self?.weatherService.fetchForecast(forCity: city) { [weak self] result in
                switch result {
                case .success(let forecastResponse):
                    DispatchQueue.main.async {
                        self?.forecast = forecastResponse.forecastday
                        self?.isLoading = false
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.error = error
                        self?.isLoading = false
                    }
                }
            }
        }
    }
}
