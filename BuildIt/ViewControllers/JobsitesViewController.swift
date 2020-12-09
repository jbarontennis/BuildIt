//
//  JobsitesViewController.swift
//  BuildIt
//
//  Created by James B. on 10/26/20.
//

import UIKit

class JobsitesViewController: UIViewController, jobsiteModelDelegate, UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobsites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell", for: indexPath)
            let output =  "Address: " + jobsites[indexPath.row].address + "\n" + "Completion date: " + jobsites[indexPath.row].completion
        cell.textLabel?.numberOfLines = 3
        cell.textLabel?.text = output
        cell.accessoryType = .detailDisclosureButton
    
    
     return cell
    }
    
    func itemsDownloaded(jobsite: [jobsite]) {
        jobsites = jobsite
        DispatchQueue.main.async {
            self.jobTable.reloadData()
        }      }
    
    var specificTask = ""
    var popup = false
    var admin = ""
    var firstName = ""
    var lastName = ""
    var jobsites = [jobsite]()
    let jobsitesModel = jobsiteModel()
    @IBOutlet weak var jobTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        jobTable.delegate = self
        jobTable.dataSource = self
              // Do any additional setup after loading the view.
        //while(firstName == "" && lastName == "")
        jobsitesModel.getItems()
        jobsitesModel.delegate = self        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath){
        specificTask = jobsites[indexPath.row].address
        popup = true
        performSegue(withIdentifier: "jobInfoSegue", sender: self)
    }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?){
            if(popup){
                popup = false
                let vc = segue.destination as! JobInfoViewController
                vc.label = specificTask
            }else{
        let vc = segue.destination as! MenuViewController
                vc.firstName = self.firstName
                vc.lastName = self.lastName
                vc.admin = self.admin
                
            }
    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
