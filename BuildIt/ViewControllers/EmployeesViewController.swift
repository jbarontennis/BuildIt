//
//  EmployeesViewController.swift
//  BuildIt
//
//  Created by James B. on 10/18/20.
//

import UIKit

class EmployeesViewController: UIViewController, HomeModelDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var firstName = ""
    var lastName = ""
    var admin = ""
    var popup = false
    var specificEmploy = 0
    var employf = ""
    var employl = ""
    
    @IBOutlet weak var EmployeeLabel: UILabel!
    var employee = [employees]()
    var homeModel = HomeModel()
    //number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employee.count
    }
    
    //set up each cell for the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "aCell", for: indexPath)
        let temp = (employee[indexPath.row].phoneNumber) as String
        var phone = "("
        let range = temp.startIndex..<temp.index(temp.startIndex, offsetBy: 3)
        phone.append(contentsOf: temp[range] + ")")
        let range2 = temp.index(temp.startIndex, offsetBy: 3)..<temp.index(temp.startIndex, offsetBy: 6)
        phone.append(contentsOf: temp[range2] + "-")
        let range3 = temp.index(temp.startIndex, offsetBy: 6)..<temp.index(temp.startIndex, offsetBy: 10)
        phone.append(contentsOf: temp[range3])
        cell.textLabel?.text = employee[indexPath.row].firstName + " " + employee[indexPath.row].lastName  + "\n" + "Phone Number: " + phone
        cell.textLabel?.numberOfLines = 2
        if(admin == "1"){
            cell.accessoryType = .detailDisclosureButton
        }
        return cell
    }
    //add button for each row on the table
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath){
        specificEmploy = indexPath.row
        popup = true
        employf = employee[indexPath.row].firstName
        employl = employee[indexPath.row].lastName
        performSegue(withIdentifier: "deleteVC", sender: self)
        
    }
    //set up
    override func viewDidLoad() {
        super.viewDidLoad()

        employTable.delegate = self
        employTable.dataSource = self
        // Do any additional setup after loading the view.
        homeModel.getItems()
        homeModel.delegate = self
    }
    //gets the list of employees
    func itemsDownloaded(employees: [employees]){
        employee = employees
        DispatchQueue.main.async {
            self.employTable.reloadData()
        }    }
    
    @IBOutlet weak var employTable: UITableView!
    //send variables to next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if(popup){
            let vc = segue.destination as! deleteEmployeeViewController
            vc.firstName = self.firstName
            vc.lastName = self.lastName
            vc.admin = self.admin
            vc.employf = self.employf
            vc.emplol = self.employl
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
