//
//  SocialViewController.swift
//  TheTasteV0.0.1
//
//  Created by Danyal Cetin on 14/08/19.
//  Copyright © 2019 ARTheTaste. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Social

class SocialViewController: UIViewController {
    
    @IBAction func buttonAction(_ sender: Any) {
        //alert
        //let alert = UIAlertController(title: "share", message: "Share the video", preferredStyle: .actionSheet)
        //self.accessibilityFrame = CGRect(x: 61, y: 670, width: view.frame.width - 123, height: 35)
        //fisrt action
       // let actionOne = UIAlertAction(title: "Share on Facebook", style: .default ){(action) in
            
       //     if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook)
          //  {
       //         post?.setInitialText("Video of the food")
         //   }
      //  }
        
        //add action to action sheet
       // alert.addAction(actionOne)
        
        //present alert
      //  self.present(alert, animated: true, completion: nil)
                let controller = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        controller?.completionHandler = { result in
            switch result {
            case .cancelled:
                print("Post Failed")
                var alert: UIAlertController?
                alert = UIAlertController(title: "Failed!!", message: "Something went wrong while sharing on Facebook, Please try again later.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Okay", style: .default, handler: { action in
                })
                alert?.addAction(defaultAction)
                DispatchQueue.main.async(execute: {
                    if let alert = alert {
                        self.present(alert, animated: true)
                    }
                })
            case .done:
                print("Post Sucessful")
                var alert: UIAlertController?
                alert = UIAlertController(title: "Success", message: "Your post has been successfully shared.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Okay", style: .default, handler: { action in
                })
                alert?.addAction(defaultAction)
                DispatchQueue.main.async(execute: {
                    if let alert = alert {
                        self.present(alert, animated: true)
                    }
                })
            default:
                break
            }
        }
        self.present(controller!, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!
    
    var imageArr = [UIImage(named: "img1"),
                    UIImage(named: "img2"),
                    UIImage(named: "img3"),
                    UIImage(named: "img4"),
                    UIImage(named: "img5"),
                    UIImage(named: "img6"),
                   UIImage(named: "img7")]
    
    var timer = Timer()
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginbutton = FBLoginButton()
        view.addSubview(loginbutton)
        //adjust the frame size of the login button
        loginbutton.frame = CGRect(x: 61, y : 620, width: view.frame.width - 123, height: 35)
        
        pageView.numberOfPages = imageArr.count
        pageView.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func websiteButton(_ sender: Any) {
        if let url = URL(string: "https://www.thetaste.co.nz/") {
            UIApplication.shared.open(url)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func changeImage() {
        
        if counter < imageArr.count {
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
        return imageArr.count
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
    

