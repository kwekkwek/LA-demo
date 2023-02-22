//
//  LiveActivitiesView.swift
//  LiveActivitiesExtension
//
//  Created by benny.kurniawan on 20/02/23.
//

import SwiftUI

struct LiveActivitiesView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("SQ963")
                .font(.title3)
                .bold()
                .foregroundColor(.baseBlack)
            
            HStack {
                AirportViewLA(airportName: "CGK", time: "6.00 AM")
                Spacer()
                AirplaneAnimationView()
                Spacer()
                AirportViewLA(airportName: "SIN", time: "10.20 AM")
            }
            HStack {
                OriginIconLA()
                Spacer()
                DestinationIconLA()
            }
            Divider()
            HStack {
                Text("Gate departure in 51 minutes")
                    .foregroundColor(.gray)
                Spacer()
                AirportTerminalView()
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
    var body: some View {
        HStack {
            Image(systemName: "arrow.up.forward.circle.fill")
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundColor(Color.gray)
            Text("T2 • ")
                .font(.footnote)
                .foregroundColor(.gray) + Text("Delay 20m")
                .font(.footnote)
                .foregroundColor(.red)
                .bold()
            
        }
    }
}

struct DestinationIconLA: View {
    var body: some View {
        Image(systemName: "arrow.down.right.circle.fill")
            .resizable()
            .frame(width: 16, height: 16)
            .foregroundColor(Color.gray)
        Text("T1 • ")
            .font(.footnote)
            .foregroundColor(.gray) +
        Text("OnTime")
            .font(.footnote)
            .foregroundColor(.baseGreen)
            .bold()
    }
}

struct LiveActivitiesLiveActivity_Previews_: PreviewProvider {
    static let attributes = LiveActivitiesAttributes(name: "Me")
    static let contentState = LiveActivitiesAttributes.ContentState(value: 3)

    static var previews: some View {
        attributes
            .previewContext(contentState, viewKind: .content)
            .previewDisplayName("Notification")
    }
}
