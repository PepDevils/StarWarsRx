//
//  SWResultsModel.swift
//  StarWarsRx
//
//  Created by Pepdevils on 14/02/2018.
//  Copyright © 2018 Pepdevils. All rights reserved.
//

import Foundation

struct SWResultsModel: Decodable{
    let results: [SWPeopleModel]
    let count: Int
    let next: String
    let previous: String?
    
}
