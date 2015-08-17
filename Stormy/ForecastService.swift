//
//  ForecastService.swift
//  Stormy
//
//  Created by ANTHONY O. on 8/4/15.
//  Copyright (c) 2015 ANTHONY O. All rights reserved.
//

import Foundation

struct ForecastService {
    let forecastAPIKey: String
    let forecastBaseURL: NSURL?
    
    init(APIKey: String){
        forecastAPIKey = APIKey
        forecastBaseURL = NSURL(string: "https://api.forecast.io/forecast/\(forecastAPIKey)/")
    }
    
    func getForecast(lat: Double, long: Double, completion: (CurrentWeather? -> Void)){
        if let forecastUrl = NSURL(string: "\(lat),\(long)", relativeToURL: forecastBaseURL) {
            
            let networkOperation = NetworkOperation(url: forecastUrl)
            
            networkOperation.downloadJSONFromURL {
                (let JSONDictionary) in
                let currentWeather = self.currentWeatherFromJSON(JSONDictionary)
                completion(currentWeather)
            }
        } else {
            println("Could not construct a valid URL")
        }
    }
    
    func currentWeatherFromJSON(jsonDictionary: [String: AnyObject]?) -> CurrentWeather?{
        if let currentWeatherDictionary = jsonDictionary?["currently"] as? [String: AnyObject] {
            return CurrentWeather(weatherDictionary: currentWeatherDictionary)
        } else{
            println("JSON dictionary returned nil for 'currently' key")
            return nil
        }
    }
}




































