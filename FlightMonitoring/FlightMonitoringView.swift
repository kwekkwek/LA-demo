//
//  FlightMonitoringView.swift
//  Demo_live_activities
//
//  Created by benny.kurniawan on 22/02/23.
//

import SwiftUI

struct LiveActivitiesView: View {
    let data: LiveActivitiesAttributes
    let content: LiveActivitiesAttributes.ContentState
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(data.flightNumber)
                .font(.title3)
                .bold()
                .foregroundColor(.baseBlack)
            
            HStack {
                AirportViewLA(airportName: data.originAirport.name, time: data.originAirport.time)
                Spacer()
                AirplaneAnimationView()
                Spacer()
                AirportViewLA(airportName: data.destinationAirport.name, time: data.destinationAirport.time)
            }
            HStack {
                OriginIconLA(terminalNumber: data.originAirport.terminal, scheduleTime: data.originAirport.status)
                Spacer()
                DestinationIconLA(terminalNumber: data.destinationAirport.terminal, scheduleTime: data.destinationAirport.status)
            }
            Divider()
            HStack {
                switch content.flightStatus {
                case .arrived, .landed:
                    Text(content.flightStatus.wording)
                        .foregroundColor(.gray)
                    Spacer()
                    BaggageView(baggageBeltNumber: content.bargageClaim)
                case .scheduled:
                    Text(content.flightStatus.wording)
                        .foregroundColor(.gray)
                    Spacer()
                    AirportTerminalView()
                case .inAir:
                    Text(content.flightStatus.wording)
                        .foregroundColor(.gray) + Text(" \(content.eta)").foregroundColor(.baseGreen).bold()
                case .canceled:
                    Text(content.flightStatus.wording)
                        .foregroundColor(.gray)
                case .takeOff:
                    Text("\(content.flightStatus.wording) from Gate \(content.gate)")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

struct AirportViewLA: View {
    let airportName: String
    let time: String
    
    var body: some View {
        HStack(spacing: 4) {
            Text(airportName)
                .foregroundColor(.baseBlack)
                .bold()
            Text(time)
                .bold()
                .foregroundColor(Color.baseGreen)
        }
    }
}

struct AirportTerminalView: View {
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "figure.walk")
                .renderingMode(.template)
                .foregroundColor(.black)
            Text("21")
                .foregroundColor(.baseBlack)
                .bold()
        }
        .padding(.all, 4)
        .background(.yellow)
        .cornerRadius(6)
    }
}

struct BaggageView: View {
    let baggageBeltNumber: String
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "bag.fill")
                .renderingMode(.template)
                .foregroundColor(.black)
            Text(baggageBeltNumber)
                .foregroundColor(.baseBlack)
                .bold()
        }
        .padding(.all, 4)
        .background(.yellow)
        .cornerRadius(6)
    }
}

struct AirplaneAnimationView: View {
    @State private var shouldAnimate = false
    
    var body: some View {
        HStack {
            Circle()
                .fill(Color.gray)
                .frame(width: 5, height: 5)
                .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever(), value: 0)
            Image(systemName: "airplane")
                .renderingMode(.template)
                .foregroundColor(Color.gray)
                .frame(width: 20, height: 20)
                .scaleEffect(shouldAnimate ? 1.0 : 0.8)
                .animation(Animation.easeInOut(duration: 1).repeatForever().delay(0.3), value: 1)
            Circle()
                .fill(Color.gray)
                .frame(width: 5, height: 5)
                .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.6), value: 0)
        }
        .onAppear {
            self.shouldAnimate = true
        }
    }
}

struct OriginIconLA: View {
    let terminalNumber: String
    let scheduleTime: FlightTimeStatus
    var body: some View {
        HStack {
            Image(systemName: "arrow.up.forward.circle.fill")
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundColor(Color.gray)
            HStack(spacing: 0) {
                Text("T\(terminalNumber) • ")
                    .font(.footnote)
                    .foregroundColor(.gray)
                switch scheduleTime {
                    case .onTime:
                        Text("On Time")
                            .font(.footnote)
                            .foregroundColor(.baseGreen)
                            .bold()
                    case .delay(let string):
                        Text(string)
                            .font(.footnote)
                            .foregroundColor(.red)
                            .bold()
                }
            }
        }
    }
}

struct DestinationIconLA: View {
    let terminalNumber: String
    let scheduleTime: FlightTimeStatus
    
    var body: some View {
        Image(systemName: "arrow.down.right.circle.fill")
            .resizable()
            .frame(width: 16, height: 16)
            .foregroundColor(Color.gray)
        HStack(spacing: 0){
            Text("T\(terminalNumber) • ")
                .font(.footnote)
                .foregroundColor(.gray)
            switch scheduleTime {
                case .onTime:
                    Text("On Time")
                        .font(.footnote)
                        .foregroundColor(.baseGreen)
                        .bold()
                case .delay(let string):
                    Text(string)
                        .font(.footnote)
                        .foregroundColor(.red)
                        .bold()
            }
        }
    }
}

struct LA_Previews: PreviewProvider {
    static let attributes = LiveActivitiesAttributes(
       flightNumber: "SQ963",
       originAirport:
        AirportData(
            country: "Indonesia",
            name: "CGK",
            time: "8.25 AM",
            terminal: "3",
            status: .onTime
       ),
       destinationAirport:
        AirportData(
            country: "Singapore",
            name: "SIN",
            time: "11:10 AM",
            terminal: "3",
            status: .onTime
        ),
       flightDuration: "1 hour 40 minutes"
    )
    
    static let contentState = LiveActivitiesAttributes.ContentState(
        flightStatus: .arrived,
       gate: "21",
       bargageClaim: "17",
       eta: "20 Minutes"
    )

    static var previews: some View {
        attributes
            .previewContext(contentState, viewKind: .content)
            .previewDisplayName("Notification")
    }
}
