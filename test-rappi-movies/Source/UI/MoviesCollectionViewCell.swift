//
//  MoviesCollectionViewCell.swift
//  test-rappi-movies
//
//  Created by Sergio Zorrilla Arellano on 12/04/22.
//

import UIKit
import SDWebImage

class MoviesCollectionViewCell: UICollectionViewCell {
    let movieImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()

    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis  = .vertical
        sv.alignment = .center
        sv.distribution = .fillProportionally
        sv.spacing = 5
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }

    func addViews(){
        addSubview(stackView)
        
        stackView.addArrangedSubview(movieImageView)
        stackView.addArrangedSubview(nameLabel)
        
        stackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 5).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -5).isActive = true
        stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
        
        movieImageView.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 5).isActive = true
        movieImageView.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -5).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        movieImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 5).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -5).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var movie: ResultsMovies? {
        didSet {
            guard let movieItem = movie else {return}
            if let name = movieItem.originalTitle {
                nameLabel.text = name
                
            }
            if let imagePath = movieItem.posterPath {
                if Reachability.isConnectedToNetwork() {
                    movieImageView.sd_setImage(with: URL(string: "\(APIStrings.imagesURL)\(imagePath)"),
                                               completed: nil)
                } else {
                    let image = UIImage().fromBase64(data: imagePath)
                    movieImageView.image = image
                }
            }
        }
    }
}


class ContentCollectionViewHeader: UICollectionReusableView {
    let sectionNameLabel = UILabel()
        
    override func layoutSubviews() {
        super.layoutSubviews()
        sectionNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        sectionNameLabel.textColor = .white
        sectionNameLabel.sizeToFit()
        sectionNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(sectionNameLabel)

        
        sectionNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        sectionNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
    }
}
