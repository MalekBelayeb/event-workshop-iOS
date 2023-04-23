//
//  CategoryFilterView.swift
//  event-workshop
//
//  Created by ODC on 17/4/2023.
//

import SwiftUI

struct CategoryFilterView: View {
    
    var categories:[CategoriesFilterType] = CategoriesFilterType.allCases
    
    @Binding var selectedCategories:[CategoriesFilterType]
    
    var body: some View {

        ScrollView(.horizontal,showsIndicators: false)
        {
            
            HStack
            {
                
                ForEach(CategoriesFilterType.allCases,id:\.self)
                {
                    item in
                    
                    Text(item.rawValue).font(.custom(Fonts.airbnbCereal_medium, size: 14)).foregroundColor(self.selectedCategories.contains(item) ? Style.white : Style.black).padding(.horizontal,16).background(RoundedRectangle(cornerRadius: 12).stroke(Style.grey5).background(self.selectedCategories.contains(item) ? Style.blue3.cornerRadius(12) : Style.white.cornerRadius(12)).frame(height: 42)).fixedSize(horizontal: true, vertical: false).onTapGesture {
                            
                        withAnimation{
                            
                            if self.selectedCategories.contains(item)
                            {
                                
                                self.selectedCategories.removeAll{value in return value == item}
                                
                                if selectedCategories.count == 0
                                {
                                    self.selectedCategories.append(.All)
                                }
                                
                            }else{
                                
                                self.selectedCategories.removeAll{
                                    value in
                                    
                                    return item == .All ? value != .All : value == .All
                                    
                                }
                                
                                self.selectedCategories.append(item)
                                
                            }
                                                       
                        }
                        
                    }
                        
                }
            
            }.padding(.vertical,16)
                  
        }


    }
}

/*
struct CategoryFilterView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        CategoryFilterView()
    }
    
}*/
