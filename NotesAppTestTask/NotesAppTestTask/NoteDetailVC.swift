import UIKit
import CoreData

class NoteDetailVC: UIViewController {

    var selectedNote: Note? = nil
    
    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var titleTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (selectedNote != nil) {
            titleTF.text = selectedNote?.title
            descriptionTV.text = selectedNote?.desc
        }
    }

    @IBAction func saveNote(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        if(selectedNote == nil) {
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
        else {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            do {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let note = result as! Note
                    if(note == selectedNote) {
                        note.desc = descriptionTV.text
                        note.title = titleTF.text
                        try context.save()
                        navigationController?.popViewController(animated: true)
                    }
                }
            }
            catch {
                print("Fetch failed")
            }
        }
    }
    
}

