//
//  LocalPreferences.swift
//  event-workshop
//
//  Created by ODC on 23/4/2023.
//

import Foundation
import SwiftUI

class LocalPreferences
{
    
    static let shared = LocalPreferences()
    
    @AppStorage("categories") var categoryFilter:String = CategoriesFilterType.All.rawValue
    @AppStorage("date") var dateFilter: String = DateTimeFilterType.All.rawValue
    @AppStorage("price") var priceFilter:Double = 0
    
}
