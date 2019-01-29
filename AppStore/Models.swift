//
//  Models.swift
//  AppStore
//
//  Created by SANGBONG MOON on 29/01/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit

class AppCategory: NSObject {
    @objc var name: String?
    @objc var apps: [App]?
    @objc var type: String?

    override func setValue(_ value: Any?, forKey key: String) {

        if key == "apps" {
            apps = [App]()
            for dict in value as! [[String: AnyObject]] {
                let app = App()
                app.setValuesForKeys(dict)
                apps?.append(app)
            }

        } else {
            super.setValue(value, forKey: key)
        }
    }

    static func fetchFeaturedApps(completionHandler: @escaping ([AppCategory]) -> ()) {

        let url = URL(string: "https://api.letsbuildthatapp.com/appstore/featured")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }

            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)

                    var appCategories = [AppCategory]()

                    guard
                        let jsonDic = json as? [String: AnyObject],
                        let categoriesObject = jsonDic["categories"] as? [[String: AnyObject]]
                        else {
                            print("Oh No!!")
                            return
                    }

                    for dict in categoriesObject {
                        let appCategory = AppCategory()
                        appCategory.setValuesForKeys(dict)
                        appCategories.append(appCategory)
                    }

                    DispatchQueue.main.async {
                        completionHandler(appCategories)
                    }

                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()

    }

    static func sampleAppCategories() -> [AppCategory] {
        let bestNewAppCategory = AppCategory()
        bestNewAppCategory.name = "Best New Apps"

        var apps = [App]()

        // MARK: Logic
        let circleApp = App()
        circleApp.name = "Disney Build It: Frozen"
        circleApp.category = "Entertainment"
        circleApp.imageName = "frozen"
        circleApp.price = NSNumber(floatLiteral: 3.99)
        apps.append(circleApp)

        bestNewAppCategory.apps = apps

        let bestNewGamesCategory = AppCategory()
        bestNewGamesCategory.name = "Best New Games"

        var bastNewGamesApps = [App]()

        let angularApp = App()
        angularApp.name = "Telepaint"
        angularApp.category = "Games"
        angularApp.imageName = "telepaint"
        angularApp.price = NSNumber(floatLiteral: 2.99)

        bastNewGamesApps.append(angularApp)
        bestNewGamesCategory.apps = bastNewGamesApps


        return [bestNewAppCategory, bestNewGamesCategory]
    }
}


class App: NSObject {
    @objc var id: NSNumber?
    @objc var name: String?
    @objc var category: String?
    @objc var imageName: String?
    @objc var price: NSNumber?
}
