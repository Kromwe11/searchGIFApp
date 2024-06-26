//
//  GIFEntity.swift
//  searchGIFApp
//
//  Created by Висент Щепетков on 26.06.2024.
//

import Foundation

struct GIFResponse: Codable {
    let data: [GIFData]
}

struct GIFData: Codable {
    let type: String
    let id: String
    let url: String
    let images: GIFImages
}

struct GIFImages: Codable {
    let original: GIFImageDetails
    let downsized: GIFImageDetails
    let downsized_large: GIFImageDetails
    let downsized_medium: GIFImageDetails
    let downsized_small: GIFVideoDetails
    let downsized_still: GIFImageDetails
    let fixed_height: GIFImageDetails
    let fixed_height_downsampled: GIFImageDetails
    let fixed_height_small: GIFImageDetails
    let fixed_height_small_still: GIFImageDetails
    let fixed_height_still: GIFImageDetails
    let fixed_width: GIFImageDetails 
}

struct GIFImageDetails: Codable {
    let height: String
    let width: String
    let size: String
    let url: String
    let mp4_size: String?
    let mp4: String?
    let webp_size: String?
    let webp: String?
}

struct GIFVideoDetails: Codable {
    let height: String
    let width: String
    let mp4_size: String
    let mp4: String
}
