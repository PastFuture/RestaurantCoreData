//
//  NewEateryTableViewController.swift
//  Eateries
//
//  Created by Arthur on 07.02.2019.
//  Copyright © 2019 Arthur. All rights reserved.
//

import UIKit

class NewEateryTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveButtonPressed: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!

    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    var isVisited = false
    
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
       if nameTextField.text == "" || addressTextField.text == "" || typeTextField.text == "" {
           let avc = UIAlertController(title: "Не заполнены все поля", message: "Пожалуйста, заполните все поля", preferredStyle: .alert)
            let aa = UIAlertAction(title: "OK", style: .default, handler: nil)
            avc.addAction(aa)
            present(avc, animated: true, completion: nil)
       } else {
        
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext{
            let restaurant = Restaurant(context: context)
            restaurant.name = nameTextField.text
            restaurant.location = addressTextField.text
            restaurant.type = typeTextField.text
            restaurant.isVisited = isVisited
            
            if let image = imageView.image{
                restaurant.image = image.pngData() as! Data
            }
            do{
                try context.save()
                print("Сохранение удалось")
            } catch let error as NSError {
                print("Не удалось сохранить данные\(error), \(error.userInfo)")
            }
        }
        
          performSegue(withIdentifier: "unwindSegueFromNewEatery", sender: self)
      }

   }


    @IBAction func toggleIsVisitedPressed(_ sender: UIButton) {
        if sender == yesButton{
            sender.backgroundColor =  #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            noButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            isVisited = true
        } else {
            noButton.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            sender.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            isVisited = false
        }
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        yesButton.backgroundColor =  #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        noButton.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)

    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }



    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let alertController = UIAlertController(title: "Источник фотографии", message: nil, preferredStyle: .actionSheet)
            let cameraAction = UIAlertAction(title: "Камера", style: .default) { (action) in
                self.chooseImagePickerAction(source: .camera)
            }
            let photoLibAction = UIAlertAction(title: "Библиотека", style: .default) { (action) in
                self.chooseImagePickerAction(source: .photoLibrary)
            }
            let cancelAction = UIAlertAction(title: "Отмена", style: .default, handler: nil)
            alertController.addAction(cameraAction)
            alertController.addAction(photoLibAction)
            alertController.addAction(cancelAction)

            self.present(alertController, animated: true, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true )
    }
    func chooseImagePickerAction (source: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(source){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true, completion: nil)
        }
    }





    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}
