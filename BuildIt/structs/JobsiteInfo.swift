//
//  JobsiteInfo.swift
//  BuildIt
//
//  Created by James B. on 11/11/20.
//

import UIKit

protocol JobsiteInfoDelegate{
    func itemsDownloaded(myTasks:[myTasks])
}
class JobsiteInfo: NSObject {
    var delegate:JobsiteInfoDelegate?
    func getItems(site: String){
        let serviceUrl = "http://builditios.com/cap2.php"
        let url = URL(string: serviceUrl)
        if let url = url{
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with:url, completionHandler:
                                            {(data, response, error) in
                                                if error == nil{
                                                    self.parseJson(data:data!, sites:site)
                                                }else{
                                                    
                                                }
                                            })
            task.resume()
        }
    }
    func parseJson(data:Data, sites: String){
        var taskArray = [myTasks]()
        var firsts = [String]()
        var lasts = [String]()
        var flag = false
        do{
            //parse data in to a json object
        let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as![Any]
            //loop through each result
        for jsonResult in jsonArray{
            
            flag = false
            let jsonDict = jsonResult as! [String:String]
            let site = jsonDict["Jobsite"]!
            let first = jsonDict["FirstName"]!
            let last = jsonDict["LastName"]!
            if(firsts.isEmpty){
                firsts.append(first)
                lasts.append(last)
            }else{
                var i = 0
                while(i<firsts.count){
                    if(firsts[i] == first && lasts[i] == last){
                        flag = true
                        break
                    }else{
                        i+=1
                    }
                }
                firsts.append(first)
                lasts.append(last)
            }
            
            if(sites == site && flag == false){
                let tasks = myTasks(number: jsonDict["Number"]!, details: jsonDict["Details"]!, jobsite: site, firstName: first, lastName: last)
                taskArray.append(tasks)
            }
            }
            
            delegate?.itemsDownloaded(myTasks: taskArray)
        }catch{
            print("error")
        }
    }}
