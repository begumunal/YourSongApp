//
//  ArtistModel.swift
//  YourSong
//
//  Created by Begum Unal on 10.05.2023.
//

import Foundation

class ArtistModel: Codable {
    let data: [ArtistDatum]
}

// MARK: - Datum
struct ArtistDatum: Codable {
    let id: Int
    let name: String
    let picture: String
    let pictureSmall, pictureMedium, pictureBig, pictureXl: String
    let radio: Bool
    let tracklist: String
    let type: String

    enum CodingKeys: String, CodingKey {
        case id, name, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
        case radio, tracklist, type
    }
}
