//
//  CourseList.swift
//  DesignCode
//
//  Created by Will Hustle on 4/25/20.
//  Copyright © 2020 Will Hustle. All rights reserved.
//

import SwiftUI

struct CourseList: View {
    
    @State var show = false
    @State var show2 = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30.0) { //must make parent stack to extract a child stack to subview!
                CourseView(show: $show)
                GeometryReader { geometry in
                    
                    //add self inside GEO reader
                    CourseView(show: self.$show2)
                        
                        //offset to minY for bottom card
                        .offset(y:self.show2 ? -geometry.frame(in: .global).minY : 0)
                }
                .frame(height: show2 ? screen.height : 280)
                .frame(maxWidth: show2 ? .infinity : screen.width - 60)
            }
            .frame(width: screen.width)
        }
    }
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
    }
}

struct CourseView: View {
    
    @Binding var show : Bool
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 30.0) {
                Text("Rolex History")
                  .font(.title).bold()
                Text("About this course")
                    .font(.title).opacity(0.8)
                
                Text("Rolex SA (/ˈroʊlɛks/) is a Swiss luxury watch manufacturer based in Geneva, Switzerland.[3] Originally founded as Wilsdorf and Davis by Hans Wilsdorf and Alfred Davis in London, England in 1905, the company registered Rolex as the brand name of its watches in 1908 and became Rolex Watch Co. Ltd. in 1915.After World War I, the company moved its base of operations to Geneva, Switzerland in order to avoid heavy taxation from a recovering post-war Britain, and in 1920 Hans Wilsdorf registered Montres Rolex SA in Geneva as the new company name which eventually became Rolex SA in later years.")
                
                Text("Rolex mostly produced mechanical watches, but it has also participated in the development of the original quartz watch movements. Although Rolex has made very few quartz models for its Oyster line, the company's engineers were instrumental in design and implementation of the technology during the late 1960s and early 1970s. In 1968, Rolex collaborated with a consortium of 16 Swiss watch manufacturers to develop the Beta 21 quartz movement used in their Rolex Quartz Date 5100 alongside other manufactures including the Omega Electroquartz watches.[38] Within about five years of research, design, and development, Rolex created the 'clean-slate' 5035/5055 movement that would eventually power the Rolex Oysterquartz")
                
            }
            .padding(30)
                
            //get rid of the text unless button tapped
                .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? .infinity : 280, alignment: .top)
            
            //add offset to bring text down on tap
                .offset(y: show ? 460 : 0)
            
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text("SwiftUI Advanced")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        
                        Text("20 Sections")
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)).opacity(0.7))
                    }
                    Spacer()
                    ZStack {
                        //show icon if not fullscreen
                        Image(uiImage: #imageLiteral(resourceName: "Logo1"))
                            .opacity(show ? 0 : 1)
                        
                        //show close button if full screen
                        if show {
                        CloseButton()
                        }
                        
                    }
                  
                }
                Spacer()
                Image(uiImage: #imageLiteral(resourceName: "Card6"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140, alignment: .top)
                    
                  
            }
            .padding(show ? 30: 20)
            .padding(.top, show ? 30 : 0)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? 460 : 280) //show text by changing maxHeight .infinity to 460, otherwise card takes up full screen
            .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)).opacity(0.3), radius: 20, x: 0, y: 20)
            
                //moved animation to new parent container
                
            //tap card to animate to full screen with toggle
                          .onTapGesture {
                            self.show.toggle()
                      }
            //move safe area ignore to parent container
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .edgesIgnoringSafeArea(.all)
    }
}

struct CloseButton: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "xmark")
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
                    .background(Color.white)
                    .clipShape(Circle())
            }
            Spacer()
            
        }
        .offset(x: -5, y: 10)
    }
}
