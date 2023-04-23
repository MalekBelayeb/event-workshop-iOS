//
//  EventDetailView.swift
//  event-workshop
//
//  Created by ODC on 13/4/2023.
//

import SwiftUI

struct EventDetailView: View {

    @ObservedObject var eventViewModel:EventViewModel
    
    let eventId:String
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        GeometryReader
        {
            geo in
            
            VStack(alignment:.leading)
            {
                
                AsyncImage(url: URL(string: eventViewModel.eventDetail.cover)){
                    image in
                    
                    image.resizable().scaledToFill().frame(width:geo.size.width,height:300)
                    
                }placeholder: {
                    
                    ProgressView().frame(width:geo.size.width,height:300)
                    
                } .overlay(alignment:.top)
                {
                    
                    Rectangle().fill(.clear).background(LinearGradient(gradient: Gradient(colors: [.black.opacity(0.5), .clear]), startPoint: .top, endPoint: .bottom)).frame(height:200)
               
                }
                
                VStack(alignment:.leading,spacing: 24)
                {
                  
                    Text(eventViewModel.eventDetail.name).font(.custom(Fonts.airbnbCereal_book, size: 24)).lineSpacing(1.8).lineLimit(4)
                    
                    HStack(spacing:16)
                    {
                        
                        Style.blue3.frame(width:42,height:42).cornerRadius(12).opacity(0.15).overlay{
                            Image("calendar-ic").resizable().frame(width: 24,height: 24)
                         
                        }
                        
                        VStack(alignment:.leading){
                            
                            Text(self.eventViewModel.eventDetail.date).font(.custom(Fonts.airbnbCereal_medium, size: 16))
                            
                            Text(self.eventViewModel.eventDetail.dayTime).foregroundColor(Style.grey4).font(.custom(Fonts.airbnbCereal_book, size: 14))
                            
                        }
                        
                    }
                    
                    HStack(spacing:16)
                    {
                        
                        Style.blue3.frame(width:42,height:42).cornerRadius(12).opacity(0.15).overlay{
                            Image("location-ic").resizable().frame(width: 24,height: 24)
                         
                        }
                        
                        VStack(alignment:.leading){
                            
                            Text(self.eventViewModel.eventDetail.placeName).font(.custom(Fonts.airbnbCereal_medium, size: 16))
                            
                            Text(self.eventViewModel.eventDetail.location).foregroundColor(Style.grey4).font(.custom(Fonts.airbnbCereal_book, size: 14))
                        }
                        
                    }
                    
                }.padding(.horizontal,16).padding(.top,32)
                
                Text("Performers").font(.custom(Fonts.airbnbCereal_medium, size: 22)).padding(.horizontal,16).padding(.top,16)
                
                ScrollView(.horizontal,showsIndicators: false)
                {
                  
                    HStack(spacing:16){
                       
                        ForEach(self.eventViewModel.eventDetail.performers)
                        {
                            performer in
                           
                            PerformerItemView(performer: performer)
                            
                        }
                       
                    }.padding(.horizontal,16).padding(.vertical,8)
                    
                }
                
                Spacer()
                
            }.edgesIgnoringSafeArea(.top).overlay(alignment:.top)
            {
                
                HStack{

                    Button{

                        self.presentationMode.wrappedValue.dismiss()
                        
                    }label: {
                        
                        Image(systemName: "arrow.left").font(.custom(Fonts.airbnbCereal_bold, size: 18)).foregroundColor(Style.white)
                        
                        Text("Event Details").font(.custom(Fonts.airbnbCereal_bold, size: 18)).foregroundColor(Style.white)

                    }
                    
                    Spacer()
                    
                }.padding(.horizontal,16)
                
            }.navigationBarBackButtonHidden(true).onAppear{
                
                self.eventViewModel.getEventById(eventId: self.eventId)
                
            }
    
        }
    }
}

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailView(eventViewModel: EventViewModel(eventService: EventService()),eventId: "")
    }
}
