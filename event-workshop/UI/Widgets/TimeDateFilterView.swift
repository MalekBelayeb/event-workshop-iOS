//
//  TmeDateFilterView.swift
//  event-workshop
//
//  Created by ODC on 18/4/2023.
//

import SwiftUI




struct TimeDateFilterView: View {
    
    var dateFilters:[DateTimeFilterType] = DateTimeFilterType.allCases
    @Binding var selectedDateFilter:DateTimeFilterType
        
    var body: some View {
        
        ScrollView(.horizontal,showsIndicators: false)
        {
            
            HStack
            {
                
                ForEach(DateTimeFilterType.allCases,id:\.self)
                {
                    item in
                    
                    Text(item.rawValue).font(.custom(Fonts.airbnbCereal_medium, size: 14)).foregroundColor(self.selectedDateFilter == item ? Style.white : Style.black).padding(.horizontal,16).background(RoundedRectangle(cornerRadius: 12).stroke(Style.grey5).background(self.selectedDateFilter == item ? Style.blue3.cornerRadius(12) : Style.white.cornerRadius(12)).frame(height: 42)).fixedSize(horizontal: true, vertical: false).onTapGesture {
                        
                        withAnimation{
                            
                            self.selectedDateFilter = item

                        }
                        
                    }
                    
                }
            
            }.padding(.vertical,16)

        }

    }
}

/*
 
struct TmeDateFilterView_Previews: PreviewProvider {
    static var previews: some View {
        TimeDateFilterView()
    }
}
*/
