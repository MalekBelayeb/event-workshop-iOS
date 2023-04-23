//
//  extensions.swift
//  event-workshop
//
//  Created by ODC on 23/4/2023.
//

import Foundation



extension String
{
    
    func convertToDate() -> Date?
    {
            
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let inputDate = inputFormatter.date(from: self) else {return nil}
        
        return inputDate
    }
    
}


extension Date
{
    
 
    func formatDate(dateFormat:String = "MMMM-dd") -> String
    {
    
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = dateFormat
        outputFormatter.locale = Locale(identifier: "en_US")
        return outputFormatter.string(from: self)
      
    }
    
    func get(components:Calendar.Component...,calendar:Calendar = Calendar.current) -> DateComponents
    {
        return calendar.dateComponents(Set(components), from: self)
    }
    
}
