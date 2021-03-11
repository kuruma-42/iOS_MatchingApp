//
//  TopControlView.swift
//  MatchingApp
//
//  Created by Yong Jun Cha on 2021/03/10.
//

import UIKit
import RxCocoa
import RxSwift

class TopControlView: UIView {
    
    private let disposeBag = DisposeBag()
    
    let tinderButton = createTopButton(imageName: "tinder-selected",unselectedImage: "tinder-unselected")
    let goodButton = createTopButton(imageName: "good-selected",unselectedImage: "good-unselected")
    let commentButton = createTopButton(imageName: "comment-selected",unselectedImage: "comment-unselected")
    let profileButton = createTopButton(imageName: "profile-selected",unselectedImage: "profile-unselected")
    
    
    static private func createTopButton(imageName : String ,unselectedImage : String) -> UIButton{
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: imageName), for: .selected)
        button.setImage(UIImage(named: unselectedImage), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupBindings()
    }
    
    private func setupLayout(){
        let baseStackView = UIStackView(arrangedSubviews: [tinderButton, goodButton, commentButton, profileButton])
        baseStackView.axis = .horizontal
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 43
        baseStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(baseStackView)
        
        baseStackView.anchor(top : topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, leftPadding: 40,
                             rightPadding: 40)
        
        
        tinderButton.isSelected = true
    }
    
    private func setupBindings(){
        
        tinderButton.rx.tap
            .asDriver()
            .drive(onNext: {  [weak self] _ in
                guard let self = self else {return}
                self.handleSelectedButton(selectedButton: self.tinderButton)
            })
            .disposed(by: disposeBag)
        
        goodButton.rx.tap
            .asDriver()
            .drive(onNext: {  [weak self] _ in
                guard let self = self else {return}
                self.handleSelectedButton(selectedButton: self.goodButton)
            })
            .disposed(by: disposeBag)
        
        commentButton.rx.tap
            .asDriver()
            .drive(onNext: {  [weak self] _ in
                guard let self = self else {return}
                self.handleSelectedButton(selectedButton: self.commentButton)
            })
            .disposed(by: disposeBag)
        
        profileButton.rx.tap
            .asDriver()
            .drive(onNext: {  [weak self] _ in
                guard let self = self else {return}
                self.handleSelectedButton(selectedButton: self.profileButton)
            })
            .disposed(by: disposeBag)
    }
    
    private func handleSelectedButton(selectedButton : UIButton) {
        let buttons = [tinderButton, goodButton, commentButton, profileButton]
        
        buttons.forEach { button in
            if button == selectedButton {
                button.isSelected = true
            }else{
                button.isSelected = false
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
