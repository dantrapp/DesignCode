//
//  UpdateList.swift
//  DesignCode
//
//  Created by Will Hustle on 4/18/20.
//  Copyright © 2020 Will Hustle. All rights reserved.
//

import SwiftUI

struct UpdateList: View {
    @ObservedObject var store = UpdateStore()
    
    //function to create and append new object to Update array.
    func addUpdate(){
        store.updates.append(Update(title: "Update Title", text: "Update Text", image: "Avatar", date: "April 20th"))
    }
    
    var body: some View {
        NavigationView {
            
            //use store data
            List {
                ForEach(store.updates) { update in
                    NavigationLink(destination: UpdateDetail(update: update)) {
                        HStack {
                            Image(update.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                                .background(Color.black)
                                .cornerRadius(20)
                                .padding(.trailing, 4)
                                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                            
                            
                            
                            VStack(alignment: .leading, spacing: 8.0) {
                                Text(update.title)
                                    .font(.system(size: 20, weight: .bold))
                                Text(update.text)
                                    .lineLimit(2)
                                    .font(.subheadline)
                                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                
                                Text(update.date)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.secondary)
                                
                                
                            }
                            
                            
                        }
                        .padding(.vertical, 8)
                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                        
                    }
                }
                .onDelete{ index in
                    self.store.updates.remove(at: index.first!)
                }
                
                .onMove{ (source:IndexSet, destination:Int ) in
                    self.store.updates.move(fromOffsets: source, toOffset: destination)
                    
                }
            }
            .navigationBarTitle("SwiftUI Is Fun!")
                
            //add Add Update and Edit buttons.
            .navigationBarItems(leading: Button(action: addUpdate) {
                Text("Add Update")
            }, trailing: EditButton())

        }
    }
}

struct UpdateList_Previews: PreviewProvider {
    static var previews: some View {
        UpdateList()
    }
}

struct Update : Identifiable{
    var id = UUID()
    var title : String
    var text : String
    var image : String
    var date : String
}

let updateData = [
    
    Update(title: "SwiftUI", text: "This is one and I want to put some extra text here to take up some space.", image: "Card1", date: "April 18th"),
    
    Update(title: "2nd App", text: "This is two for the same reasons, more text. Always more text.", image: "Card2", date: "April 18th"),
    
    Update(title: "3rd App", text: "This is three. 3X the text and 10x the resuls! Order now!", image: "Card3", date: "April 18th"),
    
    Update(title: "4th App", text: "This is four. Four is amazing. It comes after 1, 2, 3.", image: "Card4", date: "April 18th"),
    
    Update(title: "5th App", text: "This is five, and five is where we end this list.", image: "Card5", date: "April 18th")
    
]
