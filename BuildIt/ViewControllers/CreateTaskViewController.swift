//
//  CreateTaskViewController.swift
//  BuildIt
//
//  Created by James B. on 12/1/20.
//

import UIKit

class CreateTaskViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, HomeModelDelegate, jobsiteModelDelegate{
    //jobsites are delegated here
    func itemsDownloaded(jobsite: [jobsite]) {
        jobsitesArray = jobsite
    }
    

    @IBOutlet weak var jobErrorLabel: UILabel!
    @IBOutlet weak var lnErrorLabel: UILabel!
    @IBOutlet weak var fnErrorLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
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
    var jobModel = jobsiteModel()
    var jobsitesArray = [jobsite]()
    @IBAction func submitButton(_ sender: Any) {
        fnErrorLabel.alpha = 0
        lnErrorLabel.alpha = 0
        jobErrorLabel.alpha = 0
        errorLabel.alpha = 0
        if(firstNameText.text == ""||lastNameText.text == ""||detailsText.text == ""){
            fillIn()
        }else if(!checkForCorrectFName()){
            fnErrorLabel.alpha = 1
            
        }else if(!checkForCorrectLName()){
            lnErrorLabel.alpha = 1
        }else if(!jobsiteSpellCheck()){
            jobErrorLabel.alpha = 1
        }else{
           upload()
        }
    }
    //checks is jobsite is valid
    func jobsiteSpellCheck()->Bool{
        var flag = false
        if(jobsiteText.text != ""){
        for jobsite in jobsitesArray{
            if(jobsiteText.text == jobsite.address ){
                flag = true
                return flag
            }
        }
        return flag
        }
        flag = true
        return flag
    }
    //checks firstName validity
    func checkForCorrectFName()->Bool{
        var flag = false
        for employee in employeesArray{
            if(firstNameText.text == employee.firstName ){
                flag = true
                return flag
            }
        }
        return flag
    }
    //checks lastName validity
    func checkForCorrectLName()->Bool{
        var flag = false
        for employee in employeesArray{
            if(lastNameText.text == employee.lastName ){
                flag = true
                return flag
            }
        }
        return flag
    }
    //displays error label if not all blanks are filled in
    func fillIn(){
        errorLabel.alpha = 1
    }
    @IBAction func menuButton(_ sender: Any) {
        
    }
    var employeesArray = [employees]()
    var homeModel = HomeModel()
    //employees are delegated here
    func itemsDownloaded(employees: [employees]) {
        employeesArray = employees
        
    }
    //set up
    override func viewDidLoad() {
        super.viewDidLoad()
        //detailsText.text = "type here..."
        detailsText.layer.borderWidth = 1
        detailsText.layer.borderColor = UIColor.lightGray.cgColor
        //detailsText.textContainer.maximumNumberOfLines = 7
        //detailsText.textContainer.lineBreakMode = .byTruncatingTail
        homeModel.getItems()
        homeModel.delegate = self
        jobModel.getItems()
        jobModel.delegate = self
        firstNameText.delegate = self
        lastNameText.delegate = self
        jobsiteText.delegate = self
        detailsText.delegate = self
        errorLabel.alpha = 0
        fnErrorLabel.alpha = 0
        lnErrorLabel.alpha = 0
        jobErrorLabel.alpha = 0
        // Do any additional setup after loading the view.
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
        toolBar.setItems([doneButton], animated: false)
        
        
        firstNameText.inputAccessoryView = toolBar
        lastNameText.inputAccessoryView = toolBar
        jobsiteText.inputAccessoryView = toolBar
        detailsText.inputAccessoryView = toolBar
    }
    //done button for keyboard
    @objc func doneClicked(){
        view.endEditing(true)
    }
    //sends data to php script
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
        errorLabel.alpha = 0
    }
    //character limit for text fields
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let max:Int
        if(textField == jobsiteText){
            max = 30
        }else{
            max = 10
        }
        
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= max
        
    }
    //character limit for text view
    private func textView(_ textView: UITextField, shouldChangeTextIn range: NSRange, replacementtext text: String) -> Bool {
        let max = 20
        let currentText = textView.text! as NSString
        let changedText = currentText.replacingCharacters(in: range, with: text)
        return changedText.count <= max
        
    }
    //sends variables to next view controller
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
