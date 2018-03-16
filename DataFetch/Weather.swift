//
//  Weather.swift
//  Testing purpose only
//
//  Created by ANURAG ADARSH on 13/03/18.
//  Copyright © 2018 ANURAG ADARSH. All rights reserved.
//

import Foundation
//
//"weather":[
//{
//"id":300,
//"main":"Drizzle",
//"description":"light intensity drizzle",
//"icon":"09d"
//}
//]
struct WeatherReport{
    typealias WeatherToupleType = (id:Int,main:String,description:String,icon:String)
    typealias MainToupleType = (temp:Double,temp_min:Double,temp_max:Double)
    let coordinate:(lon:Double,lat:Double)
    let weathers:[WeatherToupleType]
    let main:MainToupleType
    let name:String
    
    enum JsonSerializationError:Error {
        case missing(String)
        case invalid(String,Any)
    }
    
    
fileprivate static let urlComponents: URLComponents = URLComponents(string: "")! // base URL components of the web service
    
}
extension WeatherReport{
//    "coord":{
//    "lon":145.77,
//    "lat":-16.92
//    }
    
    init(json:[String:AnyObject]) throws{
        guard let name = json["name"] as? String ,
        let coordinate = json["coord"] as? [String:Double],
        let lat = coordinate["lat"],
        let lon = coordinate["lon"],
        let main = json["main"] as? [String:AnyObject],
        let temp = main["temp"] as? Double,
        let min_temp = main["temp_min"] as? Double,
        let max_temp = main["temp_max"] as? Double,
            let weatherJson = json["weather"] as? [AnyObject] else {
                throw JsonSerializationError.invalid("Weather", json)
        }
        
        var weathers:Array<WeatherToupleType> = []
        
        
        for weatherUpdate in weatherJson {
            guard let id1 = weatherUpdate["id"] as? Int,
            let main1 = weatherUpdate["main"] as? String,
            let description1 = weatherUpdate["description"] as? String,
            let icon1 = weatherUpdate["icon"] as? String
                else{
                    throw JsonSerializationError.missing("object not found")
            }
            
            weathers.append((id:id1,main:main1,description:description1,icon:icon1))
        }
        self.name = name
        self.coordinate = (lon:lon,lat:lat)
        self.weathers = weathers
        self.main = (temp:temp,temp_min:min_temp,temp_max:max_temp)
    }
//    "main":{
//    "temp":300.15,
//    "pressure":1007,
//    "humidity":74,
//    "temp_min":300.15,
//    "temp_max":300.15
//    }
}
