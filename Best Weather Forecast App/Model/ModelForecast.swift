//
//  ModelForecast.swift
//  Best Weather Forecast App
//
//  Created by Ian Castillo on 26/08/23.
//

import Foundation

struct ForecastResponse: Codable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Codable {
    let date: String
    let day: DayElement
    let astro: AstroElement
    let hour: [HourElement]
}

struct DayElement: Codable {
    let maxtemp_c: Decimal
    let mintemp_c: Decimal
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
