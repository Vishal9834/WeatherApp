//
//  APIService.swift
//  WeatherTets
//
//  .
//  .
//

import Foundation

protocol APIServiceProtocol {
    func getWeatherData(urlString:String , complete : @escaping (_ success:Bool , _ weatherData:Any, _  error:Error?)
    -> ())
    
}


class APIService : APIServiceProtocol{
    
    func getWeatherData(urlString:String, complete: @escaping (Bool, Any, Error?) -> ()) {
        
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            if(error != nil){
                print("error")
            }else{
                do{
                    var json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                    let resultDict =  json["list"] as! [Dictionary<String,Any>]
                    
                    print(resultDict)

                    
                    complete( true, resultDict, nil )
                    
                }catch let error as NSError{
                    print(error)
                }
            }
        }).resume()
        
    }
}
