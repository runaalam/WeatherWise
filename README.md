# WeatherWise

## Overview
- Demonstrates the MVVM (Model-View-ViewModel) architecture pattern for a weather app.
- Utilises URLSession, SwiftUI, Cache, UserDefaults, and Combine, MKLocalSearchCompletion, MKLocalSearchCompleterDelegate.
- Showcases structured code for improved maintainability.

## Features
- Search for weather by city name.
- Autocomplete suggestions for city and country names.
- View recent weather history.
- Delete entries from the weather history.
- Detailed weather information with icons.
- Choose between imperial or metric units.
- Unit test for helper class and other services

## Architecture
- Follows MVVM design pattern for clear separation of concerns.
- View: SwiftUI views responsible for the user interface.
- ViewModel: Classes conforming to ObservableObject, managing view logic.
- Model: Data entities representing API responses and view data.
- Service: Handles data retrieval from external APIs.
- APIClient: Defines a common interface for making API requests.
- CacheClientProtocol: Manages data caching.
- CityCacheClient: Specifically handles caching for city data models.

## Components Overview
- View: The View layer consists of SwiftUI views responsible for rendering the user interface. In this project, the SearchViewModel and WeatherSummaryViewModel are two primary views responsible for displaying the list of recently searched and individual city weather details, respectively.
- ViewModel: The ViewModel layer contains classes conforming to ObservableObject and serves as an intermediary between the View and Model layers.
- Model: The Model layer represents the data entities used in the application. Response models communicate with API response data, and Data model communicate with view through ViewModel
- Service: The Service layer is responsible for fetching data from an external API or data source. In this project, the WeatherAPIService class handles the API communication by utilising the APIClient protocol. 
- APIClient: The APIClient protocol defines a common interface for making API requests and fetching data. It includes a method called fetchDataPublisher and fetchData, one uses Combine AnyPublisher another uses Completion handler for accepts a generic type for decoding the response data.
- CacheClientProtocol: The class is responsible for caching any kind data for this project. There are default implementation for fetch, save and delete in the extension and any service can share it
- CityCacheClient: This class handle cache service for city data model

## Compatibility
- The WeatherWise is designed to run on iOS devices running iOS 16.4 and later versions.

