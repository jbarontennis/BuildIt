//
//  LoginViewController.swift
//  BuildIt
//
//  Created by James B. on 10/15/20.
//

import UIKit

class LoginViewController: UIViewController, HomeModelDelegate {
    
    @IBOutlet weak var usernamelabel: UILabel!
    @IBOutlet weak var usernametext: UITextField!
    @IBOutlet weak var passwordlabel: UILabel!
    @IBOutlet weak var passwordtext: UITextField!
    @IBOutlet weak var loginbut: UIButton!
    @IBOutlet weak var errorlabel: UILabel!
    var homeModel = HomeModel()
    
    var user = Array<String>()
    var pass = Array<String>()
    var fname = Array<String>()
    var lname = Array<String>()
    var administrator = Array<String>()
    var loc = 0
    var fName = ""
    var lName = ""
    var admin = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        // Do any additional setup after loading the view.
        homeModel.getItems()
        homeModel.delegate = self
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
        toolBar.setItems([doneButton], animated: false)
        
        
        usernametext.inputAccessoryView = toolBar
        passwordtext.inputAccessoryView = toolBar
    }
    @objc func doneClicked(){
        view.endEditing(true)
    }
    func setUpElements(){
        errorlabel.alpha = 0
    }
    func validatePass (u:String,p:String)->Bool{
        let count = user.count
        var i = 0
        while(i<count){
        if user[i] == u && pass[i] == p {
            loc = i
            fName = fname[i]
            lName = lname[i]
            admin = administrator[i]
            return true
        }
            i+=1
    }
        return false
    }
    @IBAction func loginbutton(_ sender: Any) {
        let user = usernametext.text!
        let pass = passwordtext.text!
        let access = validatePass(u: user, p: pass)
        if(access){
            performSegue(withIdentifier: "myTaskTransfer", sender: self)
           // self.transitionToMyTasks()
        }else{
            self.loginError()
        }
    }
    func itemsDownloaded(employees: [employees]) {
        
        for i in employees{
            user.append(i.userName)
            pass.append(i.pass)
            fname.append(i.firstName)
            lname.append(i.lastName)
            administrator.append(i.admin)
        }
        //print(employees)
        
    }
    func transitionToMyTasks(){
        let MyTasksVC = storyboard?.instantiateViewController(identifier: "myTasksVC") as? MyTasksViewController
        view.window?.rootViewController = MyTasksVC
        view.window?.makeKeyAndVisible()
    }
    func loginError(){
        errorlabel.alpha = 1
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let vc = segue.destination as! MyTasksViewController
        vc.firstName = self.fName
        vc.lastName = self.lName
        vc.admin = self.admin
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
