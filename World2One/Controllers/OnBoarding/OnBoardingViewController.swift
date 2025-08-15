//
//  OnBoardingViewController.swift
//  World2one
//
//  Created by Moin on 01/02/2025.
//

import UIKit

class OnBoardingViewController: UIViewController {

    @IBOutlet weak var collectV: UICollectionView!

    var dotImages = ["onBoardSlider1", "onBoardSlider2", "onBoardSlider3","onBoardSlider4","onBoardSlider5","onBoardSlider6"]
    var mainImages = ["onBoard1", "onBoard2", "onBoard3","onBoard4","onBoard5","onBoard6"]
    var textImages = ["text1", "text2", "text3","text4","text5","text6"]
  
 
    
    var selectedIndex = 0
    var iscome = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let layout = collectV.collectionViewLayout as? UICollectionViewFlowLayout {
                    layout.scrollDirection = .horizontal
                    layout.minimumLineSpacing = 0
                    layout.minimumInteritemSpacing = 0
                }
        collectV.isPagingEnabled = true
        collectV.showsHorizontalScrollIndicator = false

    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}

extension OnBoardingViewController: UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnBoardCollectionViewCell", for: indexPath) as! OnBoardCollectionViewCell
        
        cell.dotImage.image = UIImage(named: dotImages[selectedIndex])
        cell.mainImage.image = UIImage(named: mainImages[selectedIndex])
        cell.mainImage.contentMode = .scaleAspectFit
        cell.textImage.image = UIImage(named: textImages[selectedIndex])
        
        cell.skipBtn.addTarget(self, action: #selector(skipbtn), for: .touchUpInside)
        cell.nextBtn.addTarget(self, action: #selector(nextbtn), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        
    }
    
    @objc func skipbtn(sender: UIButton) {
        let vc = HomeViewController.getVC(.home)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func nextbtn(sender: UIButton) {
        if selectedIndex == 5 {
            if iscome == "home" {
                navigationController?.popViewController(animated: true)
            }else{
                let vc = HomeViewController.getVC(.home)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else {
            selectedIndex += 1
             collectV.reloadData()
        }
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        // Determine the scroll direction
//        let scrollDirection = scrollView.contentOffset.x > lastContentOffset ? "right" : "left"
//        lastContentOffset = scrollView.contentOffset.x
//        
//        // Get the center point of the visible area of the collection view
//        let visibleRect = CGRect(origin: collectV.contentOffset, size: collectV.bounds.size)
//        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
//        
//        // Get the index path of the item at the visible point
//        if let indexPath = collectV.indexPathForItem(at: visiblePoint) {
//            currentIndex = indexPath.item
//            print("Current Index: \(currentIndex)")
//            
//            if let cell = collectV.cellForItem(at: indexPath) as? OnBoardCollectionViewCell {
//
//            // Update UI elements based on the current index
//            if currentIndex >= 0 && currentIndex < labels.count {
//                cell.dotImage.image = UIImage(named: dotImages[currentIndex])
////                onBoardTitles.text = labels[currentIndex]
////                onBoardSubTitles.text = descriptions[currentIndex]
////                OnBaordImages.image = UIImage(named: pdfImages[currentIndex])
//            }
//            
//                // Example: change background color of the cell
//                if currentIndex == 0 {
////                    cell.shipview.isHidden = false
//                } else if currentIndex == 1 {
////                    cell.shipview.isHidden = false
//                } else {
////                    cell.shipview.isHidden = true
//                }
//            }
//        }
//        
//        // Check if the user is scrolling right past the last item
//        if currentIndex == labels.count - 1 && scrollDirection == "right" && scrollView.contentOffset.x > lastContentOffset {
//            print("Hello")
//        }
//    }
    
}
