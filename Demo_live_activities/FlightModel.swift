//
//  FlightModel.swift
//  Demo_live_activities
//
//  Created by benny.kurniawan on 20/02/23.
//

import Foundation

struct FlightData: Identifiable {
    let id = UUID()
    let airlinesName: String
    let flightNumber: String
    let status: FlightStatus
    let airportOriginName: AirportData
    let airportDestination: AirportData
    let duration: String
}

struct AirportData {
    let country: String
    let name: String
    let time: String
    let terminal: String
}

enum FlightStatus: Equatable {
    case takeOff
    case inAir
    case landed
    case arrived
    case scheduled(String)
    case canceled
}
