//
//  HomeModel.swift
//  BuildIt
//
//  Created by James B. on 10/18/20.
//

import UIKit

protocol HomeModelDelegate{
    func itemsDownloaded(employees:[employees])
}
class HomeModel: NSObject {
    
    var delegate:HomeModelDelegate?
    func getItems(){
        let serviceUrl = "http://192.168.1.122/capstone/cap.php"
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
        var employArray = [employees]()
        do{
            //parse data in to a json object
        let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as![Any]
            //loop through each result
        for jsonResult in jsonArray{
            
            let jsonDict = jsonResult as! [String:String]
            //create new employee and give it attributes
            let employ = employees(firstName: jsonDict["firstName"]!, lastName: jsonDict["lastName"]!, userName: jsonDict["userName"]!, pass: jsonDict["password"]!, admin: jsonDict["admin"]!, phoneNumber: jsonDict["phoneNumber"]!)
                employArray.append(employ)
            }
            
            delegate?.itemsDownloaded(employees: employArray)
        }catch{
            print("error")
        }
    }}
