//
//  EventItemVView.swift
//  event-workshop
//
//  Created by ODC on 16/4/2023.
//

import SwiftUI

struct EventItemVView: View {
    
    let height:CGFloat = 150
    let event:Event
    
    @State var navToDetail : Bool = false
    
    var body: some View {
            
            ZStack
            {
                
                GeometryReader
                {
                    geo in
                    
                    HStack
                    {
                        
                        AsyncImage(url: URL(string: event.cover))
                        {
                            image in
                            
                            image.resizable().scaledToFill().frame(width:geo.size.width * 0.3)
                            
                        }placeholder: {
                         
                            ProgressView().frame(width:geo.size.width * 0.3)
                            
                        }
                        .cornerRadius(7.5).padding([.leading,.vertical],16)
                        
                        VStack(alignment: .leading)
                        {
                            
                            Text(event.datetime).font(.custom(Fonts.airbnbCereal_book, size: 14)).foregroundColor(Style.blue3).lineLimit(4).frame(maxWidth:.infinity,alignment: .leading)
                            
                            Spacer()
                            
                            Text(event.name).font(.custom(Fonts.airbnbCereal_medium, size: 16)).foregroundColor(Style.black).lineLimit(2).frame(maxWidth:.infinity,alignment: .leading)
                            
                            Spacer()
                            
                            PerformerImagesHView(performers: event.performers)
                            
                            HStack(spacing:4)
                            {
                                
                                Image("map-in").resizable().frame(width: 16,height: 16)
                                
                                Text(event.location).foregroundColor(Style.grey1).font(.custom(Fonts.airbnbCereal_book, size: 14)).lineLimit(2)
                                
                            }.frame(maxWidth: .infinity,alignment: .leading)
                        
                        }.padding(.vertical,18)
                        
                        Spacer()
                        
                    }
                }
            }.frame(height: height).background(Style.white).cornerRadius(13.5).padding(.horizontal,16).shadow(color:.black.opacity(0.1),radius: 5,y:4).onTapGesture {
                
                self.navToDetail = true
                
            }
            
    }
}

struct EventItemVView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        
        EventItemVView(event: MockData.event)
        
    }
}
