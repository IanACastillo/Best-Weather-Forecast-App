//
//  ContentView.swift
//  Best Weather Forecast App
//
//  Created by Ian Castillo on 27/08/23.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText: String = ""
    @ObservedObject var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                SearchBar(text: $searchText)
                
                if !searchText.isEmpty {
                    Button(action: {
                        // Here we encode the city name and then send it to the viewModel to fetch data
                        let encodedCity = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? searchText
                        viewModel.fetchWeatherData(forCity: encodedCity)
                    }) {
                        Text("Search")
                    }
                }
                
                if let realtimeWeather = viewModel.realtimeWeather {
                    WeatherDetailsView(realtimeWeather: realtimeWeather, forecast: viewModel.forecast)
                } else {
                    Spacer() // This will center the search bar and button at the top when no data is present
                }
                
            }
            .padding(.top, 20)
            .navigationBarTitle("Weather")
        }
    }
}

func encodeCityName(cityName: String) -> String {
    return cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? cityName
}
