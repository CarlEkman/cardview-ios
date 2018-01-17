//
//  Copyright © 2017 Carl Ekman. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var viewController: ViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        viewController = ViewController()
        window = UIWindow(frame: UIScreen.main.bounds)

        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }
}
