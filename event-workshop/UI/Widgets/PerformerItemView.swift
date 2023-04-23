//
//  PerformerItemView.swift
//  event-workshop
//
//  Created by ODC on 22/4/2023.
//

import SwiftUI

struct PerformerItemView: View {
    
    let performer:Performer
    
    var body: some View {
        
        AsyncImage(url:URL(string:performer.image))
        {
            image in
            
            image.resizable().scaledToFill().frame(width:160,height:120)
           
        }placeholder:{
            
            Style.grey3.opacity(0.1).frame(width:160,height:120).overlay{
                
                ProgressView()
                
            }
            
        }.overlay{
            
            LinearGradient(gradient: Gradient(colors: [Color.clear,Style.black.opacity(0.4)]), startPoint: .top, endPoint: .bottom)
            
        }.overlay(alignment:.bottomLeading)
        {
            
            VStack(alignment:.leading){
                
                Text(performer.fullname).font(.custom(Fonts.airbnbCereal_bold, size: 14)).foregroundColor(Style.white)
                
                Text(performer.role).foregroundColor(Style.grey2).font(.custom(Fonts.airbnbCereal_medium, size: 12))
                
            }
            .padding([.leading,.bottom],8)
            
        }.cornerRadius(12).shadow(color: Style.black.opacity(0.4),radius: 4, x:2,y:2)


    }
}


struct PerformerItemView_Previews: PreviewProvider {
    
    static var previews: some View {
    
        PerformerItemView(performer: Performer(fullname: "Ashfak Sayem", image: "event-image",role: "Musician"))
        
    }
}
