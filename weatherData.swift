//
//  weatherData.swift
//  weatherApp
//
//  Created by Ethan  Jin  on 18/2/2022.
//

import Foundation

//  weather is an object we set up
//  data is a list type of weather, which is a variable item/object
   
var selectedRow = 0

struct Weather: Decodable{
    let city: String
    let latitude: Double
    let longitude: Double
    let max: Double
    let min: Double
//    let description: String // no need to initialise, which means show what variable/types will be used and taken in as parameters, because structs in swift already automatically initialise
}

struct weatherTab: Decodable{
    var description: String
    var color: String
    var temp: Int
}

var emoji: [weatherTab] = [weatherTab](repeating: weatherTab(description: "", color: "", temp: 0), count: 63)

var cities: [Weather] = [Weather](repeating: Weather(city: "Loading...", latitude: 1.3, longitude: 1.3, max: 1.3, min: 1.3), count: 63)




