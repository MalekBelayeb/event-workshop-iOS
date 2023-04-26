//
//  SearchInputView.swift
//  event-workshop
//
//  Created by ODC on 16/4/2023.
//

import SwiftUI

struct SearchInputView: View {

    @Binding var searchValue:String
    @FocusState.Binding var searchValueIsFocused:Bool
    
    let height:CGFloat = 50

    var body: some View {

        ZStack
        {
            
            RoundedRectangle(cornerRadius: 75).stroke(Style.grey2,lineWidth: 2).frame(height: height).overlay{
                
                HStack
                {
                    
                    TextField("Search", text: $searchValue).focused($searchValueIsFocused).font(.custom(Fonts.airbnbCereal_book, size: 14)).padding(.leading,32).foregroundColor(Style.grey3)
                    
                    if !searchValueIsFocused
                    {
                        Image("search-ic").frame(width:24,height: 24).padding(.trailing,24)
                      
                    }else{
                        
                        Text("X").frame(width:24,height: 24).padding(.trailing,24).onTapGesture {
                            self.searchValueIsFocused = false 
                        }
                    }
                    
                }
            }
        }
    }
}


