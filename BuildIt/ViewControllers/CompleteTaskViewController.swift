//
//  completeTaskViewController.swift
//  BuildIt
//
//  Created by James B. on 11/4/20.
//

import UIKit

class CompleteTaskViewController: UIViewController {
    var id = ""
    var firstName = ""
    var lastName = ""
    var admin = ""
    var specificTask = 0
    var answer = false
    @IBOutlet weak var popupStack: UIStackView!
    @IBOutlet weak var question: UILabel!
    @IBAction func completeButton(_ sender: Any) {
        answer = true
        upload(number:id)
        performSegue(withIdentifier: "endOfPopup", sender: self)
    }
    @IBAction func cancelButton(_ sender: Any) {
        answer = false
        performSegue(withIdentifier: "endOfPopup", sender: self)    }
    
    func upload(number:String){
        let url = NSURL(string: "http://192.168.1.122/capstone/completeTask.php")
        var request = URLRequest(url: url! as URL)
        request.httpMethod = "POST"
        let dataString = "taskid=\(id)"
        let deleteData = dataString.data(using: .utf8)!
        do{
            let uploadTask = URLSession.shared.uploadTask(with: request, from: deleteData){
                data,response,error in
                if error != nil{
                    print("error")
                }
            }
            uploadTask.resume()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let vc = segue.destination as! MyTasksViewController
        vc.firstName = self.firstName
        vc.lastName = self.lastName
        vc.admin = self.admin
        vc.specificTask = self.specificTask
        vc.answer = self.answer
        view.window?.rootViewController = vc
    }
    
        
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
