//
//  Repository.swift
//  Westeros
//
//  Created by Adolfo Fernandez on 13/02/2018.
//  Copyright © 2018 Adolfo Fernandez. All rights reserved.
//

import UIKit


final class Repository {
    static let local = LocalFactory()
}

protocol HouseFactory {
    
    typealias Filter = (House) -> Bool
    
    var houses: [House] { get }
    func house(named: String) -> House?
    func house(named: Houses) -> House?
    func houses(filteredBy: Filter) -> [House]
}

protocol SeasonsFactory {
    
    typealias FilterSeasons = (Season) -> Bool
    
    var seasons: [Season] { get }
    func season(named: String) -> Season?
    func seasons(filteredBy: FilterSeasons) -> [Season]
}

final class LocalFactory: HouseFactory , SeasonsFactory{
    
    var houses: [House] {
        // Houses creation here
        let starkSigil = Sigil(image: UIImage(named: "codeIsComing.png")!, description: "Lobo Huargo")
        let lannisterSigil = Sigil(image: #imageLiteral(resourceName: "lannister.jpg"), description: "León rampante")
        let targaryenSigil = Sigil(image: UIImage(named: "targaryenSmall.jpg")!, description: "Dragón Tricéfalo")

        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")! )
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!)
        let targaryenHouse = House(name: "Targaryen", sigil: targaryenSigil, words: "Fuego y Sangre", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!)
        
        let robb = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse)
        let arya = Person(name: "Arya", house: starkHouse)
        
        let tyrion = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse)
        let cersei = Person(name: "Cersei", house: lannisterHouse)
        let jaime = Person(name: "Jaime", alias: "El Matarreyes", house: lannisterHouse)
        
        let dani = Person(name: "Daenerys", alias: "Madre de Dragones", house: targaryenHouse)
        
        // Add characters to houses
        starkHouse.add(person: arya)
        starkHouse.add(person: robb)
        lannisterHouse.add(person: tyrion)
        lannisterHouse.add(person: cersei)
        lannisterHouse.add(person: jaime)
        targaryenHouse.add(person: dani)
        
        return [starkHouse, lannisterHouse, targaryenHouse].sorted()
    }
    
    func house(named name: String) -> House? {
        let house = houses.filter{ $0.name.uppercased() == name.uppercased() }.first
        
        return house
    }
    
    //para filtrar haciendo uso del tipo enumerado que hemos creado Houses
    func house(named name: Houses) -> House? {
        let house = houses.filter{ $0.name.uppercased() == name.description.uppercased() }.first
        return house
    }
    
    func houses(filteredBy: Filter) -> [House] {
        return Repository.local.houses.filter(filteredBy)
    }
    
    
    var seasons: [Season] {
        // Season creation here
        
        let season1 = Season(name: "Temporada-1", releaseDate: Date(dateString: "01-04-2011"))
        let season2 = Season(name: "Temporada-2", releaseDate: Date(dateString: "01-04-2012"))
        let season3 = Season(name: "Temporada-3", releaseDate: Date(dateString: "01-03-2013"))
        let season4 = Season(name: "Temporada-4", releaseDate: Date(dateString: "01-04-2014"))
        let season5 = Season(name: "Temporada-5", releaseDate: Date(dateString: "01-04-2015"))
        let season6 = Season(name: "Temporada-6", releaseDate: Date(dateString: "01-04-2016"))
        let season7 = Season(name: "Temporada-7", releaseDate: Date(dateString: "01-07-2017"))

        let epS01E01 = Episode(name: "1. Winter is coming" , launchDate: Date(dateString:"17-04-2011"), season: season1)
        let epS01E02 = Episode(name: "2. The Kingsroad" , launchDate: Date(dateString:"24-04-2011"), season:season1)
        
        season1.add(episodes: epS01E01,epS01E02)
        

        let epS02E01 = Episode(name: "1. The North remembers" , launchDate: Date(dateString:"01-04-2012"), season: season2)
        let epS02E02 = Episode(name: "2. The night lands" , launchDate: Date(dateString:"08-04-2012"), season:season2)
        
        season2.add(episodes: epS02E01,epS02E02)
        
        let epS03E01 = Episode(name: "1. Valar Dohaeris" , launchDate: Date(dateString:"31-03-2013"), season: season3)
        let epS03E02 = Episode(name: "2. Dark wings, dark words" , launchDate: Date(dateString:"07-04-2013"), season:season3)
        
        season3.add(episodes: epS03E01,epS03E02)
        
        let epS04E01 = Episode(name: "1. Two swords" , launchDate: Date(dateString:"06-04-2014"), season: season4)
        let epS04E02 = Episode(name: "2. The Lion and the Rose" , launchDate: Date(dateString:"13-04-2014"), season:season4)
        
        season4.add(episodes: epS04E01,epS04E02)
        
        let epS05E01 = Episode(name: "1. The wars to come" , launchDate: Date(dateString:"12-04-2015"), season: season5)
        let epS05E02 = Episode(name: "2. The House of Black and White" , launchDate: Date(dateString:"19-04-2015"), season:season5)
        
        season5.add(episodes: epS05E01,epS05E02)
        
        let epS06E01 = Episode(name: "1. The Red Woman" , launchDate: Date(dateString:"24-04-2016"), season: season6)
        let epS06E02 = Episode(name: "2. Home" , launchDate: Date(dateString:"01-05-2016"), season:season6)
        
        season6.add(episodes: epS06E01,epS06E02)
        
        let epS07E01 = Episode(name: "1. Rocadragón" , launchDate: Date(dateString:"16-07-2017"), season: season7)
        let epS07E02 = Episode(name: "2. Stormborn" , launchDate: Date(dateString:"23-07-2017"), season:season7)
        
        season7.add(episodes: epS07E01,epS07E02)
        
        return [season1, season2, season3,season4,season5,season6,season7].sorted()
    }
    
    func seasons(filteredBy: FilterSeasons) -> [Season] {
        return Repository.local.seasons.filter(filteredBy)
    }
    
    
    func season(named name: String) -> Season? {
        let season = seasons.filter{ $0.name.uppercased() == name.uppercased() }.first
        return season
    }

}








