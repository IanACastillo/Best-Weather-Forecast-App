//
//  ModelRealTimeWeather.swift
//  Best Weather Forecast App
//
//  Created by Ian Castillo on 26/08/23.
//

import Foundation

struct RealtimeWeatherResponse: Codable {
    let current: RealtimeWeather
}

struct RealtimeWeather: Codable {
    let last_updated: String
    let temp_c: Decimal
    let condition: WeatherCondition
}

struct WeatherCondition: Codable {
    let text: String
    let icon: String
    let code: Int
}
