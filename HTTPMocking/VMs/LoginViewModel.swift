//
//  LoginViewModel.swift
//  HTTPMocking
//
//  Created by The App Experts on 12/04/2023.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    var username: String = ""
    var password: String = ""
    @Published var userVM: UserViewModel?
    
    var client: HTTPClientProtocol
    
    init(client: HTTPClientProtocol) {
        self.client = client
    }
    
    func login() {
        self.client.authenticate(self.username, self.password) { userObj in
            if let user = userObj {
                DispatchQueue.main.async {
                    self.userVM = UserViewModel(user)
                }
            }
        }
    }
}
