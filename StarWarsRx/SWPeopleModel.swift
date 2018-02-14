//
//  SWPeopleModel.swift
//  StarWarsRx
//
//  Created by DEZVEZESDEZ on 14/02/2018.
//  Copyright © 2018 Pepdevils. All rights reserved.
//

import Foundation

struct SWPeopleModel: Decodable{
    let name:String
    let species:[String]
    let vehicles:[String]
    let gender:String
    let homeworld:String
    let skin_color:String
    
}
