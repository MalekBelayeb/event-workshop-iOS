//
//  AllEventsView.swift
//  event-workshop
//
//  Created by ODC on 13/4/2023.
//

import SwiftUI

struct AllEventsView: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var eventViewModel:EventViewModel
    
    @State var showErrorAlert : Bool = false

    var body: some View {
        
        VStack
        {
            
            HStack(spacing:16)
            {
            
                Button
                {
                    
                    self.presentationMode.wrappedValue.dismiss()
                    
                }label: {
                    
                    Image("left-image-ic").resizable().scaledToFill().frame(width: 24,height: 24)
                    
                    Text("Events").foregroundColor(Style.black).font(.custom(Fonts.airbnbCereal_medium, size: 24))

                }
            
                Spacer()
                
            }.padding(16)
            
            
            if self.eventViewModel.getAllUpcomingEventsState == .emptyList
            {
                   
                   Spacer()
                   
                   Text("Empty list, come back later for more details").font(.custom(Fonts.airbnbCereal_book, size: 24)).foregroundColor(Style.grey4).multilineTextAlignment(.center)
                
            }else if self.eventViewModel.getAllUpcomingEventsState == .loading
            {
                   
                   Spacer()
                   
                    ProgressView().scaleEffect(1.4)
                    
            }else if self.eventViewModel.getAllUpcomingEventsState == .success {
                   
                   ScrollView
                   {
                       
                       ScrollViewReader
                       {
                           reader in
                           
                           
                           LazyVStack(spacing:16)
                           {
                            
                               
                               ForEach(self.eventViewModel.allUpcomingEvents)
                               {
                                   
                                   event in
                                   
                                   EventItemVView(event: event).id(event.id).onAppear{
                                       
                                       if self.eventViewModel.allUpcomingEvents.last?.id == event.id
                                       {
                                           self.eventViewModel.allEventCurrentPage += 1
                                       }
                                       
                                   }
                                   
                               }
                               
                           }.onReceive(self.eventViewModel.$allUpcomingEvents)
                           {
                               newVal in
                               
                               
                               reader.scrollTo(newVal[(self.eventViewModel.allEventCurrentPage - 1) * 10].id)
                               
                           }
                           
                       }
                   }
                   
            }
            
            Spacer()
                
        }.navigationBarBackButtonHidden(true).showErrorAlert(showAlert: self.$showErrorAlert, onRetryClicked: {
            
            self.eventViewModel.getAllUpcomingEvents(page: 1, itemPerPage: 0)
            
        }).onReceive(self.eventViewModel.$getAllUpcomingEventsState){
            newVal in
            
            self.showErrorAlert = newVal == .failure
            
        }.onAppear
        {

            self.eventViewModel.getAllUpcomingEvents(page: 1, itemPerPage: 0)
            
        }
        
    }
    
}

struct AllEventsView_Previews: PreviewProvider {
    static var previews: some View {
        AllEventsView(eventViewModel: EventViewModel(eventService: EventService()))
    }
}
