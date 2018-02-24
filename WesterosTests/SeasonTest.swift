//
//  SeasonTest.swift
//  WesterosTests
//
//  Created by Adolfo Fernandez on 24/2/18.
//  Copyright © 2018 Alexandre Freire. All rights reserved.
//

import XCTest
@testable import Westeros

class SeasonTest: XCTestCase {
    
    
    var season1 : Season!
    var season2 : Season!
    
    var epS01E01 : Episode!
    var epS01E02 : Episode!
    
    var epS02E01 : Episode!
    
    
    override func setUp() {
        super.setUp()
        
        season1 = Season(name: "Temporada-1", releaseDate: Date(dateString: "01-04-2011"))
        season2 = Season(name: "Temporada-2", releaseDate: Date(dateString: "01-04-2012"))
        
        epS01E01 = Episode(name: "1.Se acerca el invierno" , launchDate: Date(dateString:"17-04-2011"), season: season1)
        epS01E02 = Episode(name: "2.Camino Real" , launchDate: Date(dateString:"24-04-2011"), season:season1)
        
        epS02E01 = Episode(name: "1.El Norte no olvida" , launchDate: Date(dateString:"1-04-2012"), season:season2)
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
   
    func testSeasonExistence() {
        XCTAssertNotNil(season1)
        XCTAssertNotNil(season2)
        
    }

    func testAddEpisodes() {
        XCTAssertEqual(season1.count, 0)
        
        //probamso a introducir un episodio nuevo en una temporada
        season1.add(episode: epS01E01)
        XCTAssertEqual(season1.count, 1)
        
        //probamos a meter el mismo episodio en la misma temporada, no debe haber repetidos
        season1.add(episode: epS01E01)
        XCTAssertEqual(season1.count, 1)
        
        //probamso a introducir un nuevo episodio distinto en una temporada que ya tiene episodios
        season1.add(episode: epS01E02)
        XCTAssertEqual(season1.count, 2)
        
        //probamos a introducir episodio en un temrporada que no le corresponde, no debe permitirlo
        season1.add(episode: epS02E01)
        XCTAssertEqual(season1.count, 2)
        
        let epS0103=Episode(name: "3.Lord Nieve" , launchDate: Date(dateString:"01-05-2011"), season: season1)
        let epS0104=Episode(name: "4.Tullidos, bastardos y cosas rotas" , launchDate: Date(dateString:"08-05-2011"), season: season1)
        
        //probamos que podemos introducir varios episisodios de un golpe, no debe permitir repetidos ni episisodos de temporadas que no le corresponden
        
        season1.add(episodes: epS01E01, epS01E02, epS01E02, epS0103, epS0104, epS02E01, epS02E01)
        XCTAssertEqual(season1.count, 4)
        
    }
    
    
    func testSeasonEquality() {
        // Identidad
        XCTAssertEqual(season1, season1)
        
        // Igualdad
        let season1fork = Season(name: "Temporada-1", releaseDate: Date(dateString: "01-04-2011"))
        XCTAssertEqual(season1, season1fork)
        
        // Desigualdad
        XCTAssertNotEqual(season1, season2)
    }
    
    func testSeasonHashable() {
        XCTAssertNotNil(season1.hashValue)
    }
    
    func testSeasonComparison() {
        XCTAssertLessThan(season1, season2)
    }
    
    func testSeasonCustomStringConvertible(){
        
        XCTAssertEqual(season1.description, season1.description)
        
        XCTAssertNotEqual(season1.description,season2.description)
    }
    
    
    func testSeasonReturnsSortedArrayOfEpisodes() {
        season1.add(episodes: epS01E01, epS01E02)
        
        XCTAssertEqual(season1.sortedEpisodes, [epS01E01, epS01E02])
    }
    
    
    
}
