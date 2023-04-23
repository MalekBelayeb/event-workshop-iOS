//
//  event_workshopApp.swift
//  event-workshop
//
//  Created by ODC on 12/4/2023.
//

import SwiftUI

@main
struct event_workshopApp: App {
    
    @StateObject var eventViewModel = EventViewModel(eventService: EventService())
    
    var body: some Scene {
        
        WindowGroup {
            
            NavigationView{
                
                HomeView(eventViewModel: eventViewModel)
                
            }
            
        }
        
    }
}
