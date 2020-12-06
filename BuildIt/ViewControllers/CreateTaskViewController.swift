//
//  CreateTaskViewController.swift
//  BuildIt
//
//  Created by James B. on 12/1/20.
//

import UIKit

class CreateTaskViewController: UIViewController {

    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var jobsiteLabel: UILabel!
    @IBOutlet weak var jobsiteText: UITextField!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var detailsText: UITextField!
    @IBAction func submitButton(_ sender: Any) {
    }
    @IBAction func menuButton(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
