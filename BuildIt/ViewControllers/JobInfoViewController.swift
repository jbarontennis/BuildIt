//
//  JobInfoViewController.swift
//  BuildIt
//
//  Created by James B. on 11/10/20.
//

import UIKit

class JobInfoViewController: UIViewController, JobsiteInfoDelegate,  UITableViewDataSource, UITableViewDelegate{
    //myTasks are delegated here
    func itemsDownloaded(myTasks: [myTasks]) {
        myTask = myTasks
        DispatchQueue.main.async {
            self.jobTable.reloadData()
        }       }
    
    
    var label = ""
    
    var myTask = [myTasks]()
    var jobsite = JobsiteInfo()
    //number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTask.count
    }
    
    //set up each cell for table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "aCell", for: indexPath)
        let output = myTask[indexPath.row].firstName + " " + myTask[indexPath.row].lastName
        cell.textLabel?.numberOfLines = 1
        cell.textLabel?.text = output
        return cell
    }
    
    
    
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var jobTable: UITableView!
    //set up
    override func viewDidLoad() {
        super.viewDidLoad()
        jobTable.delegate = self
        jobTable.dataSource = self
        // Do any additional setup after loading the view.
        jobsite.getItems(site: label)
        jobsite.delegate = self
        addressLabel.text = label
        
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
