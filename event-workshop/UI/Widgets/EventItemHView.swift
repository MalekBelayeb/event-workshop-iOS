//
//  EventItemView.swift
//  event-workshop
//
//  Created by ODC on 13/4/2023.
//

import SwiftUI

struct EventItemHView: View {
        
    @State var height:CGFloat = 290
    var width:CGFloat = 300

    let event:Event
    
    @State var navToDetail:Bool = false
    
    @ObservedObject var eventViewModel:EventViewModel
    
    var body: some View {
        
        ZStack{
            
            NavigationLink("",destination: EventDetailView(eventViewModel:self.eventViewModel,eventId: String(self.event.id)),isActive: $navToDetail)
            
            VStack(spacing:4)
            {
                
                ZStack
                {
                    
                    if event.cover == ""
                    {
                        
                        
                        Image("event-image").resizable().scaledToFill().frame(height: height * 0.45).cornerRadius(7.5).overlay(alignment:.topLeading){
                            
                            ZStack
                            {
                                
                                RoundedRectangle(cornerRadius: 7.5).foregroundColor(.white.opacity(0.7)).frame(width: 52,height: 62)
                                
                                VStack
                                {
                                    
                                    Text("\(event.dayNumber)").font(.custom(Fonts.airbnbCereal_bold, size: 18)).foregroundColor(Style.red)
                                    
                                    Text(event.month).font(.custom(Fonts.airbnbCereal_medium, size: 10)).foregroundColor(Style.red)
                                    
                                }
                                
                            }.padding(.leading,4).padding(.top,4)
                            
                        }.padding(.horizontal, 16).padding(.top,16)
                        
                    }else{
                        
                        AsyncImage(url: URL(string: event.cover))
                        { image in
                                  
                            
                            image.resizable().scaledToFill().frame(height: height * 0.45).cornerRadius(7.5)
                                      
                              } placeholder: {
                              
                                  Color.gray
                        
                              }.overlay(alignment:.topLeading){
                                  
                                  ZStack
                                  {
                                      
                                      RoundedRectangle(cornerRadius: 7.5).foregroundColor(.white.opacity(0.7)).frame(width: 52,height: 62)
                                      
                                      VStack
                                      {
                                          
                                          Text("\(event.dayNumber)").font(.custom(Fonts.airbnbCereal_bold, size: 18)).foregroundColor(Style.red)
                                          
                                          Text(event.month).font(.custom(Fonts.airbnbCereal_medium, size: 10)).foregroundColor(Style.red)
                                          
                                      }
                                      
                                  }.padding(.leading,4).padding(.top,4)
                                  
                              }.padding(.horizontal, 16).padding(.top,16)
                        
                    }
                            
                    
                }
                
                
                VStack(alignment:.leading)
                {
                    
                    if (event.performers).count > 0
                    {
                        Spacer()
                    }
                    
                    Text(event.name).lineLimit(2).font(.custom(Fonts.airbnbCereal_medium, size: 17)).padding(.horizontal, 16).multilineTextAlignment(.leading).fixedSize(horizontal: false, vertical: true)

                    PerformerImagesHView(performers: event.performers)
                    
                    HStack
                    {
                        
                        Image("map-in").frame(width: 24,height: 24)
                        
                        Text(event.location).foregroundColor(Style.grey1).font(.custom(Fonts.airbnbCereal_book, size: 14)).lineLimit(2)
                        
                        Spacer()
                        
                    }.padding([.horizontal],16)
                    
                    Spacer()
                    
                }

            }
            
        }.frame(width: width,height: height).background(Style.white).cornerRadius(13.5).padding(.horizontal,16).shadow(color:.black.opacity(0.1),radius: 5,y:4).onAppear{
            
            self.height = (event.performers).count > 0 ? self.height : (self.height - 50)
             
        }.onTapGesture {
            
            self.navToDetail = true
            
        }
        
    }
    
}

struct EventItemView_Previews: PreviewProvider {
    static var previews: some View {
        
        EventItemHView(event: MockData.event, eventViewModel: EventViewModel(eventService: EventService()))
        
    }
}
