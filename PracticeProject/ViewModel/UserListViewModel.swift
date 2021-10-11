//
//  UserListViewModel.swift
//  PracticeProject
//
//  Created by Arpita More on 02/10/21.
//

import Foundation
import SwiftUI
class UserListViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var loading = false
    @Published var selectedUser: User? {
            didSet {
                if self.selectedUser != nil {
                    self.getUsersList(excludingUserWithID: String(self.selectedUser!.id))
                }
            }
        }
    init() {
        self.loading = true
        self.getUsersList(excludingUserWithID: "")
    }
    func getUsersList(excludingUserWithID : String)  {
        APIManager.make().fetchUsers(excludingUserWithID: excludingUserWithID, success: { usersList in
            DispatchQueue.main.async {
                self.users = usersList
                self.loading = false
            }
            
        }, failure: { error in
            print("Error : \(error.localizedDescription)")
            
        })
            
        }
       
    }
