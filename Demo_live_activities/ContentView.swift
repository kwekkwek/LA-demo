//
//  ContentView.swift
//  Demo_live_activities
//
//  Created by benny.kurniawan on 20/02/23.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    private let flightDatas: [FlightData] = [
        FlightData(
            airlinesName: "Garuda Indonesia",
            flightNumber: "GA 448",
            status: .scheduled("2 Hours"),
            airportOriginName: AirportData(country: "Jakarta", name: "CGK", time: "7:30 AM", terminal: "3"),
            airportDestination: AirportData(country: "Surabaya", name: "SUB", time: "9:40 AM", terminal: "1"),
            duration: "1h 40m"
        ),
        FlightData(
            airlinesName: "Air Asia",
            flightNumber: "QZ 266",
            status: .takeOff,
            airportOriginName: AirportData(country: "Indonesia", name: "CGK", time: "8:30 AM", terminal: "2"),
            airportDestination: AirportData(country: "Singapore", name: "SIN", time: "11:20 AM", terminal: "1"),
            duration: "1h 53m"
        ),
        FlightData(
            airlinesName: "Citilink",
            flightNumber: "QC 682",
            status: .inAir,
            airportOriginName: AirportData(country: "Jakarta", name: "CGK", time: "9:00 AM", terminal: "2D"),
            airportDestination: AirportData(country: "Bali", name: "DPS", time: "11:50 AM", terminal: "1"),
            duration: "1h 50m"
        )
        
    ]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(flightDatas, id: \.id) { data in
                    FlightScheduleView(flightData: data)
                        .background(Color.baseBlack)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.baseBlack)
                }
                .navigationTitle("Menu")
                .swipeActions {
                    Button {
                        print("update widget")
                    } label: {
                        Label( "", systemImage: "slowmo")
                    }
                    .tint(.indigo)
                    Button {
//                        print("start widget")
                        self.startWidget()
                    } label: {
                        Label("", systemImage: "play.fill")
                    }
                    .tint(.red)
                }
            }
            .listStyle(.plain)
            .listItemTint(.baseBlack)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.baseBlack)
        }
    }
    
    init() {
           UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
       }
    
    func startWidget() {
//        let activityInfo = ActivityAuthorizationInfo()
//        guard activityInfo.areActivitiesEnabled else { return }
//        let attr = LiveActivitiesAttributes(name: "ABC")
//        let initialData = LiveActivitiesAttributes.ContentState(value: 100)
//        
//        do {
//            try Activity<LiveActivitiesAttributes>.request(
//                attributes: attr,
//                content: ActivityContent<LiveActivitiesAttributes.ContentState>(state: initialData, staleDate: .distantFuture)
//            )
//        } catch {
//            print(error.localizedDescription)
//        }
    }
    
    func updateWidget() {
        // disini update ContentState = new value
    }
    
    func removeWidget() {
        // remove the widget do there
    }
}

struct FlightStatusIcon: View {
    let status: FlightStatus
    var body: some View {
        VStack {
            switch status {
            case .takeOff:
                Image(systemName: "airplane.departure")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 15, height: 15)
                    .padding()
                    .background(.gray)
                    .clipShape(Circle())
            case .inAir:
                VStack {
//                    AirplaneAnimationView()
                    Text("In Air")
                        .font(.body)
                        .bold()
                        .foregroundColor(.baseGreen)
                }
            case .landed:
                Image(systemName: "airplane.arrival")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 15, height: 15)
                    .padding()
                    .background(.gray)
                    .clipShape(Circle())
            case .arrived:
                Image(systemName: "checkmark")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 15, height: 15)
                    .padding()
                    .background(Color.baseGreen)
                    .clipShape(Circle())
            case .scheduled(let string):
                ScheduledFlight(text: string)
            case .canceled:
                Image(systemName: "xmark")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 15, height: 15)
                    .padding()
                    .background(Color.red)
                    .clipShape(Circle())
            }
        }
    }
}

struct ScheduledFlight: View {
    let text: String
    var body: some View {
        VStack {
            Image(systemName: "clock.fill")
                .resizable()
                .renderingMode(.template)
                .frame(width: 20, height: 20)
                .foregroundColor(.green)
            Text(text)
                .font(.body)
                .foregroundColor(.baseGreen)
                .bold()
        }
    }
}

struct OriginIcon: View {
    var body: some View {
        Image(systemName: "arrow.up.forward.circle.fill")
            .resizable()
            .frame(width: 20, height: 20)
    }
}

struct DestinationIcon: View {
    var body: some View {
        Image(systemName: "arrow.down.right.circle.fill")
            .resizable()
            .frame(width: 20, height: 20)
    }
}

struct AirlinesIcon: View {
    let iconName: String
    var body: some View {
        Image(uiImage: UIImage(named: "garuda")!)
            .resizable()
            .frame(width: 20, height: 20)
    }
}

struct AirportView: View {
    let time: String
    let originName: String
    let isUsingOrigin: Bool
    let flightStatus: FlightStatus
    var body: some View {
        HStack(spacing: 4) {
            if isUsingOrigin {
                OriginIcon()
                    .foregroundColor(flightStatus == .canceled ? .red : .baseGreen)
            } else {
                DestinationIcon()
                    .foregroundColor(flightStatus == .canceled ? .red : .baseGreen)
            }
            Text(originName)
                .font(.body)
                .foregroundColor(.gray)
                .bold()
            Text(time)
                .font(.body)
                .foregroundColor(flightStatus == .canceled ? .red : .baseGreen)
                .bold()
        }
    }
}

struct FlightScheduleView: View {
    let flightData: FlightData
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 16) {
                FlightStatusIcon(status: flightData.status)
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
//                        AirlinesIcon(iconName: "citilink")
                        Text(flightData.flightNumber)
                            .font(.title3)
                            .foregroundColor(.white)
                        Spacer()
                        Text("Duration \(flightData.duration)")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                    Text("\(flightData.airportOriginName.country) to \(flightData.airportDestination.country)")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                    HStack(spacing: 16) {
                        AirportView(time: "\(flightData.airportOriginName.time)", originName: "\(flightData.airportOriginName.name)", isUsingOrigin: true, flightStatus: flightData.status)
                        
                        AirportView(time: "\(flightData.airportDestination.time)", originName: "\(flightData.airportDestination.name)", isUsingOrigin: false, flightStatus: flightData.status)
                    }
                }
            }
            Divider()
                .frame(height: 1)
                .background(Color.gray)
                .padding(.top)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
