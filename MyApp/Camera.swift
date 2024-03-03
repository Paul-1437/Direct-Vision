import SwiftUI

struct SysCameraView: View {
    @State private var isImagePickerPresented = false
    
    var body: some View {
        Button("System Image Recognition Camera") {
            isImagePickerPresented.toggle()
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePickerView(sourceType: .camera)
        }
    }
}

struct ImagePickerView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController
    
    var sourceType: UIImagePickerController.SourceType
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.cameraCaptureMode = .photo
        return imagePickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Update any settings here if needed
    }
}

struct Camera_Previews: PreviewProvider {
    static var previews: some View {
        SysCameraView()
    }
}
