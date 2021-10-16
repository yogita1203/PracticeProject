//
//  UserRowView.swift
//  PracticeProject
//
//  Created by Arpita More on 02/10/21.
//

import SwiftUI

struct UserRowView: View {
    var user : User

    var body: some View {
        VStack(alignment: .leading) {
                        
            Text("ID : \(user.id)")
                .font(.title)
                .fontWeight(.bold)
            Text("Name : \(user.name)")
                .font(.body)
                .fontWeight(.bold)
            Text("Email : \(user.email)")
                .font(.body)
                .fontWeight(.semibold)
            Text("City : \(user.cityName)")
                .font(.body)
                .fontWeight(.semibold)
            Text("Company : \(user.companyName)")
                .font(.body)
                .fontWeight(.semibold)
            Spacer()
        }
    }
}

