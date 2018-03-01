//
//  House.swift
//  Westeros
//
//  Created by Adolfo Fernandez on 08/02/2018.
//  Copyright © 2018 Adolfo Fernandez. All rights reserved.
//

import UIKit

extension Date {
    
    init(dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "dd-MM-yyyy"
        let d = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:d)
    }
    
    func toString(dateFormat format : String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}


typealias Words = String
typealias Members = Set<Person>
enum Houses : CustomStringConvertible {
              case Stark
              case Lannister
              case Targaryen
              case Baratheon
              case Arryn
              case Tully
    
    var description: String {
        switch self {
        case .Stark: return "Stark"
        case .Lannister: return "Lannister"
        case .Targaryen: return "Targaryen"
        case .Baratheon: return "Baratheon"
        case .Arryn: return "Arryn"
        case .Tully: return "Tully"
        }
    }    
}


// MARK: - House
final class House {
    let name: String
    let sigil: Sigil
    let words: Words
    let wikiURL: URL
    private var _members: Members
    
    init(name: String, sigil: Sigil, words: Words, url: URL) {
        self.name = name
        self.sigil = sigil
        self.words = words
        self.wikiURL = url
        _members = Members()
    }
}

extension House {
    var count: Int {
        return _members.count
    }
    
    var sortedMembers: [Person] {
        return _members.sorted()
    }
    
    func add(person: Person) {
        guard person.house == self else {
            return
        }
        _members.insert(person)
    }
    
    func add(persons: Person...) {
        // Aqui, persons es de tipo [Person]

        persons.forEach{ add(person: $0) }
    }
}

// MARK: - Proxy
extension House {
    var proxyForEquality: String {
        return "\(name) \(words) \(count)"
    }
    
    var proxyForComparison: String {
        return name.uppercased() 
    }
}

// MARK: - Equatable
extension House: Equatable {
    static func ==(lhs: House, rhs: House) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

// MARK: - Hashable
extension House: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

// MARK: - Comparable
extension House: Comparable {
    static func <(lhs: House, rhs: House) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}

// MARK: - Sigil
final class Sigil {
    let description: String
    let image: UIImage
    
    init(image: UIImage, description: String) {
        self.image = image
        self.description = description
    }
}













