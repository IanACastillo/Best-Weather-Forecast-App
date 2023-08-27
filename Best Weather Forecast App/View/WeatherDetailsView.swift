//
//  WeatherView.swift
//  Best Weather Forecast App
//
//  Created by Ian Castillo on 26/08/23.
//

import SwiftUI

struct WeatherDetailsView: View {
    var realtimeWeather: RealtimeWeather?
    var forecast: [ForecastDay]

    var body: some View {
        ScrollView {
            if let weather = realtimeWeather {
                VStack(spacing: 20) {
                    // Real-time weather details
                    HStack {
                        Text(weather.condition.text)
                            .font(.largeTitle)
                            .padding()

                        Spacer()

                        Text("\(String(describing: weather.temp_c))°C")
                            .font(.largeTitle)
                            .padding()

                        AsyncImage(url: weather.condition.icon)
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    }

                    // Display the forecast
                    ForEach(forecast, id: \.date) { day in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(day.date)
                                    .font(.title2)
                                Text("\(String(describing: day.day.mintemp_c))°C - \(String(describing: day.day.maxtemp_c))°C")
                                    .font(.subheadline)
                            }

                            Spacer()

                            AsyncImage(url: day.day.condition.icon)
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                        .padding(.vertical)
                        Divider()
                    }
                }
                .padding(.horizontal)
            } else {
                Text("No weather data available")
                    .font(.title2)
                    .padding()
            }
        }
    }
}
