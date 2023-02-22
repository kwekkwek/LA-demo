//
//  FlightModel.swift
//  Demo_live_activities
//
//  Created by benny.kurniawan on 20/02/23.
//

import Foundation

struct FlightData: Codable, Identifiable, Equatable {
    let id = UUID()
    let airlinesName: String
    let flightNumber: String
    let status: FlightStatus
    let airportOriginName: AirportData
    let airportDestination: AirportData
    let duration: String
}

struct AirportData: Codable, Equatable {
    let country: String
    let name: String
    let time: String
    let terminal: String
    let status: FlightTimeStatus
}

enum FlightStatus: Codable, Hashable, Equatable {
    case takeOff
    case inAir
    case landed
    case arrived
    case scheduled(String)
    case canceled
}

enum FlightTimeStatus: Codable, Hashable, Equatable {
    case onTime
    case delay(String)
}

extension FlightStatus {
    var wording: String {
        switch self {
        case .takeOff:
            return "Now Departing"
        case .inAir:
            return "Landing in"
        case .landed, .arrived:
            return "Claim baggage"
        case let .scheduled(time):
            return "Gate departure In \(time)"
        case .canceled:
            return "Flight canceled"
        }
    }
}
