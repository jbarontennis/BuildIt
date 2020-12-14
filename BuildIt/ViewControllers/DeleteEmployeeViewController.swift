//
//  deleteEmployeeViewController.swift
//  BuildIt
//
//  Created by James B. on 12/14/20.
//

import UIKit

class deleteEmployeeViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBAction func deleteButton(_ sender: Any) {
        upload()
            }
    @IBAction func cancelButton(_ sender: Any) {
        
    }
    var firstName = ""
    var lastName = ""
    var admin = ""
    var employf = ""
    var emplol = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Do you want to delete " + employf + " " + emplol + "?"
        // Do any additional setup after loading the view.
    }
    func upload(){
        let url = NSURL(string: "http://192.168.1.122/capstone/deleteEmploy.php")
        var request = URLRequest(url: url! as URL)
        request.httpMethod = "POST"
        let dataString = "firstname=\(employf)&lastname=\(emplol)"
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let vc = segue.destination as! EmployeesViewController
        vc.firstName = self.firstName
        vc.lastName = self.lastName
        vc.admin = self.admin
        view.window?.rootViewController = vc        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


