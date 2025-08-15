//
//  SplashViewController.swift
//  World2one
//
//  Created by Moin on 28/01/2025.
//

import UIKit
import SDWebImage

class SplashViewController: UIViewController {
//    @IBOutlet weak var imgGif: UIImageView!
    
    @IBOutlet weak var imgGif: SDAnimatedImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if let gifUrl = Bundle.main.url(forResource: "splash", withExtension: "gif") {
//            let gifData = try? Data(contentsOf: gifUrl)
//            let animatedImage = SDAnimatedImage(data: gifData!)
//            imgGif.image = animatedImage
//        }
//        
//        let vc = WelcomeMyWorldViewController.getVC(.main)
//        self.presentViewController(after: 4.0, from: self, to: vc)
        playGifForLimitedTime()

    }
    
    private func playGifForLimitedTime() {
           if let gifUrl = Bundle.main.url(forResource: "splash", withExtension: "gif") {
               if let gifData = try? Data(contentsOf: gifUrl) {
                   let animatedImage = SDAnimatedImage(data: gifData)
                   imgGif.image = animatedImage
                   imgGif.startAnimating()

                   DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                       self.imgGif.stopAnimating()
                   }
               }
           }

        let vc = WelcomeMyWorldViewController.getVC(.main)
        self.presentViewController(after: 3.0, from: self, to: vc)
    }
    


}
