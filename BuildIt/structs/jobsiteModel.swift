//
//  jobsiteModel.swift
//  BuildIt
//
//  Created by James B. on 11/8/20.
//used to delegate to jobsite view controller

import UIKit
protocol jobsiteModelDelegate {
    func itemsDownloaded(jobsite:[jobsite])
}
class jobsiteModel: NSObject {
    var delegate:jobsiteModelDelegate?
    func getItems(){
        let serviceUrl = "http://192.168.1.122/capstone/cap3.php"
        let url = URL(string: serviceUrl)
        if let url = url{
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with:url, completionHandler:
                                            {(data, response, error) in
                                                if error == nil{
                                                    self.parseJson(data:data!)
                                                }else{
                                                    
                                                }
                                            })
            task.resume()
        }
    }
    func parseJson(data:Data){
        var jobsites = [jobsite]()
        do{
            //parse data in to a json object
        let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as![Any]
            //loop through each result
        for jsonResult in jsonArray{
            
            let jsonDict = jsonResult as! [String:String]
            //create new employee and give it attributes
            let addy = jsonDict["address"]!
            let comp = jsonDict["completion"]!
            let pic = jsonDict["picture"]!
            let job = jobsite(address: addy, completion: comp, picture: pic)
            jobsites.append(job)
            }
            
            delegate?.itemsDownloaded(jobsite: jobsites)
        }catch{
            print("error")
        }
    }
}
