//
//  HomeView.swift
//  DesignCode
//
//  Created by Will Hustle on 4/17/20.
//  Copyright © 2020 Will Hustle. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var showProfile : Bool
    
    var body: some View {
        
        VStack {
            
            HStack {
                Text("Watching")
                    .font(.system(size: 28, weight: .bold))
                Spacer()
                
                AvatarView(showProfile: $showProfile)
            }
            .padding(.horizontal)
            .padding(.leading, 14) //set text to scrollview width/start.
            .padding(.top, 30)
            
            //SCROLL VIEW
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    ForEach(sectionData) { item in
                        SectionView(section: item)
                    }
                }
                .padding(30)
                    .padding(.bottom, 30) //add extra padding so ScrollView doesn't clip drop shadow.
            }
            
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false))
    }
}

struct SectionView: View {
    
    var section : Section
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(section.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(Color.white)
                Spacer()
                Image(section.logo)
            }
            
            Text(section.text.uppercased())
                .frame(maxWidth: .infinity)
            
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: 275, height: 275)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}

//data model

struct Section : Identifiable {
    var id = UUID()
    var title : String
    var text : String
    var logo : String
    var image : Image //image
    var color : Color //color name or literal
}


//create an object array to hold all of the card data
let sectionData = [
    Section(
        title: "A Chicken",
        text: "Rules the roost",
        logo: "Logo1",
        image: Image("Card1"),
        color: Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
        
    ),
    
    Section(
        title: "A Lion",
        text: "King of the Jungle",
        logo: "Logo2",
        image: Image("Card2"),
        color: Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        
    ),
    
    Section(
        title: "An Eagle",
        text: "Most Majestic Bird",
        logo: "Logo3",
        image: Image("Card3"),
        color: Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
        
    )
    
]

//to use color literal you must create the color literal outside of the array and paste in (Xcode bug)

