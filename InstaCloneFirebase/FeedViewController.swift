import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var userLikesArray = [Int]()
    var userImageUrlArray = [String]()
  
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getFromDataFirestore()
    
    }
    
    func getFromDataFirestore (){
        
        let firestoreDatabase = Firestore.firestore()
        
        firestoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { querysnapshot, error in
            if error != nil {
                print(error?.localizedDescription ?? "Error!")
            }
            else {
                if querysnapshot?.isEmpty != true && querysnapshot != nil {
                    
                    self.userEmailArray.removeAll(keepingCapacity: false)
                    self.userLikesArray.removeAll(keepingCapacity: false)
                    self.userImageUrlArray.removeAll(keepingCapacity: false)
                    self.userCommentArray.removeAll(keepingCapacity: false)
                    for document in querysnapshot!.documents {
                        let documentID = document.documentID
                        if let postedBy = document.get("postedBy") as? String {
                            self.userEmailArray.append(postedBy)
                        }
                        if let postComment = document.get("postComment") as? String{
                            self.userCommentArray.append(postComment)
                        }
                        if let likes = document.get("likes") as? Int {
                            self.userLikesArray.append(likes)
                        }
                        if let imageUrl = document.get("imageUrl") as? String {
                            self.userImageUrlArray.append(imageUrl)
                        }
                        
                    }
                    self.tableView.reloadData()
                }
            }
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.likeLabel.text = String(userLikesArray[indexPath.row])
        cell.commentLabel.text = userCommentArray[indexPath.row]
        cell.useremailLabel.text = userEmailArray[indexPath.row]
        cell.userimageView.sd_setImage(with: URL(string: self.userImageUrlArray[indexPath.row]))
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 490.0
    }
    
  
    
   

   

}
