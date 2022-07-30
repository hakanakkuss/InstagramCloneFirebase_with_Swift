import UIKit
import Firebase

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var userLikeArray = [Int]()
    var userImageArray = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromFirebase()
    
    }
    
    func getDataFromFirebase () {
        
        let firestoreDatabase = Firestore.firestore()
        
        firestoreDatabase.collection("Posts").addSnapshotListener { querySnapshot, error in
            if error != nil {
                print("error")
            }
            else {
                if querySnapshot?.isEmpty != true && querySnapshot != nil{
                    for documents in querySnapshot!.documents {
                        let documentID = documents.documentID
                        if let postedBy = documents.get("postedBy") as? String {
                            self.userEmailArray.append(postedBy)
                        }
                        if let postComment = documents.get("postComment") as? String {
                            self.userCommentArray.append(postComment)
                        }
                        if let likes = documents.get("likes") as? Int {
                            self.userLikeArray.append(likes)
                        }
                        if let imageUrl = documents.get("imageUrl") as? String {
                            self.userImageArray.append(imageUrl)
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.likeLabel.text = String(userLikeArray[indexPath.row])
        cell.commentLabel.text = userCommentArray[indexPath.row]
        cell.useremailLabel.text = userEmailArray[indexPath.row]
        cell.userimageView.image = UIImage(named: "selectImg")
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 490.0
    }
    
  
    
   

   

}
