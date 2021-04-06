//
//  ViewController.swift
//  MatchingApp
//
//  Created by Yong Jun Cha on 2021/03/08.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import PKHUD
import RxCocoa
import RxSwift

class HomeViewController: UIViewController {
    
    private var user : User?
    
    //Other Users information except my data
    private var users = [User]()
    private let disposeBag = DisposeBag()
    
    let topControlView = TopControlView()
    let cardView = UIView() //cardView
    let bottomControlView = BottomControlView()
    
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        
        return button
    }()

    // MARK : Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupBindings()
}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
//        Firestore.fetchUserFromFirestore(uid: uid)
        Firestore.fetchUserFromFirestore(uid: uid) { (user) in
            
            if let user = user {
                self.user = user
            }
        }
        
        fetchUsers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Auth.auth().currentUser?.uid == nil {
            let registerController = RegisterViewController()
            let nav = UINavigationController(rootViewController: registerController)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }
    }
    
    private func fetchUsers() {
        HUD.show(.progress)
        Firestore.fetchUsersFromFireStore { (users) in
            HUD.hide()
            self.users = users
            
            self.users.forEach { (user) in
                let card = CardView(user: user)
                self.cardView.addSubview(card)
                card.anchor(top: self.cardView.topAnchor, bottom: self.cardView.bottomAnchor, left: self.cardView.leftAnchor, right: self.cardView.rightAnchor)
            
            }
            print("Success Get Data ")
            
        }
        
    }
    

private func setupLayout(){
    view.backgroundColor = .white

    
    let stackView = UIStackView(arrangedSubviews: [topControlView, cardView, bottomControlView])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    
    self.view.addSubview(stackView)
    self.view.addSubview(logoutButton)
    
    [
        topControlView.heightAnchor.constraint(equalToConstant: 100),
        bottomControlView.heightAnchor.constraint(equalToConstant: 120),

        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor)]
        .forEach { $0.isActive = true}

    logoutButton.anchor(bottom: view.bottomAnchor, left: view.leftAnchor, bottomPadding: 10, leftPadding: 10)
    // Do any additional setup after loading the view.
    logoutButton.addTarget(self, action: #selector(tappedLogoutButton), for: .touchUpInside)
}
    @objc private func tappedLogoutButton() {
        do {
            try Auth.auth().signOut()
            let registerController = RegisterViewController()
            let nav = UINavigationController(rootViewController: registerController)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        } catch{
            print ("Logout Failed : ", error)
        }
    }
    
    private func setupBindings() {
        
        topControlView.profileButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                let profile = ProfileViewController()
                self?.present(profile, animated: true, completion: nil)
            }.disposed(by: disposeBag)

        
    }
}
