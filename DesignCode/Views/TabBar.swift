//
//  TabBar.swift
//  DesignCode
//
//  Created by Will Hustle on 4/21/20.
//  Copyright © 2020 Will Hustle. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            Home().tabItem {
                Image(systemName: "play.circle.fill")
                Text("Home")
            }
            ContentView().tabItem {
                          Image(systemName: "rectangle.stack.fill")
                          Text("Certificates")
                      }
        }
        .edgesIgnoringSafeArea(.top)
        
    }
    
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TabBar().previewDevice("iPhone 11 Pro")
//             TabBar().previewDevice("iPhone 8")
//            TabBar().previewDevice("iPad Pro (12.9-inch)")
        }
    }
}
