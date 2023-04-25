//
//  HomeView.swift
//  event-workshop
//
//  Created by ODC on 13/4/2023.
//

import SwiftUI

struct HomeView: View {
    
    @State var searchValue: String = ""
    
    //@State var events : [Event] = MockData.events
    
    @State var navToAllEvents:Bool = false
    
    @State var showBottomSheet:Bool = false
    
    
    @ObservedObject var eventViewModel: EventViewModel 
    
    var body: some View {
        
        GeometryReader
        {
            geo in
           
            ZStack
            {
                
                NavigationLink("",destination: AllEventsView(eventViewModel: self.eventViewModel),isActive: $navToAllEvents)
                
                ScrollView(showsIndicators: false)
                {
                    
                    VStack
                    {
                        
                        SearchInputView(searchValue: $searchValue).padding([.horizontal,.top],16)
                        
                        VStack(spacing:32){
                          
                            HStack
                            {
                                
                                Spacer()
                                
                                Button
                                {
                                    
                                    self.showBottomSheet = true
                                    
                                }label: {
                                    
                                    RoundedRectangle(cornerRadius: 24).foregroundColor(Style.blue3).frame(width:92,height: 36).shadow(color:Style.black.opacity(0.15),radius: 2,y: 3).overlay{
                                     
                                        HStack
                                        {
                                            
                                            Image("filters-ic").frame(width: 16,height: 16)
                                            
                                            Spacer()
                                            
                                            Text("Filters").foregroundColor(Style.white).font(.custom(Fonts.airbnbCereal_medium, size: 14))
                                            
                                        }.padding(.horizontal,12)
                                        
                                    }
                                }
                                
                                
                            }.padding(.horizontal,16)
                            
                            VStack(spacing:4)
                            {
                                
                                HStack
                                {
                                    
                                    
                                    Text("Upcoming Events").font(.custom(Fonts.airbnbCereal_medium, size: 18)).foregroundColor(Style.black)
                                    
                                    Spacer()
                                    
                                    Button
                                    {
                                        
                                        self.navToAllEvents = true
                                        
                                    }label: {
                                    
                                        HStack(spacing: 4)
                                        {
                                            
                                            Text("See All").font(.custom(Fonts.airbnbCereal_book, size: 16)).foregroundColor(Style.grey4)
                                            
                                            Image("right-arrow-ic").resizable().scaledToFill().frame(width: 8,height: 8)
                                            
                                        }
                                        
                                    }
                                    
                                }.padding(.horizontal,16)
                                
                                ScrollView(.horizontal,showsIndicators: false)
                                {
                                    
                                    if self.eventViewModel.upcomingEventsIsLoading
                                    {
                                        
                                        HStack
                                        {
                                            
                                            Spacer()
                                            ProgressView()
                                            Spacer()
                                            
                                        }.frame(width: geo.size.width,height:200)
                                        
                                    }else{
                                        
                                        LazyHStack(spacing:0)
                                        {
                                            
                                            ForEach(self.eventViewModel.upcomingEvents) { event in
                                                
                                                EventItemHView(width:geo.size.width * 0.7, event: event, eventViewModel: self.eventViewModel)
                                                
                                            }
                                    
                                        }.padding(.vertical,16)
                                        
                                        
                                    }
                                  
                                }
                                
                                
                            }
                            
                            VStack(spacing:4)
                            {
                                
                                HStack
                                {
                                    
                                    Text("Nearby You").font(.custom(Fonts.airbnbCereal_medium, size: 18)).foregroundColor(Style.black)
                                    
                                    Spacer()
                                    
                                    Button
                                    {
                                        
                                        self.navToAllEvents = true
                                        
                                    }label: {
                                        
                                        HStack(spacing: 4)
                                        {
                                            
                                            Text("See All").font(.custom(Fonts.airbnbCereal_book, size: 16)).foregroundColor(Style.grey4)
                                            
                                            Image("right-arrow-ic").resizable().scaledToFill().frame(width: 8,height: 8)
                                            
                                        }
                                        
                                    }
                                    
                                }.padding(.horizontal,16)
                                
                                ScrollView(.horizontal,showsIndicators: false)
                                {
                                    
                                    
                                    if self.eventViewModel.nearbyEventsIsLoading
                                    {
                                        
                                        HStack(spacing:0)
                                        {
                                           
                                            Spacer()
                                            ProgressView()
                                            Spacer()
                                            
                                        }.frame(width: geo.size.width,height:200)
                                        
                                        
                                    }else{
                                        
                                        LazyHStack(spacing:0)
                                        {
                                            
                                            ForEach(self.eventViewModel.upcomingEvents)
                                            {
                                                event in
                                                
                                                EventItemHView(width:geo.size.width * 0.7, event: event, eventViewModel: self.eventViewModel)
                                                
                                            }
                                            
                                        }.padding(.vertical,16)
                                        
                                    }
                                    
                                }
                                
                            }
                            
                        }.padding(.top,16)
                        
                        Spacer()
                    }
                    
                }
                
            }.sheet(isPresented: $showBottomSheet)
            {
                
                FilterEventView(priceFilterValue: self.$eventViewModel.priceFilter,selectedCategories: self.$eventViewModel.selectedCategories, selectedDateFilter: self.$eventViewModel.selectedDateFilter).presentationDetents([.height(geo.size.height * 0.4)]).presentationDragIndicator(.visible)
                
            }.padding(.bottom,8).onAppear
            {
                
                self.eventViewModel.getAllUpcomingEvents()
                self.eventViewModel.getAllNearbyEvents()

            }
            
        }

    }
    
}

struct HomeView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        
        HomeView(eventViewModel: EventViewModel(eventService: EventService()))
        
    }
}
