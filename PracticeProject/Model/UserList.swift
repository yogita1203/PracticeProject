//
//  UserList.swift
//  PracticeProject
//
//  Created by Arpita More on 01/10/21.
//

import Foundation
import SwiftUI

struct User : Decodable,Hashable, Identifiable{
    let id: Int
    let name, email: String
    let companyName: String
    let cityName : String
    
    
    enum CodingKeys: String, CodingKey {
            case id
            case name
            case email
            case address
            case company
        }
        
    enum CompanyCodingKeys: String, CodingKey {
        case name
    }
    
    enum AddressCodingKeys: String, CodingKey {
        case city
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
            
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        let companyDetails = try container.nestedContainer(keyedBy: CompanyCodingKeys.self, forKey: .company)
        companyName = try companyDetails.decode(String.self, forKey: .name)
        let addressDetails = try container.nestedContainer(keyedBy: AddressCodingKeys.self, forKey: .address)
        cityName = try addressDetails.decode(String.self, forKey: .city)
        
    }

}

