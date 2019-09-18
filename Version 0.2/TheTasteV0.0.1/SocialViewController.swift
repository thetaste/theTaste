//
//  SocialViewController.swift
//  TheTasteV0.0.1
//
//  Created by Danyal Cetin on 14/08/19.
//  Copyright © 2019 ARTheTaste. All rights reserved.
//

import UIKit

class SocialViewController: UIViewController {
    
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!
    
    let urlKeyArr = ["https://i.ibb.co/XkgQPCm/MG-0364.jpg",
                     "https://i.ibb.co/pz6pZ3S/MG-0454.jpg",
                     "https://i.ibb.co/JQ7rh5f/MG-0727.jpg",
                     "https://i.ibb.co/sRs4WqQ/MG-0818.jpg",
                     "https://i.ibb.co/Fhs0tkD/MG-0925.jpg",
                     "https://i.ibb.co/XDSnhqX/MG-0945.jpg",
                     "https://i.ibb.co/gVNCbht/MG-0969.jpg",
                     "https://i.ibb.co/xh1w5Ht/MG-1196.jpg",
                     "https://i.ibb.co/1XqLKVz/MG-2206.jpg",
                     "https://i.ibb.co/Lhqs5kK/MG-1116.jpg"]
    
    var imageArr = [UIImage]()
    
    var timer = Timer()
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageView.numberOfPages = urlKeyArr.count
        pageView.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        loadImages()
    }
    
    @IBAction func websiteButton(_ sender: Any) {
        if let url = URL(string: "https://www.thetaste.co.nz/") {
            UIApplication.shared.open(url)
        }
    }
    
    func loadImages(){
        for n in 0..<urlKeyArr.count{
            if let url = URL(string: urlKeyArr[n]){
                do{
                    let data = try Data(contentsOf: url)
                    imageArr.append(UIImage(data: data)!)
                }catch let err{
                    print("error : \(err.localizedDescription)")
                    imageArr.append(UIImage(named: "error")!)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func changeImage() {
        
        if counter < urlKeyArr.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            counter = 1
        }
    }
}

extension SocialViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urlKeyArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let vc = cell.viewWithTag(111) as? UIImageView {

            vc.image = imageArr[indexPath.row]

        }
        return cell
    }
}

extension SocialViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = sliderCollectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
    

