/**
 Copyright (c) 2016 Razeware LLC
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    UINavigationBar.appearance().tintColor = UIColor.white
    return true
  }
    
    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        
        // 1
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
            let url = userActivity.webpageURL,
            let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                return false
        }
        
        // 2
        if let computer = ItemHandler.sharedInstance.items.filter({ $0.path == components.path}).first {
            self.presentDetailViewController(computer)
            return true
        }
        
        // 3
        let webpageUrl = URL(string: "https://demo-universal-link.herokuapp.com/")!
        application.openURL(webpageUrl)
        
        return false
    }
    
    

    func presentDetailViewController(_ computer: Computer) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let navigationVC = storyboard.instantiateViewController(withIdentifier: "NavigationController")
            as! UINavigationController
        navigationVC.modalPresentationStyle = .formSheet
        
        let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailController")
            as! ComputerDetailController
        detailVC.item = computer
        
        navigationVC.pushViewController(detailVC, animated: true)
        
        window?.rootViewController = navigationVC;
    }
  
}
