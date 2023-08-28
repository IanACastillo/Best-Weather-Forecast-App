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
                        let encodedCity = encodeCityName(cityName: searchText)
                        viewModel.fetchWeatherData(forCity: encodedCity)
                    }) {
                        Text("Search")
                    }
                }
                
                // Passing viewModel directly instead of individual properties
                WeatherDetailsView(viewModel: viewModel)
                Spacer() // To make sure other elements stay on top
            }
            .padding(.top, 20)
            .navigationBarTitle("Weather")
        }
    }
}

func encodeCityName(cityName: String) -> String {
    return cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? cityName
}
