//
//  ContentView.swift
//  DesignCode
//
//  Created by Will Hustle on 4/12/20.
//  Copyright © 2020 Will Hustle. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    //animated state
    @State var show = false
    
    //Main Card: gesture state (for dragging)
    @State var viewState = CGSize.zero
    
    //Main Card: show card state (slide/animate card up)
    @State var showCard = false
    
    //Bottom Card: gesture state (for dragging)
    @State var bottomState = CGSize.zero
    
    //Show full card: state
    @State var showFull = false
    
    //    //drag value output
    //    @State var dragValue = CGSize.zero
    
    var body: some View {
        ZStack {
            
            //titleview
            TitleView()
                .blur(radius: show ? 20 : 0)
                .opacity(showCard ? 0.4 : 1) //on tap change title opacity
                .offset(y: showCard ? -200 : 0) //raise the title view on tap
                .animation(
                    Animation
                        .default
                        .delay(0.1)
            ) //adding extra modifiers with Animation value type
            
            
            
            
            //backcard w/40 offset
            BackCardView()
                .frame(width:  showCard ? 300 : 340.0, height: 220.0) //moved this back up
                .background(Color(show ? "card3" : "card4"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -400 : -40)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -180 : 0)
                .scaleEffect(showCard ? 1 : 0.9)
                .rotationEffect(Angle(degrees: show ? 0 : 10)) //tilted
                .rotationEffect(Angle(degrees: showCard ? -10 : 0)) //make it straight by cancelling out the "10" above that tilts it.
                .rotation3DEffect(Angle(degrees: showCard ? 0 : 5), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.5))
            
            
            
            
            
            //              Other rotationEffect options
            //             .rotationEffect(.degrees(12))
            //             .rotationEffect(Angle(radians: 12.0))
            
            //back card w/20 offset
            BackCardView()
                .frame(width: 340.0, height: 220.0) //moved this back up
                .background(Color(show ? "card4" : "card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -200 : -20) //animated
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -140 : 0)
                .scaleEffect(showCard ? 1 : 0.95) //adjust scale on tap
                .rotationEffect(Angle(degrees: show ? 0 : 5)) //animated
                .rotationEffect(Angle(degrees: showCard ? -5 : 0)) //make it straight by cancelling out the "5" above.
                .rotation3DEffect(Angle(degrees: showCard ? 0 : 5), axis: (x: 5.0, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.3))
            
            
            //main card
            CardView()
                .frame(width: showCard ? 375 : 340.0, height: 220.0) //on tap widen the card.
                .background(Color.black)
                //                .cornerRadius(20)
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 30 : 20, style: .continuous))//smooth corners by default & on tap
                .shadow(radius: 20)
                .offset(x: viewState.width, y: viewState.height) //dragging offset
                .offset(y: showCard ? -100 : 0)
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.0))
                .blendMode(.hardLight)
                
                //add the on tap gesture + toggle
                .onTapGesture {
                    //                    self.show.toggle()
                    self.showCard.toggle() //show full card view, gonna need a view to show though!
                    
            }
    
                
                
            .gesture(
                
            
                DragGesture().onChanged{ value in
                    self.viewState = value.translation //get coordinates
                    self.show = true //blur on drag
                    
                }
                .onEnded{ value in
                    self.viewState = .zero
                    self.show = false
                    
                }
                
            )
            
            //display the bottom state height value
            Text("Value: \(bottomState.height)")
                .offset(y:
                    -360)
            
            BottomCardView()
                .offset(x: 0, y: showCard ? 360 : 1000) //hide the card with 1,000px.
                .offset(y: bottomState.height) //dragging offset, y-only for height
                .blur(radius: show ? 20 : 0)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
                
                //initiate dragging gesture
                .gesture(
                    DragGesture().onChanged{ value in
                        self.bottomState = value.translation //get real-time coordinates
                        
                        //if showFull == true, bottomState == bottomState default + -323
                        if self.showFull{
                            self.bottomState.height += -323 //full height + -323
                        }
                        
                        //lets get rid of that ugly extra space when dragging the card up. We'll do that by settng a max height you can drag.
                        
                        if self.bottomState.height < -323{
                            self.bottomState.height = -323
                            
                        }
                        
                    }
                        
                        //when dragging has stopped..
                        .onEnded{ value in
                            //dismiss the card at 50 or above
                            if self.bottomState.height > 50 {
                                self.showCard = false
                                
                                
                            }
                            /*
                             pin the card to the top if -100 or less
                             group conditionals (shift + '(') so we can run an "or" conditional to reset the card to showCard default.
                             */
                            
                            if (self.bottomState.height < -100 && !self.showFull) || (self.bottomState.height < -263 && self.showFull) {
                                self.bottomState.height = -323
                                self.showFull = true
                                
                                
                                
                                //dismiss card if values above not met
                            } else {
                                self.bottomState = .zero
                                self.showFull = false
                            }
                            
                            
                            
                    }
                    
            )
            
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Black Card")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("Tap Me!")
                        .foregroundColor(Color("accent"))
                }
                Spacer()
                Image("Logo1")
            }
            .padding()
            Spacer()
            Image("Card1").resizable().aspectRatio(contentMode: .fill)
                .frame(width: 300.0, height: 110.0, alignment: .top)
        }
        
    }
}

struct BackCardView: View {
    var body: some View {
        VStack {
            Spacer()
        }
        
        //remove the offset to reuse this backcard as a standard template
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Tap The Card!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding()
            Image("Background1")
            Spacer()
        }
    }
}

struct BottomCardView: View {
    var body: some View {
        VStack(spacing: 20) {
            //add the pull tab
            Rectangle()
                .frame(width: 40.0, height: 5)
                .cornerRadius(3.0)
                .opacity(0.1) //shade the rectangle
            
            
            
            //add the text and modify it
            Text("This is card is only visible when you tap on the main card (black.) When you tap the black card it widens and the 2 cards in back reset tilt and raise up (as well as shrink in scale) and the background blurs. You can also drag the card. If you drag the card up it stops at -323. If you pull the card down past -263 it will reset to default visible state. If you drag the card above 50 you will swipe the card away completely.")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .lineSpacing(5)
            
            Spacer()
            
        }
            //add the card modifiers
            .padding(.top, 8)
            .padding(.horizontal, 20)
            //padding goes before background!
            
            //set max width for all devices
            .frame(maxWidth: .infinity)
            
            //other modifiers
            .background(Color.white)
            .cornerRadius(30)
            .shadow(radius:20)
    }
}
