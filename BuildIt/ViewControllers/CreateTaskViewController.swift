//
//  CreateTaskViewController.swift
//  BuildIt
//
//  Created by James B. on 12/1/20.
//

import UIKit

class CreateTaskViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var jobsiteLabel: UILabel!
    @IBOutlet weak var jobsiteText: UITextField!
    @IBOutlet weak var detailsLabel: UILabel!
    
    @IBOutlet weak var detailsText: UITextView!
    var firstName = ""
    var lastName = ""
    var admin = ""
    @IBAction func submitButton(_ sender: Any) {
        upload()
    }
    @IBAction func menuButton(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //detailsText.text = "type here..."
        detailsText.layer.borderWidth = 1
        detailsText.layer.borderColor = UIColor.lightGray.cgColor
        detailsText.textContainer.maximumNumberOfLines = 7
        detailsText.textContainer.lineBreakMode = .byTruncatingTail
        // Do any additional setup after loading the view.
    }
    func upload(){
        let url = NSURL(string: "http://192.168.1.122/capstone/createTask.php")
        var request = URLRequest(url: url! as URL)
        request.httpMethod = "POST"
        var dataString = "fn=\(firstNameText.text!)"
        dataString = dataString + "&ln=\(lastNameText.text!)"
        dataString = dataString + "&job=\(jobsiteText.text!)"
        dataString = dataString + "&detail=\(detailsText.text!)"
        
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
        detailsText.text = ""
        jobsiteText.text = ""
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
            let vc = segue.destination as! MenuViewController
            vc.firstName = self.firstName
            vc.lastName = self.lastName
            vc.admin = self.admin
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
