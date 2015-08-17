//
//  ViewController.swift
//  Stormy
//
//  Created by ANTHONY O. on 8/2/15.
//  Copyright (c) 2015 ANTHONY O. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var currentTemperatureLabel: UILabel?
    
    @IBOutlet weak var currentHumidityLabel: UILabel?
    
    @IBOutlet weak var currentPrecipitaionLabel: UILabel?
    
    @IBOutlet weak var currentWeatherIcon: UIImageView?
    
    @IBOutlet weak var currentWeatherSummary: UILabel?
    
    @IBOutlet weak var refreshButton: UIButton?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    
    private let forecastAPIKey = "bdf2398e989760c3f96bdbe0ea928170"
    let coordinate: (lat: Double, long: Double) = (37.8267,-122.423)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        retrieveWeatherForecast()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func retrieveWeatherForecast() {
        let forecastService = ForecastService(APIKey: forecastAPIKey)
        forecastService.getForecast(coordinate.lat, long: coordinate.long) {
            (let currently) in
            if let currentWeather = currently {
                //Update UI
                dispatch_async(dispatch_get_main_queue()) {
                    
                    if let temperature = currentWeather.temperature{
                        self.currentTemperatureLabel?.text = "\(temperature)º"
                    }
                    if let humidity = currentWeather.humidity{
                        self.currentHumidityLabel?.text = "\(humidity)%"
                    }
                    if let precipitation = currentWeather.precipProbability{
                        self.currentPrecipitaionLabel?.text = "\(precipitation)%"
                    }
                    if let icon = currentWeather.icon{
                        self.currentWeatherIcon?.image = icon
                    }
                    if let summary = currentWeather.summary{
                        self.currentWeatherSummary?.text = summary
                    }
                    self.toggleRefreshAnimation(false)
                }
            }
        }

    }
    
    
    @IBAction func refreshWeather() {
        toggleRefreshAnimation(true)
        retrieveWeatherForecast()
    }
    
    func toggleRefreshAnimation(on: Bool) {
        refreshButton?.hidden = on
        if on {
            activityIndicator?.startAnimating()
        } else {
            activityIndicator?.stopAnimating()
        }
    }

}










