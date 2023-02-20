//
//  ContentView.swift
//  Demo_live_activities
//
//  Created by benny.kurniawan on 20/02/23.
//

import SwiftUI

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
            status: .arrived,
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
                        print("start widget")
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
}

struct FlightStatusIcon: View {
    var body: some View {
        VStack {
            Image(systemName: "airplane")
                .resizable()
                .renderingMode(.template)
                .frame(width: 15, height: 15)
        }
        .padding()
        .background(.gray)
        .clipShape(Circle())
    }
}

struct OriginIcon: View {
    var body: some View {
        Image(systemName: "arrow.up.forward.circle.fill")
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundColor(Color.baseGreen)
    }
}

struct DestinationIcon: View {
    var body: some View {
        Image(systemName: "arrow.down.right.circle.fill")
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundColor(Color.baseGreen)
    }
}

struct AirportView: View {
    let time: String
    let originName: String
    let isUsingOrigin: Bool
    var body: some View {
        HStack(spacing: 4) {
            if isUsingOrigin {
                OriginIcon()
            } else {
                DestinationIcon()
            }
            Text(originName)
                .font(.body)
                .foregroundColor(.gray)
                .bold()
            Text(time)
                .font(.body)
                .foregroundColor(.baseGreen)
                .bold()
        }
    }
}

struct FlightScheduleView: View {
    let flightData: FlightData
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 16) {
                FlightStatusIcon()
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
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
                        AirportView(time: "\(flightData.airportOriginName.time)", originName: "\(flightData.airportOriginName.name)", isUsingOrigin: true)
                        
                        AirportView(time: "\(flightData.airportDestination.time)", originName: "\(flightData.airportDestination.name)", isUsingOrigin: false)
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