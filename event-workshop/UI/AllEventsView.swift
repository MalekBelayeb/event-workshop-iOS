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
                       
                       VStack(spacing:16)
                       {
                        
                           
                           ForEach(self.eventViewModel.allUpcomingEvents)
                           {
                               
                               event in
                               
                               EventItemVView(event: event)
                               
                           }
                           
                           
                       }
                   }
                   
            }
            
            Spacer()
                
        }.navigationBarBackButtonHidden(true).alert("Error occured", isPresented: $showErrorAlert, actions: { // 2
            
            Button("Cancel", role: .cancel, action: {})
            Button("Retry", action: {
                
                self.eventViewModel.getAllUpcomingEvents(page: 1, itemPerPage: 10)
                
            })

        }, message: {
            
            Text("Something bad happened please try again later")

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