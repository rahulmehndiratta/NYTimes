//
//  NYNewsListModel.swift
//  NYTimes
//
//  Created by Apple on 17/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

enum MediaType: String {
    case pdf, image, video
}


struct NYNewsListModel: Parsable  {
    var byLine: String?
    var title: String?
    var url: String?
    var section: String?
    var publishedDate: String?
    var media: Media?
    
    init?(withJSON json: [String : Any]) {
        guard let byLine = json[APIKeys.byline] as? String,
            let title = json[APIKeys.title] as? String,
            let url = json[APIKeys.url] as? String,
            let section = json[APIKeys.section] as? String,
            let publishedDate = json[APIKeys.published_date] as? String else {
                return nil
        }
        self.byLine = byLine
        self.title = title
        self.url = url
        self.section = section
        self.publishedDate = publishedDate
        
    }
}


struct Media: Parsable {
    
    var type: String
    var mediaMetadata: [MediaMetadata]?
    var mediaType: MediaType? {
        return MediaType(rawValue: type)
    }
    init?(withJSON json: [String : Any]) {
        guard let type = json[APIKeys.type] as? String else { return nil }
        self.type = type
        if let metaData = json[APIKeys.metaData] as? [[String: Any]] {
            self.mediaMetadata = metaData.compactMap({MediaMetadata(withJSON: $0)})
        }
    }


    struct MediaMetadata: Parsable {
        var url: String
        var height: Double?
        var width: Double?
        init?(withJSON json: [String : Any]) {
            guard let url = json[APIKeys.url] as? String else { return nil }
            self.url = url
            self.height = json[APIKeys.height] as? Double
            self.width = json[APIKeys.width] as? Double
        }

    }
}
