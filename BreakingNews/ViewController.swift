//
//  ViewController.swift
//  BreakingNews
//
//  Created by Mayank Yadav on 19/07/22.
//

import UIKit
import Alamofire
import SDWebImage
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var titleArray = [String]()
    var SourceArray = [String]()
    var imgURLArray = [String]()
    var urlArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myTableView)
//        self.myTableView.register(MyTableViewCell.self, forCellReuseIdentifier: MyTableViewCell.identifier)
        self.myTableView.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: "MyTableViewCell")
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
        
        self.myTableView.reloadData()
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myTableView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getNewsData { (success) in
            if success {
                print("success")
                
                self.myTableView.reloadData()
                print(self.imgURLArray.count)
            } else {
                print("doesnt work ")
            }
        }
        
    }
        
}

    


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return imgURLArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myTableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as? MyTableViewCell else { return UITableViewCell() }
        
       
       
            
            cell.imgView.sd_setImage(with: URL(string: imgURLArray[indexPath.row])) { (image, error, cache, urls) in
                cell.imgView.image = UIImage(named: "news placeholder")
            }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow
        
        let urls = urlArray[(indexPath?.row)!]
    
        UIApplication.shared.open( URL(string: urls)!, options: [:] ) { (success) in
            if success {
                print("open link")
            }
        }
        
        
    }
    
}

extension ViewController {
    
    func getNewsData(complete: @escaping (_ status: Bool) -> ()) {
        
        AF.request("https://newsapi.org/v2/top-headlines?country=in&category=general&apiKey=9cac620892ac4795b866a09224cd4f5f", method: .get).responseJSON { (response) in
            switch response.result {
                
            case .success(_):
                print(response.result)
                let myresult = try? JSON(data: response.data!)
                
                let value = response.result
             
                 let json = JSON(value)
                for item in json["articles"].arrayValue {
                    
                
                    self.titleArray.append(item["title"].stringValue)
                    self.SourceArray.append(item["source"]["name"].stringValue)
                    self.imgURLArray.append(item["urlToImage"].stringValue)
                    self.urlArray.append(item["url"].stringValue)
                
                }
//                print(myresult)
                break
            case .failure(_):
                print(response.error!)
                break
            }

        
        }
    
    }
    
    
}

