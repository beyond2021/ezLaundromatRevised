//
//  TwitImagePicker.swift
//  TweeterSwiftUI
//
//  Created by KEEVIN MITCHELL on 2/15/22.
// TRANSLATION FROM UIKIT TO SWIFTUI VIEW

import SwiftUI

struct TwitImagePicker: UIViewControllerRepresentable {
    
    // To get the image that the user picks
    @Binding var selectedImage: UIImage?
    // to dismiss ourself
    @Environment(\.presentationMode) var presentationMode
    
    
    
    
    // MARK: UIViewControllerRepresentable Protocol Methods
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
        
    }
    
    // Create the Image Picker
    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator // not self but coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Blank
    }
    
}

extension TwitImagePicker {
    
    // Coordinator is the Link between UIKit/SwiftUI
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        // Link the coordinator back to the TwitImagePicker
        let parent: TwitImagePicker
        
        // inti
        init(_ parent: TwitImagePicker) {
            self.parent = parent
            
        }
        
        // MARK: Image picker Delegate Methods
        
        // MARK: Set so image property
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // Get our image
            guard let image = info[.originalImage] as? UIImage else { return }
            // pass our image to the picker
            parent.selectedImage = image
            // MARK: Save Image to Photo Album
           // UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            // Dissmiss the Picker
            parent.presentationMode.wrappedValue.dismiss()
        }
        
    }
}

// wealth cruise farm zero help volume weird merit fiction timber royal name
