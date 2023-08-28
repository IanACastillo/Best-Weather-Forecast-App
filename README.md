# Best Weather Forecast App

Welcome to the Best Weather Forecast App! This app is built using SwiftUI and allows users to search for weather conditions in cities across the globe. Below you'll find instructions on how to run the app, an overview of design decisions, and a few challenges faced during the development.

How to Run the App

## Prerequisites:
Make sure you have Xcode installed (Version 12 or higher recommended).
Ensure you have a Mac running macOS Catalina or later.
Clone the Repository:
Open the terminal and run:
bash
Copy code
git clone https://github.com/IanACastillo/Best-Weather-Forecast-App.git
Open the Project in Xcode:
Navigate to the cloned directory and open the .xcodeproj or .xcworkspace file.

## Run the App:
Choose your desired simulator or connect an iOS device.
Press the play button (or Cmd + R) in Xcode to build and run the app.

## Design Decisions

MVVM Architecture: The app utilizes the MVVM (Model-View-ViewModel) architecture. This helps in keeping the UI code separated from the business logic, ensuring clean and maintainable code.
Caching Images: To optimize performance and reduce unnecessary network requests, images are cached using a custom image caching mechanism.
Error Handling: The app provides clear messages in case of network failures or issues with data fetching.
SwiftUI: Leveraging SwiftUI ensures a more declarative and efficient way to build the UI components and manage the app's state.

## Challenges Encountered

API Limitations: Fetching detailed weather data required handling various edge cases, especially when the API returns incomplete or inconsistent data.
Image Caching: Implementing an efficient image caching mechanism without third-party libraries was challenging. This was eventually achieved using NSCache.

