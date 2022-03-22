import UIKit
import CoreData

class NoteDetailVC: UIViewController {

    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var titleTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func saveNote(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
        let newNote = Note(entity: entity!, insertInto: context)
        
        newNote.id = noteList.count as NSNumber
        newNote.desc = descriptionTV.text
        newNote.title = titleTF.text
        do {
            try context.save()
            noteList.append(newNote)
            navigationController?.popViewController(animated: true)
        }
        catch {
            print("Context save error")
        }
    }
    
}

