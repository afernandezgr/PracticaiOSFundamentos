//
//  Episode.swift
//  Westeros
//
//  Created by Adolfo Fernandez on 24/2/18.
//  Copyright © 2018 Adolfo Fernandez. All rights reserved.
//

import Foundation

// MARK: - Episode
final class Episode {
    let name: String
    let launchDate : Date
    weak var season: Season?
   
    init(name: String, launchDate: Date, season: Season) {
        self.name = name
        self.launchDate = launchDate
        self.season = season
       
    }
}


// MARK: - Proxies
extension Episode {
    var proxyForEquality: String {
        return "\(name) \(season?.name ?? "")"
    }
    
    var proxyForComparison: String {
        return name
    }
}



// MARK: - Hashable
extension Episode: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

// MARK: - Equatable
extension Episode: Equatable {
    static func ==(lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

// MARK: - Comparable
extension Episode: Comparable {
    static func <(lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}


// MARK: - CustomStringConvertible
extension Episode: CustomStringConvertible {
    var description: String {
        return "Nombre Temporada: \(season!.name) Nombre Episodio:\(name) Fecha lanzamiento:\(launchDate)"
    }
}
