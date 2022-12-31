//
//  getPhotosURLReponse.swift
//  VirtualTourist
//
//  Created by Yuan Gao on 12/30/22.
//

import Foundation
struct getPhotosURLResponse: Codable{
    let photos: Photos
}



struct Photos: Codable{
    let page: Int
    let pages: Int
    let total: Int
    let photo: [Photo]
}

struct Photo: Codable{
    let id: String
    let secret: String
    let url: String
    enum CodingKeys: String, CodingKey {
        case id
        case secret
        case url = "url_m"
    }
}
