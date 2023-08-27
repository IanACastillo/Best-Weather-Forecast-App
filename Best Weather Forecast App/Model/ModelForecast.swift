//
//  ModelForecast.swift
//  Best Weather Forecast App
//
//  Created by Ian Castillo on 26/08/23.
//

import Foundation

struct ForecastAPIResponse: Codable {
    let forecast: ForecastResponse
}

struct ForecastResponse: Codable {
    let location: Location
    let current: RealtimeWeather
    let forecast: Forecast
}

struct ForecastDay: Codable, Identifiable {
    var id: String { date }
    let date: String
    let day: DayElement
    let astro: AstroElement
    let hour: [HourElement]
}

struct DayElement: Codable {
    let maxtemp_c: Decimal
    let mintemp_c: Decimal
    let condition: WeatherCondition
}

struct AstroElement: Codable {
    let sunrise: String
    let sunset: String
}

struct HourElement: Codable {
    let time: String
    let temp_c: Decimal
    let condition: WeatherCondition
}

struct WeatherApiResponse: Codable {
    let location: Location
    let current: RealtimeWeather
}

struct Location: Codable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let tz_id: String
    let localtime_epoch: Int
    let localtime: String
}

struct Forecast: Codable {
    let forecastday: [ForecastDay]
}


