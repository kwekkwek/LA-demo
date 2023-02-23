//
//  FlightMonitoring.swift
//  FlightMonitoring
//
//  Created by benny.kurniawan on 22/02/23.
//

import ActivityKit
import SwiftUI
import WidgetKit

struct LiveActivitiesAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
         // Dynamic stateful properties about your activity go here!
        var flightStatus: FlightStatus
        var gate: String
        var bargageClaim: String
        var eta: String
    }

    // Fixed non-changing properties about your activity go here!
    var flightNumber: String
    var originAirport: AirportData
    var destinationAirport: AirportData
    var flightDuration: String
 }

 struct LiveActivitiesLiveActivity: Widget {
     var body: some WidgetConfiguration {
         ActivityConfiguration(for: LiveActivitiesAttributes.self) { context in
             LiveActivitiesView(data: context.attributes, content: context.state)
         } dynamicIsland: { context in
             DynamicIsland {
                 // Expanded UI goes here.  Compose the expanded UI through
                 // various regions, like leading/trailing/center/bottom
                 DynamicIslandExpandedRegion(.leading) {
                     Text("Leading")
                 }
                 DynamicIslandExpandedRegion(.trailing) {
                     Text("Trailing")
                 }
                 DynamicIslandExpandedRegion(.bottom) {
                     Text("Bottom")
                     // more content
                 }
             } compactLeading: {
                 Text("L")
             } compactTrailing: {
                 Text("T")
             } minimal: {
                 Text("Min")
             }
             .widgetURL(URL(string: "http://www.apple.com"))
             .keylineTint(Color.red)
         }
     }
 }

 struct LiveActivitiesLiveActivity_Previews: PreviewProvider {
     static let attributes = LiveActivitiesAttributes(
        flightNumber: "SQ963",
        originAirport: AirportData(country: "Indonesia", name: "CGK", time: "8.25 AM", terminal: "3", status: .onTime),
        destinationAirport: AirportData(country: "Singapore", name: "SIN", time: "11:10 AM", terminal: "3", status: .onTime), flightDuration: "1 Hour 20 Minutes"
     )
     static let contentState = LiveActivitiesAttributes.ContentState(
        flightStatus: .scheduled("1 Hours"),
        gate: "21",
        bargageClaim: "",
        eta: "20 Minutes"
     )

     static var previews: some View {
         attributes
             .previewContext(contentState, viewKind: .dynamicIsland(.compact))
             .previewDisplayName("Island Compact")
         attributes
             .previewContext(contentState, viewKind: .dynamicIsland(.expanded))
             .previewDisplayName("Island Expanded")
         attributes
             .previewContext(contentState, viewKind: .dynamicIsland(.minimal))
             .previewDisplayName("Minimal")
         attributes
             .previewContext(contentState, viewKind: .content)
             .previewDisplayName("Notification")
     }
 }
