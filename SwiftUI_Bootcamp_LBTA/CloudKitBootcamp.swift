//
//  CloudKitBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 09.11.2023.
//

import SwiftUI
import CloudKit

enum CloudKidError: String, LocalizedError {
    case couldNotDetermine
    case available
    case restricted
    case noAccount
    case temporarilyUnavailable
    case unknown
}

final class CloudKitViewModel: ObservableObject {
    @Published var isSignedInCloud = false
    @Published var permission = false
    @Published var error = ""
    @Published var statusError = ""
    @Published var username = ""
    
    init() {
        getCloudStatus()
    }
    
    private func getCloudStatus() {
        CKContainer.default().accountStatus { [weak self] status, error in
            guard let self else { return }
            
            switch status {
            case .couldNotDetermine:
                self.error = CloudKidError.couldNotDetermine.rawValue
            case .available:
                self.isSignedInCloud = true
            case .restricted:
                self.error = CloudKidError.restricted.rawValue
            case .noAccount:
                self.error = CloudKidError.noAccount.rawValue
            case .temporarilyUnavailable:
                self.error = CloudKidError.temporarilyUnavailable.rawValue
            @unknown default:
                self.error = CloudKidError.unknown.rawValue
            }
        }
    }
    
    func requestPermission() {
        CKContainer.default().requestApplicationPermission([.userDiscoverability]) { [weak self] status, err in
            guard let self else { return }
            
            if let err {
                self.statusError = err.localizedDescription
            }
            
            
            //ios 17 deprecated == granted
            
//            if let status == .granted {
//                permission = true
//            }
        }
    }
    
    func fetchCloudUserId() {
        CKContainer.default().fetchUserRecordID { [weak self] recordId, err in
            guard let self else { return }
            
            if let err {
                self.statusError = err.localizedDescription
            }
            
            if let recordId = recordId {
                discoveriCloudUser(id: recordId)
            }
        }
    }
    
    private func discoveriCloudUser(id: CKRecord.ID) {
        CKContainer.default().discoverUserIdentity(withUserRecordID: id) { [weak self] user, err in
            guard let self else { return }
            
            if let err {
                self.statusError = err.localizedDescription
            }
            
            if let user = user?.nameComponents?.givenName {
                self.username = user
            }
        }
    }
}

struct CloudKitBootcamp: View {
    
    @StateObject private var vm = CloudKitViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text("signed In Cloud: \(vm.isSignedInCloud.description)")
            Text("Cloud Error: \(vm.error)")
            Text("Username: \(vm.username)")
            Spacer()
            Text("Error: \(vm.statusError)")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    CloudKitBootcamp()
}
