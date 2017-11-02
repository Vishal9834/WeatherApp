//
//  WeatherListViewModel.swift
//  WeatherTets
//
//  .
//  .
//

import Foundation

typealias DictionaryType = Dictionary<String,Any>
typealias ArrayOfDictionary = [DictionaryType]

class WeatherListViewModel{
    
    let apiService: APIServiceProtocol
    var cityList:Array<Int>
    var weatherData = Array<WeatherModel>()

   
    
    init( apiService: APIServiceProtocol,cityList: Array<Int> ) {
        self.apiService = apiService
        self.cityList = cityList
        
       
    }
    
    
    func initFetch(completion:@escaping (Array<WeatherModel>)->() ) {
        
//     http://api.openweathermap.org/data/2.5/group?id=4163971,2174003,2147714&units=metricc&APPID=470697c8ab42de1f0ae8220a7e2a403c
        
        var urlString:String
        urlString = "http://api.openweathermap.org/data/2.5/group?id=\(Constant.CityId.sydneyId),\(Constant.CityId.melbourne),\(Constant.CityId.brisbane)&units=metricc&APPID=\(Constant.APIKeys.APPID)"
        
        self.apiService.getWeatherData(urlString:urlString) { [weak self](success, dataList, error) in
            
            
            let resp = dataList as! ArrayOfDictionary
            
            for dict in resp{
                
                self?.weatherData.append((self?.processFetchedData(dict["main"] as! DictionaryType))!)

            }
            
             //let resp = (self?.processFetchedData(dict))
           //  self?.weatherData.append(resp!)
            completion((self?.weatherData)!)

        }
        
        }
    
    
    private func processFetchedData(_ lDict:DictionaryType) -> WeatherModel{
        
        
        
        return  WeatherModel(temp: lDict["temp"]  as? Double ?? 0 , pressure: lDict["pressure"]  as? Double ?? 0, humidity: lDict["humidity"] as? Double ?? 0, temp_min: lDict["temp_min"] as? Double ?? 0, temp_max: lDict["temp_max"] as? Double ?? 0)
        
        
        
    }
    
    }



