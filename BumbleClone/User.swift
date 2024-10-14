//
//  User.swift
//  SpotifyClone
//
//  Created by Vanya Mutafchieva on 08/10/2024.
//

import Foundation

struct UserArray: Codable {
    let users: [User]
    let total, skip, limit: Int
}

struct User: Codable, Identifiable {
    let id: Int
    let firstName, lastName, maidenName: String
    let age: Int
    let email, phone, username, password: String
    let image: String
    let height, weight: Double
    
    static var mock = User(
        id: 444,
        firstName: "Vanya",
        lastName: "Moo",
        maidenName: "",
        age: 76,
        email: "hi@hi.com",
        phone: "",
        username: "",
        password: "",
        image: Constants.randomImage,
        height: 170,
        weight: 55
    )
}
