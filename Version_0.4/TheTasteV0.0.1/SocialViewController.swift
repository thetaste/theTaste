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
    
    var imageArr = [UIImage(named: "img1"),
                    UIImage(named: "img2"),
                    UIImage(named: "img3"),
                    UIImage(named: "img4"),
                    UIImage(named: "img5"),
                    UIImage(named: "img6"),
                    UIImage(named: "img7")]

    var timer = Timer()
    var time = 0;
    var currentIndex = 0
    var index = IndexPath.init(item: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginbutton = FBLoginButton()
//        view.addSubview(loginbutton)
        //adjust the frame size of the login button
        loginbutton.frame = CGRect(x: 61, y : 620, width: view.frame.width - 123, height: 35)
        
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector:
                #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func websiteButton(_ sender: Any) {
        if let url = URL(string: "https://www.thetaste.co.nz/") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func instagranBtn(_ sender: Any) {
        let isFB:Bool = UIApplication.shared.canOpenURL(URL.init(string: "instagram://app")!);
        if isFB {
            UIApplication.shared.open(URL.init(string: "instagram://user?username=thetastenz")!) { (isB) in
                if isB {
                    NSLog("111")
                }else{
                    NSLog("222")
                }
            }
        }else{
            UIApplication.shared.open(URL.init(string: "https://www.instagram.com/thetastenz/")!) { (isB) in
                if isB {
                    NSLog("111")
                }else{
                    NSLog("222")
                }
            }
        }
    }
    @IBAction func faceBookBtn(_ sender: Any) {
        let isFB:Bool = UIApplication.shared.canOpenURL(URL.init(string: "fb://")!);
        if isFB {
            UIApplication.shared.open(URL.init(string: "fb://profile/266840743487579")!) { (isB) in
                if isB {
                    NSLog("111")
                }else{
                    NSLog("222")
                }
            }
        }else{
            UIApplication.shared.open(URL.init(string: "https://www.facebook.com/thetastenz/")!) { (isB) in
                if isB {
                    NSLog("111")
                }else{
                    NSLog("222")
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func changeImage() {

        currentIndex = sliderCollectionView.indexPathForItem(at: CGPoint.init(x: CGRect.init(origin: sliderCollectionView.contentOffset, size: sliderCollectionView.bounds.size).midX, y: CGRect.init(origin: sliderCollectionView.contentOffset, size: sliderCollectionView.bounds.size).midY))?.item ?? 0
        
        if currentIndex == index.item{
            
            currentIndex += 1
            
            if currentIndex < imageArr.count {
                index = IndexPath.init(item: currentIndex, section: 0)
                self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            } else {
                currentIndex = 0
                index = IndexPath.init(item: currentIndex, section: 0)
                self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            }
        } else {
            index = [0, currentIndex]
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
    

