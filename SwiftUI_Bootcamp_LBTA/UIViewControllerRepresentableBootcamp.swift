//
//  UIViewControllerRepresentableBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 07.11.2023.
//

import SwiftUI

struct UIViewControllerRepresentableBootcamp: View {
    
    @State private var showScreen: Bool = false
    @State private var image: UIImage? = nil
    
    var body: some View {
        VStack {
            Text("Push to the next screen -> ...")
                .bold()
            
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 200, height: 100)
                    .clipShape(.rect(cornerRadius: 10))
            }
            
            Button {
                showScreen.toggle()
            } label: {
                Text("Push to Image Picker...")
                    .bold()
                    .foregroundStyle(.white)
                    .padding()
                    .background(.blue)
                    .clipShape(.rect(cornerRadius: 10))
            }
            .sheet(isPresented: $showScreen, content: {
                UIImagePickerRepresentable(show: $showScreen, image: $image)
            })
        }
    }
}

#Preview {
    UIViewControllerRepresentableBootcamp()
}

struct UIImagePickerRepresentable: UIViewControllerRepresentable {
    
    @Binding var show: Bool
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.sourceType = .photoLibrary
        return imagePicker
    }
    
    // From SwiftUI to UIKit
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    // From UIKit to SwiftUI
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
        
        var parent: UIImagePickerRepresentable
        
        init(parent: UIImagePickerRepresentable) {
            self.parent = parent
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.parent.show.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[.originalImage] as! UIImage
            if let data = image.pngData(), let image = UIImage(data: data) {
                self.parent.image = image
            }
            self.parent.show.toggle()
        }
    }
    
}

struct UIControllerRepresentable: UIViewControllerRepresentable {
    @Binding var text: String
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = FirstViewController(text: text)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator: NSObject {
        
    }
}

final class FirstViewController: UIViewController {
    
    private let textLabel = UILabel()
    private var text: String
    
    init(text: String) {
        self.text = text
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel.text = text
        textLabel.textColor = .white
        view.addSubview(textLabel)
        view.backgroundColor = .red
        textLabel.frame = view.frame
    }
}
