//
//  User.swift
//  MVCPatternTraining
//
//  Created by NewMac on 8/9/21.
//

import Foundation

struct User: Codable {
    var id: Int?
    var name, username, email: String?
    var address: Address?
    var phone, website: String?
    var company: Company?
    var isExpanded: Bool? = false
    var isHidden: Bool? = false
}

// MARK: - Address
struct Address: Codable {
    var street, suite, city, zipcode: String?
    var geo: Geo?
}

// MARK: - Geo
struct Geo: Codable {
    var lat, lng: String?
}

// MARK: - Company
struct Company: Codable {
    var name, catchPhrase, bs: String?
}
