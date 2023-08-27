//
//  WeatherView.swift
//  Best Weather Forecast App
//
//  Created by Ian Castillo on 26/08/23.
//

import SwiftUI

struct WeatherCardView: View {
    @ObservedObject var viewModel = WeatherViewModel()

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading weather data...")
            } else if let _ = viewModel.error {
                VStack(spacing: 10) {
                    // Display empty card for realtime weather with placeholder values
                    CardView(title: "Today",
                             temp: nil,
                             condition: nil)
                        .padding(.bottom, 10)

                    // Display empty card for forecast with placeholder values
                    CardView(title: "Date Placeholder",
                             temp: nil,
                             condition: nil)

                    // Retry button
                    Button(action: {
                        viewModel.fetchWeatherData(forCity: "Seattle")
                    }) {
                        Text("Retry")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            } else {
                CardView(title: "Today",
                         temp: viewModel.realtimeWeather?.temp_c,
                         condition: viewModel.realtimeWeather?.condition.text)
                    .padding(.bottom, 10)

                ForEach(viewModel.forecast) { day in
                    CardView(title: day.date,
                             temp: day.day.maxtemp_c,
                             condition: day.day.condition.text)
                }
            }
        }
        .onAppear {
            viewModel.fetchWeatherData(forCity: "Seattle")
        }
        .padding()
    }
}

struct CardView: View {
    var title: String
    var temp: Decimal?
    var condition: String?

    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            
            HStack {
                Image(systemName: "cloud.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.trailing, 10)

                VStack(alignment: .leading) {
                    Text(condition ?? "Condition Placeholder")
                        .font(.title2)
                    Text("\(temp?.description ?? "N/A")°C")
                        .font(.title)
                        .bold()
                }
            }
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(10)
    }
}
