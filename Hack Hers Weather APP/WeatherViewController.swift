//
//  WeatherViewController.swift
//  Hack Hers Weather APP
//
//  Created by Salman Fakhri on 2/19/20.
//  Copyright © 2020 Salman Fakhri. All rights reserved.
//

import UIKit

struct TemperatureData: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
}

struct WeatherAPIResponse: Codable {
    let name: String
    let main: TemperatureData
}

class WeatherViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    
    var currentWeatherData: WeatherAPIResponse? {
        didSet {
            updateLabel()
        }
    }
    
    var zipcode: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getWeather()
    }
    
    func updateLabel() {
        guard let currentWeatherData = currentWeatherData else {
            return
        }
        
        cityLabel.text = currentWeatherData.name
        tempLabel.text = "\(currentWeatherData.main.temp) F"
        lowLabel.text = "\(currentWeatherData.main.temp_min) F"
        highLabel.text = "\(currentWeatherData.main.temp_max) F"
        
    }
    
    func getWeather() {
        guard let zipcode = zipcode else {
            print("invalid zipcode")
            return
        }
        
        let endpoint = "https://api.openweathermap.org/data/2.5/weather?zip=" + zipcode + ",us&appid=<INSERT API KEY HERE>&units=imperial"
                
        let url = URL(string: endpoint)!

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }

            guard let data = data else {
                return
            }

            do {
                let weatherData = try JSONDecoder().decode(WeatherAPIResponse.self, from: data)
                print(weatherData)
                DispatchQueue.main.async {
                    self.currentWeatherData = weatherData
                }
            } catch {
                print(error)
            }

        }.resume()
    }


}
