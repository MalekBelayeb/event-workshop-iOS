//
//  Event.swift
//  event-workshop
//
//  Created by ODC on 13/4/2023.
//

import Foundation


struct Event:Identifiable,Equatable
{
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id 
    }
    
    
    var id: Int
    var cover:String
    var dayNumber:Int
    var month:String
    var name:String
    var location:String
    var datetime:String
    var performers:[Performer]
 
}




