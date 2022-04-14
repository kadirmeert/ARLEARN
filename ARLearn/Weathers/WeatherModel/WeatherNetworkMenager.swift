//
//  WeatherNetworkMenager.swift
//  ARLearn
//
//  Created by MERT on 24.11.2021.
//

import Foundation

public class WeatherNetworkMenager: ObservableObject{
    
    @Published var recievedWeatherData: WeatherModel?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=be7dca9f90ed1c9eebb73cbe46ffbffe&units=metric"
    
    public func fetchdata(cityName: String) {
        
        let weatherURlString = "\(weatherURL)&q=\(cityName)"
        
        if let url = URL(string: weatherURlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error)  in
                
                if error != nil {
                    fatalError("\(String(describing: error?.localizedDescription))")
                }
                
                if let recievedData = data {
                    
                    if let decodeData = self.decodeJSONData(recievedData: recievedData) {
                        
                        let weatherData = self.convertDecodedDataToUsableForm(decodedData: decodeData)
                        
                        self.passData(weatherData: weatherData)
                        
                    }
                    
                }
            }
            task.resume()
            
        }
    }
    private func decodeJSONData(recievedData: Data) -> WeatherData?{
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: recievedData)
            return decodedData
        } catch  {
            return nil
        }
    }
    
    
    private func convertDecodedDataToUsableForm(decodedData: WeatherData) -> WeatherModel{
        
        let weatherData = WeatherModel(cityName: decodedData.name, temperature: decodedData.main.temp, conditionID: decodedData.weather[0].id)
        return weatherData
    }
    private func passData(weatherData: WeatherModel){
        
        recievedWeatherData = weatherData
        
    }
    
}
