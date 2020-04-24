//
//  RingView.swift
//  DesignCode
//
//  Created by Will Hustle on 4/22/20.
//  Copyright © 2020 Will Hustle. All rights reserved.
//

import SwiftUI

struct RingView: View {
    
    var color1 = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
    var color2 = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
    var width : CGFloat = 300
    var height : CGFloat = 300
    var percent : CGFloat = 88
    
    //bind to use outside this view
    @Binding var showProgress : Bool
    
    var body: some View {
        
        //multiplier to rotate outercircle, must be in body because it relies on the width variable loading. Will now need to "return" the parent stack for this code to work.
        
           let multiplier = width / 44
        let progress = 1 - (percent / 100) //ex. turn to 0.88
        
        return ZStack {
            
            Circle()
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: 5))
                .frame(width: width, height: height)
            
 
            
            Circle()
                .trim(from: showProgress ? progress: 1, to: 1.0)
                .stroke(
                     LinearGradient(gradient: Gradient(colors: [Color(color1), Color(color2)]), startPoint: .topTrailing, endPoint: .bottomLeading),
                    style: StrokeStyle(lineWidth: 5 * multiplier, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0)
            )
            
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                .frame(width: width, height: height) //converted to CGFloat
                .shadow(color: Color(color2).opacity(0.1), radius: 3 * multiplier, x: 0, y: 3 * multiplier)
            
            //Gesture animation modifier for circle, comment this out or delete from parent before using it in child views or it will override!
            
//                .animation(.easeIn)
            
            
            Text("\(Int(percent))%") //turn CGFloat into Int
                    .font(.system(size: 14 * multiplier))
                    .fontWeight(.bold)
            
            //ontap Gesture for progress state
                .onTapGesture {
                    self.showProgress.toggle()
            }
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView(showProgress: (.constant(true)))
    }
}
