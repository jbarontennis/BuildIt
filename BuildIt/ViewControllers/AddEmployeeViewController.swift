//
//  AddEmployeeViewController.swift
//  BuildIt
//
//  Created by James B. on 11/28/20.
//

import UIKit

class AddEmployeeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    
    @IBOutlet weak var firstNameText: UITextField!
    
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var adminLabel: UILabel!
    @IBAction func adminSwitch(_ sender: Any) {
        adm = "1"
    }
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    @IBOutlet weak var phoneNumberText: UITextField!
    @IBAction func submitButton(_ sender: Any) {
        upload()
        
    }
    @IBAction func menuButton(_ sender: Any) {
       
    }
    
    var adm = "0"
    var firstName = ""
    var lastName = ""
    var admin = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    func upload(){
        let url = NSURL(string: "http://192.168.1.122/capstone/addEmploy.php")
        var request = URLRequest(url: url! as URL)
        request.httpMethod = "POST"
        var dataString = "fn=\(firstNameText.text!)"
        dataString = dataString + "&ln=\(lastNameText.text!)"
        dataString = dataString + "&un=\(userNameText.text!)"
        dataString = dataString + "&pw=\(passwordText.text!)"
        dataString = dataString + "&admin=\(adm)"
        dataString = dataString + "&pn=\(phoneNumberText.text!)"
        //request.httpBody = dataString.data(using: .utf8)
        let uploadData = dataString.data(using: .utf8)!
        do{
            let uploadD = URLSession.shared.uploadTask(with: request, from: uploadData){
            //let uploadD = URLSession.shared.dataTask(with: request){
                data,response,error in
                if error != nil{
                    print("error")
                }
            }
            uploadD.resume()
        }
        firstNameText.text = ""
        lastNameText.text = ""
        userNameText.text = ""
        passwordText.text = ""
        phoneNumberText.text = ""
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
            let vc = segue.destination as! MenuViewController
            vc.firstName = self.firstName
            vc.lastName = self.lastName
            vc.admin = self.admin
    }
    func textLimit(existingText: String?, newText: String, limit:Int)->Bool{
        let text = existingText ?? ""
        let isAtLimit = text.count + newText.count<=limit
        return isAtLimit
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return self.textLimit(existingText: textField.text, newText: string, limit: 10)
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
