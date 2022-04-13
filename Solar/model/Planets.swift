//
//  Planets.swift
//  Solar
//
//  Created by Parth Antala on 2022-03-31.
//

import Foundation
class Planets : Codable{
    var id : String = ""
    var englishName: String = ""
    var name: String = ""
    var bodyType: String = ""
    var avgTemp: Double?
    var gravity: Double?
    var density: Double?
    var escape:Double?
    
}

class BodyCollection: Codable{
    var bodies : [Planets] = [Planets]()
}
