//
//  taskModel.swift
//  BuildIt
//
//  Created by James B. on 10/26/20.
//

import UIKit

protocol TaskModelDelegate{
    func itemsDownloaded(myTasks:[myTasks])
}
class taskModel: NSObject {
    var delegate:TaskModelDelegate?
    func getItems(f: String, l: String){
        let serviceUrl = "http://192.168.1.122/capstone/cap2.php"
        let url = URL(string: serviceUrl)
        if let url = url{
            let first = f
            let last = l
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with:url, completionHandler:
                                            {(data, response, error) in
                                                if error == nil{
                                                    self.parseJson(data:data!, fi:first, la:last)
                                                }else{
                                                    
                                                }
                                            })
            task.resume()
        }
    }
    func parseJson(data:Data, fi: String, la: String){
        var taskArray = [myTasks]()
        do{
            //parse data in to a json object
        let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as![Any]
            //loop through each result
        for jsonResult in jsonArray{
            
            let jsonDict = jsonResult as! [String:String]
            let first = jsonDict["firstName"]!
            let last = jsonDict["lastName"]!
            //create new employee and give it attributes
            if(first == fi && last == la){
            let tasks = myTasks(number: jsonDict["number"]!, details: jsonDict["details"]!, jobsite: jsonDict["jobsite"]!, firstName: first, lastName: last)
                taskArray.append(tasks)
            }
            }
            
            delegate?.itemsDownloaded(myTasks: taskArray)
        }catch{
            print("error")
        }
    }}
