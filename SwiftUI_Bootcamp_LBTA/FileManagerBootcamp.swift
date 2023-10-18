//
//  FileManagerBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 18.10.2023.
//

import SwiftUI

final class LocalFileManager {
    static let shared = LocalFileManager()
    
    func saveToFileManager(image: UIImage, name: String) {
        guard let path = getURL(name: name) else { return }
        
        let data = image.pngData()
        
        do {
            try data?.write(to: path)
            print("Successful saving!!")
        } catch {
            print("Error saving \(error)")
        }
    }
    
    func getImageFromFileManager(name: String) -> UIImage? {
        guard let path = getURL(name: name)?.path(), FileManager.default.fileExists(atPath: path) else { return nil
        }
        return UIImage(contentsOfFile: path)
    }
    
    func deleteImage(name: String) {
        guard let path = getURL(name: name)?.path() else {
            return
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
        } catch {
            print("Error file not deleted \(error)")
        }
        
    }
    
    private func getURL(name: String) -> URL? {
        guard let path = FileManager.default
            .urls(for: .cachesDirectory, in:  .userDomainMask)
            .first?
            .appending(path: "\(name).png", directoryHint: .notDirectory) else {
            print("Error getting data!")
            return nil
        }
        
        return path
    }
}

final class FileManagerViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    private let manager = LocalFileManager.shared
    
    init() {
        getImageFromAssetsFolder()
    }
    
    private func getImageFromAssetsFolder() {
        image = UIImage(named: "USA")
    }
    
    func getImageFromFileManageer() {
        image = manager.getImageFromFileManager(name: "USA")
    }
    
    func saveImage() {
        guard let image else { return }
        manager.saveToFileManager(image: image, name: "USA")
    }
    
    func deleteImage() {
        manager.deleteImage(name: "USA")
        image = nil
    }
}

struct FileManagerBootcamp: View {
    
    @StateObject private var vm = FileManagerViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(width: 300, height: 200)
                        .clipShape(.rect(cornerRadius: 10))
                } else {
                    Spacer().frame(height: 200)
                }
                
                Button(action: {
                    vm.saveImage()
                }, label: {
                    Text("Save to File Manager")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.horizontal)
                        .padding()
                        .background(Color.blue)
                        .clipShape(.rect(cornerRadius: 10))
                })
                
                Button(action: {
                    vm.getImageFromFileManageer()
                }, label: {
                    Text("Get Image from File Manager")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.horizontal)
                        .padding()
                        .background(Color.blue)
                        .clipShape(.rect(cornerRadius: 10))
                })
                
                Button(action: {
                    vm.deleteImage()
                }, label: {
                    Text("Delete Image")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.horizontal)
                        .padding()
                        .background(Color.red)
                        .clipShape(.rect(cornerRadius: 10))
                })
                
                Spacer()
            }
            .navigationTitle("File Manager")
            .padding(.top)
        }
    }
}

#Preview {
    FileManagerBootcamp()
}
