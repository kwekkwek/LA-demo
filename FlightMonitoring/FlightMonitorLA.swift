//
//  FlightMonitorLA.swift
//  FlightMonitoringExtension
//
//  Created by benny.kurniawan on 22/02/23.
//

import ActivityKit
import WidgetKit

class FlightMonitorLA {
    static let shared = FlightMonitorLA()
    
    init() { }
    
    func startLA(data: FlightData) {
        let activityInfo = ActivityAuthorizationInfo()
        guard activityInfo.areActivitiesEnabled else { return }
        let attr = LiveActivitiesAttributes(
            flightNumber: data.flightNumber,
            originAirport: data.airportOrigin,
            destinationAirport: data.airportDestination,
            flightDuration: data.duration
        )
        let initialData = LiveActivitiesAttributes.ContentState(
            flightStatus: data.status, gate: "", bargageClaim: "", eta: "50 minutes")

        do {
            let _ = try Activity<LiveActivitiesAttributes>.request(
                attributes: attr,
                content: ActivityContent<LiveActivitiesAttributes.ContentState>(state: initialData, staleDate: .distantFuture)
            )
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func update(flightNumber: String) async {
        if let currentActivity = Activity<LiveActivitiesAttributes>.activities.first(where: {
            $0.attributes.flightNumber == flightNumber
        }) {
            
            let newStatus = LiveActivitiesAttributes.ContentState(
                flightStatus: .landed, gate: "", bargageClaim: "12", eta: "On Time"
            )

            let newData = ActivityContent(state: newStatus, staleDate: nil)
            await currentActivity.update(newData)
        }
    }
    
    func remove(flightNumber: String) async {
        if let currentActivity = Activity<LiveActivitiesAttributes>.activities.first(where: {
            $0.attributes.flightNumber == flightNumber
        }) {
            await currentActivity.end(nil, dismissalPolicy: .immediate)
        }
    }
}
