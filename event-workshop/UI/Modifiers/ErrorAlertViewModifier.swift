//
//  ErrorAlertViewModifier.swift
//  event-workshop
//
//  Created by ODC on 25/4/2023.
//

import SwiftUI


extension View
{
    
    func showErrorAlert(showAlert:Binding<Bool>,onRetryClicked: ( () -> Void )?) -> some View
    {
        return self.modifier(ErrorAlertViewModifier(showErrorAlert: showAlert, onRetryClicked: onRetryClicked))
    }
    
}


struct ErrorAlertViewModifier: ViewModifier {
    
    @Binding var showErrorAlert:Bool
        
    let onRetryClicked:( () -> Void )?
    
    func body(content: Content) -> some View {
    
        content.alert("Error occured", isPresented: $showErrorAlert, actions: {
            
            Button("Cancel", role: .cancel, action: {})
            if let action = self.onRetryClicked
            {
                
                Button("Retry", action: {
                    
                    action()
                    
                })
            }

        }, message: {
            
            Text("Something bad happened please try again later")

        })
        
    }
    
    
    
}


