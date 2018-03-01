//
//  EpisodeTests.swift
//  WesterosTests
//
//  Created by Adolfo Fernandez on 24/2/18.
//  Copyright © 2018 Adolfo Fernandez. All rights reserved.
//

import XCTest
@testable import Westeros
class EpisodeTests: XCTestCase {
 
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
    
    func testEpisodeExistence() {
        XCTAssertNotNil(epS01E01)
        XCTAssertNotNil(epS01E02)
    }
    
   
    
    func testEpisodeEquality() {
        // Identidad
        XCTAssertEqual(epS01E01, epS01E01)
        
        // Igualdad
        let epS01E01clon = Episode(name: "1.Se acerca el invierno" , launchDate: Date(dateString:"17-04-2011"), season: season1)
        XCTAssertEqual(epS01E01, epS01E01clon)
        
        // Desigualdad
        XCTAssertNotEqual(epS01E01, epS01E02)
    }
    
    func testEpisodeHashable() {
        XCTAssertNotNil(epS01E01.hashValue)
    }
    
    func testEpisodeComparison() {
        XCTAssertLessThan(epS01E01, epS01E02)
    }
    
    func testEpisodeCustomStringConvertible(){
        
        XCTAssertEqual(epS01E01.description,epS01E01.description)
        
        XCTAssertNotEqual(epS01E01.description,epS01E02.description)
    }
    

}
