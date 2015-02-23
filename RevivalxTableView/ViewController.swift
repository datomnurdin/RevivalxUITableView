//
//  ViewController.swift
//  RevivalxTableView
//
//  Created by Mohammad Nurdin bin Norazan on 2/23/15.
//  Copyright (c) 2015 Nurdin Norazan Services. All rights reserved.
//

import UIKit
import Alamofire
import Haneke

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var datas: [JSON] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Alamofire.request(.GET, "https://api.instagram.com/v1/tags/malaysia/media/recent?client_id=54fd054e9de54e9fb954fb3a070ddca2").responseJSON { (request, response, json, error) in
            if json != nil {
                var jsonObj = JSON(json!)
                if let data = jsonObj["data"].arrayValue as [JSON]?{
                    self.datas = data
                    self.tableView.reloadData()
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return datas.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ImageCell", forIndexPath: indexPath) as UITableViewCell //1
        let data = datas[indexPath.row]
        if let captionLabel = cell.viewWithTag(100) as? UILabel {
            if let caption = data["caption"]["text"].string{
                captionLabel.text = caption
            }
        }
        if let imageView = cell.viewWithTag(101) as? UIImageView {
            if let urlString = data["images"]["standard_resolution"]["url"].string{
                let url = NSURL(string: urlString)
                imageView.hnk_setImageFromURL(url!)
            }
        }
        return cell
    }

}

