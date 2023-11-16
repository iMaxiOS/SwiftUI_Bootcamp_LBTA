//
//  ErrorAlertBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 15.11.2023.
//

import SwiftUI

protocol AppAlert {
    var title: String { get }
    var description: String? { get }
    var buttons: AnyView { get }
}

struct ErrorAlertBootcamp: View {
    
    @State private var alert: AlertNetworkError? = nil
    
    var body: some View {
        VStack {
            Button {
                saveData()
            } label: {
                Text("Save Data.")
                    .modifier(ButtonModifier())
            }
        }
        .showAlert(alert: $alert)
    }
    
    enum AlertNetworkError: Error, LocalizedError, AppAlert {
        case notInternet(ok: () -> Void, cancel: () -> Void)
        case notFoundData
        case urlError(Error)
        
        var buttons: AnyView {
            AnyView(getAlert)
        }
        
        @ViewBuilder
        var getAlert: some View {
            switch self {
            case .notInternet(ok: let ok, cancel: let cancel):
                Button("OK") {
                    ok()
                }
                
                Button("Cancel") {
                    cancel()
                }
            case .notFoundData:
                Button("RETRY") {
                    
                }
            default:
                Button("OKAY") {
                    
                }
            }
        }
        
        var title: String {
            switch self {
            case .notInternet: "Not Internet Connection."
            case .notFoundData: "No Data."
            case .urlError: "Error:"
            }
        }
        
        var description: String? {
            switch self {
            case .notInternet: "Please check your internet connection and try again."
            case .notFoundData: nil
            case .urlError(let error): error.localizedDescription
            }
        }
    }
}

private extension View {
    func showAlert<T: AppAlert>(alert: Binding<T?>) -> some View {
        self
            .alert(alert.wrappedValue?.title ?? "", isPresented: Binding(value: alert), actions: {
                alert.wrappedValue?.buttons
            }, message: {
                if let description = alert.wrappedValue?.description {
                    Text(description)
                }
            })
    }
}

private extension ErrorAlertBootcamp {
    func saveData() {
        let isSuccessful = false
        
        if isSuccessful {
            
        } else {
            alert = .notInternet(ok: {
                
            }, cancel: {
                    
            })
        }
    }
}

#Preview {
    ErrorAlertBootcamp()
}
