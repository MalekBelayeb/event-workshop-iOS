//
//  PerformerImagesHView.swift
//  event-workshop
//
//  Created by ODC on 22/4/2023.
//

import SwiftUI

struct PerformerImagesHView: View {
   
    let performers:[Performer]
    
    var body: some View {

        HStack(spacing:-12)
        {
            Spacer()
            
            ForEach(performers.reversed())
            {
                performer in
                
                Circle().foregroundColor(Style.white).frame(width: 32,height: 32).overlay{
                    
                    AsyncImage(url:URL(string:performer.image))
                    {
                        image in
                        
                        image.resizable().scaledToFill().frame(width: 28,height: 28).mask(Circle())
                       
                    }placeholder:{
                        
                        
                    }
                    
                }
                
            }
            
        }.padding(.horizontal,16).environment(\.layoutDirection, .rightToLeft)
        
    }
}

struct PerformerImagesHView_Previews: PreviewProvider {
    static var previews: some View {
        PerformerImagesHView(performers: MockData.event.performers)
    }
}
