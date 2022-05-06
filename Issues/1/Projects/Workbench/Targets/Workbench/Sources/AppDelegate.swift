import UIKit
import WorkbenchKit
import WorkbenchUI
import Combine

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let ui = WorkbenchUI()
    let kit = WorkbenchKit()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
    
        window?.rootViewController = ui.navigationController
        window?.makeKeyAndVisible()
        
        kit.fetchMovies()
        
        return true
    }
}

