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
    let gradient = Gradient(colors: [Color.blue.opacity(0.7), Color.blue])

    var body: some View {
        ScrollView {
            if let weather = realtimeWeather {
                VStack(spacing: 20) {
                    // Real-time weather details
                    HStack {
                        VStack(alignment: .leading) {
                            Text(weather.condition.text)
                                .font(.title)
                                .fontWeight(.bold)

                            Text("\(String(describing: weather.temp_c))°C")
                                .font(.largeTitle)
                                .fontWeight(.thin)
                        }

                        Spacer()

                        AsyncImage(url: weather.condition.icon)
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.white)
                                    .frame(width: 130, height: 130)
                            )
                    }
                    .padding(.horizontal)

                    // Display the forecast
                    ForEach(forecast, id: \.date) { day in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(day.date)
                                    .font(.title2)
                                    .fontWeight(.medium)
                                Text("\(String(describing: day.day.mintemp_c))°C - \(String(describing: day.day.maxtemp_c))°C")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }

                            Spacer()

                            AsyncImage(url: day.day.condition.icon)
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white.opacity(0.7))
                        )
                        .padding(.vertical, 5)
                    }
                }
                .padding(.horizontal)
                .background(LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(15)
                .padding()
            } else {
                Text("No weather data available")
                    .font(.title2)
                    .padding()
            }
        }
        .background(LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all))
    }
}
