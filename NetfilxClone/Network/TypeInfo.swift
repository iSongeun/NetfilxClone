//
//  TypeInfo.swift
//  NetfilxClone
//
//  Created by 이송은 on 2023/03/15.
//

import Foundation

enum MediaType : Int, CaseIterable {
    case movie
    case podcast
    case music
    case musicVideo
    
    var queryValue : String {
        return "\(self)"
    }
    
    var title : String {
        switch self {
        case .movie:
            return "영화"
        case .podcast:
            return "팟캐스트"
        case .music:
            return "뮤직"
        case .musicVideo:
            return "뮤직비디오"

        }
    }
}
