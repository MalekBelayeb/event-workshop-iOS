//
//  Const.swift
//  event-workshop
//
//  Created by ODC on 13/4/2023.
//

import Foundation


class Consts
{
    
    
    static let clientId = "MzI5ODA2NjN8MTY4MTExNzQwOS4xMDE2NTMz"
    static let URL = "https://api.seatgeek.com/2/"
    static let getAllLatestEvents = "\(URL)events?client_id=\(clientId)&per_page=10&page=1&sort=datetime_utc.asc"
    
    static let getEventById = "https://api.seatgeek.com/2/events/5915685?client_id=\(clientId)"
        
    static let searchEvent = "https://api.seatgeek.com/2/events?q=Rocky&client_id=\(clientId)"
    
    
}
