//
//  Home.swift
//  DesignCode
//
//  Created by Will Hustle on 4/16/20.
//  Copyright © 2020 Will Hustle. All rights reserved.
//

import SwiftUI

struct Home: View {
    
    @State var showProfile = false
    @State var viewState = CGSize.zero //State drag values
    
    var body: some View {
        ZStack {
            //set root background color (this is the base color that can be seen when adding transparency to other stacks.
            Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                HStack {
                    Text("Watching")
                        .font(.system(size: 28, weight: .bold))
                Spacer()
                    Button(action: {self.showProfile.toggle()}) {
                    Image("model")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
                .padding(.top, 30)

                Spacer()
            }
                //set view background color and manually add padding since you're ignoring safe areas!
                .padding(.top, 44)//!44 is size of status bar! Always use this!
                .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                
                .shadow(color: Color.black, radius: 20, x: 0, y: 20) //orignal drop shadow y:20, modified to use viewState.height drag values just for fun
                
                .scaleEffect(showProfile ? 0.9 : 1) //90% scale to background
                
                
                
                /*
                 
                 These 2 modifiers added last. The offset changes the view completely and makes it unusable to reset to default. We will likely fix that in the next video section.
                 */
                 
                .offset(y: showProfile ? -450: 0)
                
                //interesting. We took the drag values in viewState.height and added them as a Double to 3D Effect, then divided by 10 and now the profile card slides/drops in with an effect on drag.
                
                .rotation3DEffect(Angle(degrees: showProfile ?
                    Double(viewState.height / 10)-10: 0), axis: (x: 10.0, y: 0, z: 0))
            
                
                .animation(.spring(response: 0.5 /*transition quickness in seconds*/
                    , dampingFraction: 0.6 /*bounce*/
                    , blendDuration: 0)
            )
                .edgesIgnoringSafeArea(.all)
                
            //toggle the menu view into the screen on button press
            MenuView()
                .background(Color.black.opacity(0.001))
                .offset(y: showProfile ? 0 : 1000) //push to 1k because 600 showed black background.
                
                //drag offset
                .offset(y: viewState.height)
                
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture {
                    self.showProfile.toggle() //toggle profile on tap, expands profile view.
                    
            }
            
        //drag gesture
            .gesture(
                DragGesture().onChanged { value in
                    self.viewState = value.translation
                }
                .onEnded{ value in
                    if self.viewState.height > 50 {
                        self.showProfile = false
                    }
                    self.viewState = .zero
                    }
    
            )
            
        }
        
    }
}

struct home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
