//
//  WeatherView.swift
//  Best Weather Forecast App
//
//  Created by Ian Castillo on 26/08/23.
//

import SwiftUI

struct WeatherDetailsView: View {
    @ObservedObject var viewModel: WeatherViewModel // 1. Add the ViewModel as an ObservedObject
    let gradient = Gradient(colors: [Color.blue.opacity(0.7), Color.blue])

    var body: some View {
        ScrollView {
            if let weather = viewModel.realtimeWeather { // Use viewModel.realtimeWeather
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

                        // Bigger weather icon
                        AsyncImage(url: "https:\(weather.condition.icon)")
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color.white)
                                    .frame(width: 115, height: 115)
                            )
                    }
                    .padding(.horizontal)

                    // Display the forecast
                    ForEach(viewModel.forecast, id: \.date) { day in // Use viewModel.forecast
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

                            AsyncImage(url: "https:\(day.day.condition.icon)")
                                .scaledToFit()
                                .frame(width: 80, height: 80)
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
            } 
        }
        .background(LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all))
        .refreshable { // 2. Add the refreshable modifier
            viewModel.refreshData()
        }
    }
}
