//
//  DetailsViewController.swift
//  instagram
//
//  Created by Francisco Hernanedez on 10/2/18.
//  Copyright © 2018 Francisco Hernanedz. All rights reserved.
//

import UIKit
import Parse

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var PostImage: UIImageView!
    
    @IBOutlet weak var DateLabel: UILabel!
    
    @IBOutlet weak var CaptionLabel: UILabel!
    
    var post : PFObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let post = post{
            
            self.CaptionLabel.text = post["caption"] as? String
            //            DateLabel.text = post["createAt"]
            let date = post.createdAt! as Date
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "EEE, MMM d, h:mm a"
            DateLabel.text = NSString(format: "%@", dateFormat.string(from: date)) as String
            
            let imageFile = post["media"] as? PFFile
            
            if let imageFile : PFFile = imageFile {
                imageFile.getDataInBackground(block: { (data, error) in
                    if error == nil {
                        DispatchQueue.main.async {
                            // Async main thread
                            let image = UIImage(data: data!)
                            self.PostImage.image = image
                            
                        }
                        
                    } else {
                        print(error!.localizedDescription)
                        
                    }
                    
                })
            }
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
