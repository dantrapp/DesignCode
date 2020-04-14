//
//  MenuView.swift
//  DesignCode
//
//  Created by Will Hustle on 4/14/20.
//  Copyright © 2020 Will Hustle. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack { //create secondary VStack to...
            
            Spacer() //..push primary VStack to the bottom of the screen
            
            VStack(spacing: 16) {
                MenuRow(title: "Account", icon: "gear")
                MenuRow(title: "Billing", icon: "creditcard")
                MenuRow(title: "Sign Out", icon: "person.crop.circle")

            }
            .frame(maxWidth: .infinity) //take up entire screen width
            .frame(height: 300)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous)) //rounded rectangle
            .shadow(radius: 30) //pretty shadow
                .padding(.horizontal, 30)//move rectangle off sides
        }
            .padding(.bottom, 30)//move rectangle off bottom
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

struct MenuRow: View {

    var title : String //title as string
    var icon : String //icon as string
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: self.icon)
                .frame(width:32, height: 32)
                .font(.system(size: 20, weight: .light, design: .default))
                .imageScale(.large)
            Text(self.title)
                .font(.system(size: 20, weight: .bold, design: .default))
                .frame(width: 120, alignment: .leading)
        }
    }
}
