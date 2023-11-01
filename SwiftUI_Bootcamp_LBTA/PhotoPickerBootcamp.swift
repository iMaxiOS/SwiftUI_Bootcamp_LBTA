//
//  PhotoPickerBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 31.10.2023.
//

import SwiftUI
import PhotosUI

final class PhotoPickerViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var images: [UIImage] = []
    
    @Published var selectionsImage: [PhotosPickerItem] = [] {
        didSet {
            self.getImagesFromPhotoPicker(from: selectionsImage)
        }
    }
    
    @Published var selectionImage: PhotosPickerItem? = nil {
        didSet {
            self.getImageFromPhotoPicker(from: selectionImage)
        }
    }
    
    func getImageFromPhotoPicker(from selection: PhotosPickerItem?) {
        guard let selection else { return }
        
        Task {
            if let data = try? await selection.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    self.image = uiImage
                }
            }
        }
    }
    
    func getImagesFromPhotoPicker(from selections: [PhotosPickerItem]) {
        Task {
            var images: [UIImage] = []
            
            for selection in selections {
                if let data = try? await selection.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        images.append(uiImage)
                    }
                }
            }
            
            self.images = images
        }
    }
}

struct PhotoPickerBootcamp: View {
    @StateObject private var vm = PhotoPickerViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipShape(.rect(cornerRadius: 10))
            }
            
            PhotosPicker(selection: $vm.selectionImage) {
                Text("Photo Picker to image")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color.blue)
                    .clipShape(.rect(cornerRadius: 10))
            }
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(vm.images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(.rect(cornerRadius: 10))
                    }
                }
                .padding(.horizontal)
            }
            
            PhotosPicker(selection: $vm.selectionsImage) {
                Text("Photo Picker to images")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color.blue)
                    .clipShape(.rect(cornerRadius: 10))
            }
        }
    }
}

#Preview {
    PhotoPickerBootcamp()
}
