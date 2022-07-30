import UIKit
import FirebaseStorage
import FirebaseFirestore
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        imageView.isUserInteractionEnabled = true
        
        let imageRecognizer = UITapGestureRecognizer(target: self, action: #selector(chosenImage))
        imageView.addGestureRecognizer(imageRecognizer)
       
    
    }
    @objc func chosenImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    func makeAlert(alertInput: String, alertMessage: String) {
        let alert = UIAlertController(title: alertInput, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
  
    
    @IBAction func uploadImageClicked(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        
        let mediaFolder = storageReferance.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            let imageReferance = mediaFolder.child("\(uuid).jpg")
            imageReferance.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    self.makeAlert(alertInput: "Error!", alertMessage: error?.localizedDescription ?? "Error!")
                }
                else {
                    imageReferance.downloadURL { (url, error) in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                      
                            
                            let firestoreDatabase = Firestore.firestore()
                            var firestoreReference : DocumentReference? = nil
                            
                            let firestorePost = ["imageUrl" : imageUrl!, "postedBy" : Auth.auth().currentUser!.email!, "postComment" : self.textLabel.text!, "date" : FieldValue.serverTimestamp(), "likes" : 0  ] as [String : Any]
                            
                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { error in
                                if error != nil {
                                    self.makeAlert(alertInput: "Error!", alertMessage: error?.localizedDescription ?? "Error!")
                                }
                            })

                                if error != nil {
                                    self.makeAlert(alertInput: "Error!", alertMessage: error?.localizedDescription ?? "Error")
                                }else {
                                    self.imageView.image = UIImage(named: "selectImg.png")
                                    self.textLabel.text = ""
                                    self.tabBarController?.selectedIndex = 1
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    


