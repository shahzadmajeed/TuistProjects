import Foundation
import Combine
import WorkbenchKit
import Networking
import UIKit
import SnapKit
import MenuWidget
import WebBrowserKit
import Components
import Styles

public final class WorkbenchUI {
    
    public init() {}
    
    var bag: Set<AnyCancellable> = []
    
    public lazy var navigationController: UINavigationController = {
        UINavigationController(rootViewController: menuViewController)
    }()
    
    lazy var menuViewController: MenuViewController = {
        menu()
    }()
    
    lazy var browser: MenuItem = {
        MenuItem(title: "Browser") {
            let browser = WebViewController()
            self.navigationController.pushViewController(browser, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
                browser.load(URL(string: "https://tuist.io")!)
            }
        }
    }()
    
    lazy var imageDownload: MenuItem = {
        MenuItem(title: "Image Downloader") {
            self.loadImageView("https://source.unsplash.com/user/c_v_r/480x960")
                .sink { imageView in
                    self.navigationController.pushViewController(
                        imageView.embeddedInViewController,
                        animated: true
                    )
                }.store(in: &self.bag)
        }
    }()
    
    lazy var customView: MenuItem = {
        MenuItem(title: "Custom View") {
            self.navigationController.pushViewController(
                CustomView(color: Styles.Colors.orange).embeddedInViewController,
                animated: true
            )
        }
    }()
    
    func menu() -> MenuViewController {
        MenuViewController([browser, imageDownload, customView])
    }

    public func loadImageView(_ url: String) -> AnyPublisher<UIView, Never> {
        
        /// TODO: Use .map on original Publisher instead
        Future<UIView, Never> { promise in
            var bag: [AnyCancellable] = []
            ImageDownloader()
                .downloadImage(url: .init(string: url)!)
                .sink { image in
                    // Temp ref to create retain cycle
                    print(bag)
                    let imageView = UIImageView(image: image)
                    imageView.contentMode = .scaleAspectFit
                    promise(.success(imageView))
                    bag.removeAll()
                }
                .store(in: &bag)
        }.eraseToAnyPublisher()
    }
}
