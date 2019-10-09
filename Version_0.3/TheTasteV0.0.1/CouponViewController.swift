//  Created by Danyal Cetin on 13/05/19.
//  Copyright © 2019 The AR Taste Team. All rights reserved.
//
import UIKit

class CouponViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let list = ["AxpEn0F: Free Noodles", "DsX83Ei: 50% off", "88HtL8l: 25% of Rice:", "2FoP011: Free Rice"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return(list.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = list[indexPath.row]
        cell.textLabel?.textColor = UIColor(displayP3Red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
