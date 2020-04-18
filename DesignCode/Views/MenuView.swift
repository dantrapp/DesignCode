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
                
                //add text under profile avatar
                Text("Roksana - 88% Complete")
                    .font(.caption)
                
                //build the status bar, remember Color is a View!
                Color.white
                    
                    //first frame (slider bar)
                    .frame(width:30, height:6)
                    .cornerRadius(3)
                    
                    //second frame (slider background)
                    .frame(width: 130, height: 6, alignment: .leading)
                    .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.08))
                    .cornerRadius(3)
                    .padding()
                
                    //third frame
                    .frame(width: 150, height: 24)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(12)
                
                MenuRow(title: "Account", icon: "gear")
                MenuRow(title: "Billing", icon: "creditcard")
                MenuRow(title: "Sign Out", icon: "person.crop.circle")

            }
            .frame(maxWidth: .infinity) //take up entire screen width
            .frame(height: 300)
            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))]), startPoint: .top, endPoint: .bottom))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous)) //rounded rectangle
//            .shadow(radius: 30) //pretty shadow
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20) //drop shadow
                .padding(.horizontal, 30)//move rectangle off sides
        }
            .padding(.bottom, 30)//move rectangle off bottom
        .overlay(
            Image("model")
            .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
            .clipShape(Circle())
                .offset(y: 38)
        )
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
                .foregroundColor(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
            Text(self.title)
                .font(.system(size: 20, weight: .bold, design: .default))
                .frame(width: 120, alignment: .leading)
        }
    }
}
