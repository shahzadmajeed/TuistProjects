#if DEBUG

import Foundation
import SwiftUI

public extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    }
    
    var preview: some View {
        Preview(viewController: self)
    }
}

public extension UIView {
    private struct Preview: UIViewRepresentable {
        let view: UIView
        
        func makeUIView(context: Context) -> some UIView {
            view
        }
        
        func updateUIView(_ uiView: UIViewType, context: Context) {}
    }
    
    var preview: some View {
        Preview(view: self)
    }
}

#endif
