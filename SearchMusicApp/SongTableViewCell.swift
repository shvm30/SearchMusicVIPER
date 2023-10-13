//
//  SongTableViewCell.swift
//  SearchMusicApp
//
//  Created by Владимир on 12.10.2023.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    //MARK: - Public proparties
    
    var presenter: SongsPresenterProtocol?
    
    //MARK: - UI Elements
    
    private lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var trackNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    internal lazy var trackImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private methods
    
    private func setViews() {
        self.addSubview(artistNameLabel)
        self.addSubview(trackImageView)
        self.addSubview(trackNameLabel)
    }
    private func setConstraints() {
        trackImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        trackImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        trackImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        trackImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        artistNameLabel.leadingAnchor.constraint(equalTo: trackImageView.trailingAnchor, constant: 15).isActive = true
        artistNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        artistNameLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        trackNameLabel.leadingAnchor.constraint(equalTo: trackImageView.trailingAnchor, constant: 15).isActive = true
        trackNameLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 30).isActive = true
        trackNameLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
    func configure(track: String, artist: String, trackImage: String) {
        self.trackNameLabel.text = track
        self.artistNameLabel.text = artist
        
        LoadImageService().loadImage(stringUrl: trackImage) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.trackImageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

