//
//  Photo.swift
//  PhotoGalleryApp
//
//  Created by Algazzar on 04/02/2022.
//

import Foundation

struct Photo: Decodable{
    
    var id: String?
    var photosUrls: PhotosUrls?
    var sponsorShip: sponsorShip?
    var inFavorites: Bool?
    
    enum CodingKeys: String ,CodingKey {
        
        case id = "id"
        case photosUrls = "urls"
        case sponsorShip = "sponsorship"
        case inFavorites = "liked_by_user"

    }
}


struct PhotosUrls: Decodable{
    
    var photoRegular: String?
    
    enum CodingKeys: String ,CodingKey {
        
        case photoRegular = "regular"
    }
}

struct sponsorShip: Decodable{
    
    var tagLine: String?
    var sponsor: Sponsor?
    
    enum CodingKeys: String ,CodingKey {
        
        case tagLine = "tagline"
        case sponsor = "sponsor"
    }
}

struct Sponsor: Decodable{
    
    var profileImage: SponserProfileImages?
    
    enum CodingKeys: String ,CodingKey {
        
        case profileImage = "profile_image"
    }
}

struct SponserProfileImages: Decodable{
    
    var medium: String?
}
