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
    
    @IBOutlet weak var EmployeeLabel: UILabel!
    var employee = [employees]()
    var homeModel = HomeModel()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employee.count
    }
    
    
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
        cell.textLabel?.text = employee[indexPath.row].firstName + " " + employee[indexPath.row].lastName  + phone
         return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        employTable.delegate = self
        employTable.dataSource = self
        // Do any additional setup after loading the view.
        homeModel.getItems()
        homeModel.delegate = self
    }
    func itemsDownloaded(employees: [employees]){
        employee = employees
        DispatchQueue.main.async {
            self.employTable.reloadData()
        }    }
    
    @IBOutlet weak var employTable: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let vc = segue.destination as! MenuViewController
        vc.firstName = self.firstName
        vc.lastName = self.lastName
        vc.admin = self.admin
        
    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
