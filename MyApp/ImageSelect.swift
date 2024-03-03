//
//  ImageSelection.swift
//  DirectVision
//
//  Created by Paul on 1/13/24.
//

import Foundation
import SwiftUI
import Vision
import Speech
import CoreML

struct ImageSelectn: View {
    @State private var image: Image? = nil
    @State private var showingImagePicker = false
    @State private var isImagePickerPresented = false
    @State private var inputImage: UIImage?
    @State private var recognizedText: String = ""

    var body: some View {
        VStack {
            /*Button("System Image Recognition Camera") {
                isImagePickerPresented.toggle()
            }
            .sheet(isPresented: $isImagePickerPresented, onDismiss: loadImage) {
                ImagePickerView(sourceType: .camera)
            }
             */
            Button("Select Photo") {
                showingImagePicker .toggle()
            }
            image?
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 300)

            Text(recognizedText)
                .lineLimit(200)
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
    }
}
    
private func speakText(_ text: String) {
        let synthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: text)
        synthesizer.speak(utterance)
}
    
func loadImage() {
    guard let inputImage = inputImage else { return }
    image = Image(uiImage: inputImage)
    recognizeText(image: inputImage)
    // Introduce a delay before dismissing the sheet
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        self.showingImagePicker = false
    }
    speakText("Finished analyzing")
}

func recognizeText(image: UIImage) {
    guard let cgImage = image.cgImage else { return }
    
    let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
    let request = VNRecognizeTextRequest { (request, error) in
        if let error = error {
                print("Error: \(error)")
        } else if let observations = request.results as? [VNRecognizedTextObservation] {
            self.recognizedText = observations.compactMap { $0.topCandidates(1).first?.string }.joined(separator: "\n")
        }
    }

        do {
            try requestHandler.perform([request])
        } catch {
            print("Unable to perform the request: \(error).")
        }
    }
}



struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.image = uiImage
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [self] in
                parent.presentationMode.wrappedValue.dismiss()
            }
        }
    }

}




struct ImageSelection_Previews: PreviewProvider {
    static var previews: some View {
        ImageSelectn()
    }
}
