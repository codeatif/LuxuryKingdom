//
//  ProfileViewController.swift
//  LuxuryKingdom
//
//  Created by MacProAtif on 19/03/18.
//  Copyright © 2018 Aimran. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    let userNames = ["Adam Irresistible", "John Spender", "Kelly Trotter", "Ahmed Prince", "Dave Boy", "Christy Gal", "Sergey Loyal", "Supa Hot Fire", "Christy Gal", "Christy Gal"]
    let imageList = ["top_user.jpg", "man.jpeg", "kelly.jpg","ahmed.jpeg","top_user.jpg","christy.jpeg","top_user.jpg","top_user.jpg","christy.jpeg","christy.jpeg"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customButton = UIBarButtonItem(image: UIImage(named: "BackIcon"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem  = customButton
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editBtnTapped))

        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.init(named: "LuxuryGold") ?? UIColor.white,
             NSAttributedStringKey.font: UIFont(name: "PingFang HK", size: 14)!]
        self.navigationItem.title = "PROFILE"

    }

    override func viewWillAppear(_ animated: Bool) {
        profileImage.layer.borderWidth = 0.8
        profileImage.layer.borderColor = UIColor(named:"LuxuryGold")?.cgColor
        messageTableView.layer.cornerRadius = 5
    }
    
    @objc func backButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func editBtnTapped() {
    }
    
    override func viewWillLayoutSubviews() {
        let path = UIBezierPath()
    
        path.move(to: CGPoint(x: 0, y: profileImage.frame.maxY - profileImage.frame.maxY/4))//start here
        path.addLine(to: CGPoint(x: view.frame.size.width, y: view.frame.origin.y))
        path.addLine(to: CGPoint(x: view.frame.size.width, y: view.frame.size.height))
        path.addLine(to: CGPoint(x: view.frame.origin.x, y: view.frame.size.height))
        path.close()
    
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = backgroundImage.bounds
        shapeLayer.path = path.cgPath
        backgroundImage.layer.mask = shapeLayer
        backgroundImage.layer.masksToBounds = true
    }
    
    @IBAction func profileSegmentDidChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            self.navigationItem.rightBarButtonItem = nil
            messageTableView.isHidden = false
        }else{
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editBtnTapped))
            messageTableView.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
        
        let userIcon = cell.viewWithTag(1) as! UIImageView
        userIcon.image = UIImage(named:imageList[indexPath.row])
        
        let userName = cell.viewWithTag(2) as! UILabel
        userName.text = userNames[indexPath.row]

        let msg = cell.viewWithTag(3) as! UILabel
        if indexPath.row == 0 {
            msg.text = "Are you game for a Yacht this weekend?"
        }else if indexPath.row == 1{
            msg.text = "Stuck in a gridlock. He won't let me in 'cause he thinks he's the law. People smile and look at the time. Think I'll try'n impress my mates."
        }else if indexPath.row == 2{
            msg.text = "Complacent, got me headed for the door. Never move, you think everything's too far. Six foot deep, Bleaker Street. Don't hear a word they say. He'll give me shout when he's figured it out. Yeah, the trees are pretty wide."
        }else if indexPath.row == 3{
            msg.text = "I'm down on the floor, there's a man on the door. Took a cabbie down, put a smile on my face. Fifty rooms at Heavenly. You're telling me never, it should be whenever. Why can't I be just like the people that I know?. What kept you? I'm not bothered any more."
        }else if indexPath.row == 4{
            msg.text = "We gonna pull together through it. Stiffen up that upper lip. 'Cause that's where most of my anger is baste. 'Cause I've been treated like dirt befo' ya. It's not so bad. Frozen as snow, I show no emotion whatsoever, so. It's not so bad."
        }else if indexPath.row == 5{
            msg.text = "And I ain't stopping till the swear jar's full. I believe people can change, but only for the worse. Wild ever since the day I came out I was like, merits. Chika-chika."
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
