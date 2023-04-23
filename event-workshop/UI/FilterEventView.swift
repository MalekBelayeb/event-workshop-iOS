//
//  FilterEventView.swift
//  event-workshop
//
//  Created by ODC on 17/4/2023.
//

import SwiftUI

enum CategoriesFilterType:String, CaseIterable
{

    case All = "All"
    case Concert = "Concert"
    case Comedy = "Comedy"
    case Sport = "Sport"
    
}

enum DateTimeFilterType:String, CaseIterable
{
    
    case All = "All"
    case Today = "Today"
    case Tomorrow = "Tomorrow"
    case ThisWeek = "This Week"
    case NextWeek = "Next Week"

}

struct FilterEventView: View {
    
    
    @Binding var priceFilterValue: Double
    @Binding var selectedCategories: [CategoriesFilterType]
    @Binding var selectedDateFilter: DateTimeFilterType
    
    var body: some View {
        
        VStack(spacing:16)
        {
            
            Spacer()
            
            VStack
            {
                HStack
                {
                    
                    Text("Categories").font(.custom(Fonts.airbnbCereal_medium, size: 16))
                    
                    Spacer()
                    
                }
                
                CategoryFilterView(selectedCategories: $selectedCategories)
                
            }
            
            VStack
            {
            
                HStack
                {
                    
                    Text("Date & Time").font(.custom(Fonts.airbnbCereal_medium, size: 16))
                    
                    Spacer()
                    
                }
                
                TimeDateFilterView(selectedDateFilter: $selectedDateFilter)
                
            }
            
            VStack
            {
            
                HStack
                {
                    
                    Text("Price filter").font(.custom(Fonts.airbnbCereal_medium, size: 16))
                    
                    Spacer()
                    
                    Text(String(format:"$ %.f ",self.priceFilterValue)).font(.custom(Fonts.airbnbCereal_medium, size: 16))
                    
                }
                
                Slider(value: $priceFilterValue,in: 20...1000,step: 1).tint(Style.blue3)
                
            }.padding(.bottom,32)
            
            /*
            HStack(spacing:16)
            {
               
                Button
                {
                    
                    
                }label: {
                
                    Style.white.cornerRadius(12).frame(width: 132,height:42).background(RoundedRectangle(cornerRadius: 12).stroke(Style.grey2,lineWidth: 2)).overlay{
                        
                        Text("RESET").font(.custom(Fonts.airbnbCereal_medium, size: 14)).foregroundColor(Style.black)
                        
                    }
                    
                    
                }
                
                Button
                {
                    
                    
                }label: {
                
                    Style.blue3.cornerRadius(12).frame(height:42).background(RoundedRectangle(cornerRadius: 12).stroke(Style.grey2,lineWidth: 2)).overlay{
                        
                        Text("APPLY").font(.custom(Fonts.airbnbCereal_medium, size: 14)).foregroundColor(Style.white)
                        
                    }
                    
                }
                
            }*/
            
        }.padding(.horizontal,16)
        
    }
}


/*
struct FilterEventView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        FilterEventView(selectedCategories: Binding.constant([]), selectedDateFilter: Binding.constant(.All))
        
    }
}*/
