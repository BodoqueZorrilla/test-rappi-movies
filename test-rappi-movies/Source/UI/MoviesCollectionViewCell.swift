//
//  MoviesCollectionViewCell.swift
//  test-rappi-movies
//
//  Created by Sergio Zorrilla Arellano on 12/04/22.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    let profileImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()

    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis  = .horizontal
        sv.alignment = .center
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        addViews()
    }

    func addViews(){
       // addSubview(profileImageView)
       // addSubview(nameLabel)
        
        // Stack View
        addSubview(stackView)
        
        stackView.addArrangedSubview(profileImageView)
        stackView.addArrangedSubview(nameLabel)
        
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.widthAnchor.constraint(equalToConstant: 40).isActive = true
        self.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
       /* profileImageView.leftAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 36).isActive = true*/
        
        /*nameLabel.leftAnchor.constraint(equalTo: self.trailingAnchor, constant: 5).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -8).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: self.leadingAnchor, constant: -30).isActive = true*/
        
        
        /* stackView.addArrangedSubview(likeButton)
         stackView.addArrangedSubview(hireButton)
         stackView.addArrangedSubview(messageButton)
         
         stackView.topAnchor.constraintEqualToAnchor(topSeparatorView.bottomAnchor, constant: 4).active = true
         stackView.widthAnchor.constraintEqualToAnchor(widthAnchor).active = true
         stackView.centerXAnchor.constraintEqualToAnchor(centerXAnchor).active = true
         */
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var movie: ResultsMovies? {
        didSet {
            guard let contactItem = movie else {return}
            if let name = contactItem.originalTitle {
                // profileImageView.image = UIImage(named: name)
                print("name ", name)
                nameLabel.text = name
            }
        }
    }
}


class ContentCollectionViewHeader: UICollectionReusableView {
    let sectionNameLabel = UILabel()
        
    override func layoutSubviews() {
        super.layoutSubviews()
        sectionNameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        sectionNameLabel.textColor = .white
        sectionNameLabel.sizeToFit()
        sectionNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(sectionNameLabel)

        
        sectionNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        sectionNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
    }
}
