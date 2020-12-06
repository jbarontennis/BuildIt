//
//  MyTasksViewController.swift
//  BuildIt
//
//  Created by James B. on 10/15/20.
//

import UIKit

class MyTasksViewController: UIViewController, TaskModelDelegate, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var myTaskTable: UITableView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var lNameLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    
    var number = ""
    var firstName = ""
    var lastName = ""
    var admin = ""
    var task = [myTasks]()
    let tasksModel = taskModel()
    var specificTask = 0
    var answer = false
    var popup = false
    func itemsDownloaded(myTasks: [myTasks]) {
        task = myTasks
        DispatchQueue.main.async {
          self.myTaskTable.reloadData()
    }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tmp = task.count
        return tmp
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
            let output = "To do: " + task[indexPath.row].details + " \n Address: " + task[indexPath.row].jobsite
            cell.textLabel?.numberOfLines = 3
            cell.textLabel?.text = output
        cell.accessoryType = .detailDisclosureButton
        
        
         return cell
    }
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath){
        specificTask = indexPath.row
        popup = true
        number = task[indexPath.row].number
        performSegue(withIdentifier: "taskCompletePopup", sender: self)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTaskTable.delegate = self
        myTaskTable.dataSource = self
              // Do any additional setup after loading the view.
        //while(firstName == "" && lastName == "")
        tasksModel.getItems(f:firstName, l:lastName)
        tasksModel.delegate = self
        menuButton.contentMode = .scaleAspectFit
        
       
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if(!popup){
            let vc = segue.destination as! MenuViewController
            vc.firstName = self.firstName
            vc.lastName = self.lastName
            vc.admin = self.admin
        }else{
            popup = false
            let vc = segue.destination as! CompleteTaskViewController
                vc.firstName = self.firstName
                vc.lastName = self.lastName
                vc.admin = self.admin
                vc.id = number
                vc.specificTask = self.specificTask
        }
        
    }
    
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


