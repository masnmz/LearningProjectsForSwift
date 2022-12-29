//
//  ViewController.swift
//  ListApp
//
//  Created by Mehmet Alp Sönmez on 25.10.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController  {
    var alertController = UIAlertController()
   
    @IBOutlet weak var tableView: UITableView!
    
    var data = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.fetch()
        
        
    }
    
    @IBAction func didRemoveBarButtonItemTapped(_ sender: UIBarButtonItem){
        presentAlert(title: "Uyarı",
                     message: "Listedeki bütün öğeleri silmek istediğinize emin misiniz?",
                     defaultButtonTitle: "Evet",
                     cancelButtonTitle: "Vazgeç") { _ in
            //            self.data.removeAll()
            //            self.tableView.reloadData()
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            
            let managedObjectContext = appDelegate?.persistentContainer.viewContext
            
            for item in self.data {
                managedObjectContext?.delete(item)
            }
            
            try? managedObjectContext?.save()
            
            self.fetch()
            
        }
        
    }
    @IBAction func didAddBarButtonItemTapped(_ sender: UIBarButtonItem){
        presentAddAlert()
    }
    
    func presentAddAlert() {
//        let alertController = UIAlertController(title: "Yeni Eleman Ekle", message: nil, preferredStyle: .alert)
//        let defaultButton = UIAlertAction(title: "Ekle", style: .default) { _ in
           
//        }
//        let cancelButton = UIAlertAction(title: "Vazgeç",
//                                         style: .cancel)
//        alertController.addTextField()
//
//        alertController.addAction(defaultButton)
//        alertController.addAction(cancelButton)
//        present(alertController, animated: true)
//
        presentAlert(title: "Yeni Eleman Ekle",
                     message: nil,
                     defaultButtonTitle: "Ekle",
                     cancelButtonTitle: "Vazgeç",
                     isTextFieldAvaliable: true,
                     defaultButtonHandler: { _ in
            let text = self.alertController.textFields?.first?.text
            
            if text != "" {
                
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
                let managedObjectContext = appDelegate?.persistentContainer.viewContext
                let entity = NSEntityDescription.entity(forEntityName: "ListItem",
                                                        in: managedObjectContext!)
                let listItem = NSManagedObject(entity: entity!,
                                               insertInto: managedObjectContext)
                listItem.setValue(text, forKey: "title")
                try? managedObjectContext?.save()
                self.fetch()
                
            }else{
                self.presentWarningAlert()
                
            }
        })
        
    }
    
    func presentWarningAlert(){
        
        presentAlert(title: "Uyarı",
                     message: "Listeye boş eleman ekleyemezsiniz!!",
                     cancelButtonTitle: "Tamam")
    
    }
    
    func presentAlert(title: String?,
                      message: String?,
                      preferredStyle: UIAlertController.Style = .alert,
                      defaultButtonTitle: String? = nil,
                      cancelButtonTitle: String?,
                      isTextFieldAvaliable: Bool = false,
                      defaultButtonHandler: ((UIAlertAction) -> Void)? = nil){
        alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: preferredStyle)
        if defaultButtonTitle != nil{
            let defaultButton = UIAlertAction(title: defaultButtonTitle,
                                              style: .default,
                                              handler: defaultButtonHandler)
            alertController.addAction(defaultButton)
        }
       
        let cancelButton = UIAlertAction(title: cancelButtonTitle,
                                         style: .cancel)
        if isTextFieldAvaliable{
            alertController.addTextField()
            
        }
        
        alertController.addAction(cancelButton)
        present(alertController, animated: true)
        
    }
    func fetch(){
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedObjectContext = appDelegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ListItem")
        data = try! managedObjectContext!.fetch(fetchRequest)
        tableView.reloadData()
    }
}
extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
        let listItem = data[indexPath.row]
        cell.textLabel?.text = listItem.value(forKey: "title") as? String
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Sil") { _, _, _ in

            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let managedObjectContext = appDelegate?.persistentContainer.viewContext
            managedObjectContext?.delete(self.data[indexPath.row])
            try? managedObjectContext?.save()
            
            self.fetch()
            
        }
        let editAction = UIContextualAction(style: .normal,
                                              title: "Düzenle") { _, _, _ in
            self.presentAlert(title: "Elemanı Düzenle",
                              message: nil,
                              defaultButtonTitle: "Düzenle",
                              cancelButtonTitle: "Vazgeç",
                              isTextFieldAvaliable: true,
                              defaultButtonHandler: { _ in
                let text = self.alertController.textFields?.first?.text
                
                if text != "" {
                    
//                    self.data[indexPath.row] = text!
                    let appDelegate = UIApplication.shared.delegate as? AppDelegate
                    let managedObjectContext = appDelegate?.persistentContainer.viewContext
                    self.data[indexPath.row].setValue(text, forKey: "title")
                    self.tableView.reloadData()
                    if managedObjectContext!.hasChanges{
                        try? managedObjectContext?.save()
                    }
                    
                }else{
                    self.presentWarningAlert()
                    
                }
            })
            
        }
        deleteAction.backgroundColor = .systemRed
        editAction.backgroundColor = .systemBlue
        let config = UISwipeActionsConfiguration(actions: [deleteAction,editAction])
        return config
    }
}

