//
//  ContentView.swift
//  NeumorphismBarChart
//
//  Created by まえけん on 2021/03/31.
//  Copyright © 2021 maeken. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            Spacer()
            BarChartView()
            Spacer()
            BarChartView()
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct BarChartView: View {
    var ave: Double = 3
    var dataArray: [Double] = [10,5,1,-5,-10]
    var title: String = "気分"
    var dateTitleArray: [String] = ["10","5","1","-5","-10"]
    var colors = [Color.init(.gray),Color.init(.gray)]
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 8) {
                HStack(alignment: .bottom) {
                    Text(self.title)
                        .bold()
                    .font(.footnote)
                    Spacer()
                    Text("平均")
                        .font(.footnote)
                    Text(String(format: "%.1f", self.ave))
                        .bold()
//                        .font(.title)
                }
                VStack {
                    HStack(spacing: 1) {
                        ForEach(0..<self.dataArray.count, id: \.self) { data in
                            VStack {
                                Text(self.dateTitleArray[data])
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .padding(.bottom,10)
                                Text(String(format: "%.1f", self.dataArray[data]))
                                    .foregroundColor(.gray)
                                    .padding(.bottom,5)
                                    .font(.footnote)
                                VStack {
                                    Spacer()
                                    
                                    Rectangle()
                                        .fill(LinearGradient(gradient: .init(colors: [.gray,.gray]),
                                                             startPoint: .top,
                                                             endPoint: .bottom))
                                        .frame(height: self.getHeight(value: self.dataArray[data]))
                                        .cornerRadius(5)
                                }
                                Spacer()
                            }
                            .frame(height: geometry.size.height / 1.7)
                        }
                    }
                    Spacer()
                }
                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.8)
            }
            .background(Color.offWhite)
            .cornerRadius(10)
            .modifier(NeumorphismStyle(height: geometry.size.height, ratio: 1))
        }
        .frame(width: UIScreen.main.bounds.width * 0.48, height: UIScreen.main.bounds.width * 0.48)
    }
    func getHeight(value: Double) -> CGFloat {
        let hrs = value * 4
        
        return CGFloat(hrs)
    }
}

struct NeumorphismStyle: ViewModifier {
    
    var height: CGFloat
    var ratio: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding(10)
            .background(
                GeometryReader(){ geometry in
                    RoundedRectangle(cornerRadius: 30,
                                     style: .continuous)
                        .fill(Color.offWhite)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                        .shadow(color: Color.white.opacity(0.5), radius: 10, x: -5, y: -5)
                        .frame(width:geometry.size.width * self.ratio,
                               height: self.height)
                }
        )
    }
}
extension Color {
    static let offWhite = Color(red: 245 / 255, green: 245 / 255, blue: 255 / 255)
}
