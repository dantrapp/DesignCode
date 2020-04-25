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
    @State var showContent = false
    @State var viewState = CGSize.zero //State drag values
    
    var body: some View {
        
        ZStack {
            //set root background color (this is the base color that can be seen when adding transparency to other stacks.
            Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            HomeView(showProfile: $showProfile, showContent: $showContent)
                .padding(.top, 44)
//                .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                
                //Set Gradient Background
                 .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.black, radius: 100, x: 0, y: 20) //orignal drop shadow y:20, I like 100 for radius.
                
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
            
            if showContent {
                Color.white.edgesIgnoringSafeArea(.all)
                ContentView()
                
                //CLOSE BUTTON (X)
                VStack {
                    HStack {
                        Spacer()
                        
                        Image(systemName: "xmark")
                            .frame(width: 36, height: 36)
                            .foregroundColor(Color.white)
                            .background(Color.black)
                            .clipShape(Circle())
                    }
                    Spacer()
                    
                }
                .offset(x:-15, y: 15)
                //with if statements (conditionals) traditional animation modifiers don't work alone, so we need to use the transition modifier as well.
                    .transition(.move(edge: .top))
                    .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
                .onTapGesture {
                    self.showContent = false
                }
            }
        }
        
    
    }
}

struct home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct AvatarView: View {
    
    @Binding var showProfile : Bool
    
    var body: some View {
        Button(action: {self.showProfile.toggle()}) {
            Image("model")
                .renderingMode(.original)
                .resizable()
                .frame(width: 30, height: 30)
                .clipShape(Circle())
        }
    }
}

//detect screen size
let screen = UIScreen.main.bounds
