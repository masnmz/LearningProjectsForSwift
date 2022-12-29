//
//  Photo.swift
//  Flickr Client App
//
//  Created by Mehmet Alp Sönmez on 30.11.2022.
//

import Foundation

struct Photo: Codable {
    let id, owner, secret, server: String?
    let farm: Int?
    let title: String?
    let ispublic, isfriend, isfamily: Int?
    let description: Description?
    let ownername, iconserver: String?
    let iconfarm: Int?
    let urlN: String?
    let heightN, widthN: Int?
    let urlZ: String?
    let heightZ, widthZ: Int?

    enum CodingKeys: String, CodingKey {
        case id, owner, secret, server, farm, title, ispublic, isfriend, isfamily
        case description = "description"
        case ownername, iconserver, iconfarm
        case urlN = "url_n"
        case heightN = "height_n"
        case widthN = "width_n"
        case urlZ = "url_z"
        case heightZ = "height_z"
        case widthZ = "width_z"
    }
}
extension Photo{
    var buddyIconurl: String? {
        if let iconServer = iconserver,
           let iconfarm = iconfarm,
           let nsid = owner,
           NSString(string: iconServer).intValue > 0{
            return "http://farm\(iconfarm).staticflickr.com/\(iconServer)/buddyicons/\(nsid).jpg"
            
        }else{
            return "https://www.flickr.com/images/buddyicon.gif"
            
        }
    }
}
// MARK: - Description
struct Description: Codable {
    let content: String

    enum CodingKeys: String, CodingKey {
        case content = "_content"
    }
}
