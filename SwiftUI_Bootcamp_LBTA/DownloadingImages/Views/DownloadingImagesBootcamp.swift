//
//  DownloadingImagesBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 19.10.2023.
//

import SwiftUI

struct DownloadingImagesBootcamp: View {
    @StateObject private var vm = DownloadingImagesViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                List {
                    ForEach(vm.arrayModel) { model in
                        DownloadingImageRow(model: model)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Catch Bootcamp")
            .refreshable {
                await vm.downloadingImages()
            }
            .task {
                await vm.downloadingImages()
            }
        }
    }
}

#Preview {
    DownloadingImagesBootcamp()
}
