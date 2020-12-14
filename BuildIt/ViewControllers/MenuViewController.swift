//
//  MenuViewController.swift
//  BuildIt
//
//  Created by James B. on 10/28/20.
//

import UIKit

class MenuViewController: UIViewController {

    var firstName = ""
    var lastName = ""
    var admin = ""
    var task = false
    var employ = false
    var job = false
    var addE = false
    var createT = false
    var logout = false
    
    @IBAction func logoutButton(_ sender: Any) {
        logout = true
    }
    @IBOutlet weak var addEmploybutt: UIButton!
    @IBOutlet weak var createTaskButt: UIButton!
    
    @IBAction func addEmployButton(_ sender: Any) {
        addE = true
    }
    @IBAction func createTaskButton(_ sender: Any) {
        createT = true
    }
    @IBOutlet weak var buildItLabl: UILabel!
    
    @IBOutlet weak var buttonStack: UIStackView!
    @IBAction func myTasksButton(_ sender: Any) {
        task = true
    }
    @IBAction func jobsitesButton(_ sender: Any) {
        job = true
    }
    @IBAction func employeesButton(_ sender: Any) {
        employ = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        // Do any additional setup after loading the view.
    }
    func setUp(){
        if(admin == "1"){
            addEmploybutt.isHidden = false
            createTaskButt.isHidden = false
        }else{
            addEmploybutt.isHidden = true
            createTaskButt.isHidden = true
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(task){
            let vc = segue.destination as! MyTasksViewController
            vc.firstName = self.firstName
            vc.lastName = self.lastName
            vc.admin = self.admin
            view.window?.rootViewController = vc
        }
        else if(employ){
            let vc = segue.destination as! EmployeesViewController
            vc.firstName = self.firstName
            vc.lastName = self.lastName
            vc.admin = self.admin
            view.window?.rootViewController = vc
            
        }else if(job){
            let vc = segue.destination as! JobsitesViewController
            vc.firstName = self.firstName
            vc.lastName = self.lastName
            vc.admin = self.admin
            view.window?.rootViewController = vc
            
        }else if(addE){
            let vc = segue.destination as! AddEmployeeViewController
            vc.firstName = self.firstName
            vc.lastName = self.lastName
            vc.admin = self.admin
            view.window?.rootViewController = vc
            
        }else if(createT){
            let vc = segue.destination as! CreateTaskViewController
            vc.firstName = self.firstName
            vc.lastName = self.lastName
            vc.admin = self.admin
            view.window?.rootViewController = vc
           
        } else if(logout){
            let vc = segue.destination as! LoginViewController
            view.window?.rootViewController = vc
        }         }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
