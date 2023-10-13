//
//  DetailSongViewViewController.swift
//  SearchMusicApp
//
//  Created by Владимир on 13.10.2023.
//

import UIKit
import AVKit
protocol DetailSongViewViewControllerProtocol: AnyObject {
    func showDetail(details: DetailSongViewModel)
    func succes(image: UIImage)
}
class DetailSongViewViewController: UIViewController {
    
    //MARK: - Public proparies
    
    var presenter: DetailSongViewPresenter?
    var player: AVPlayer?
    
    //MARK: Ui elements
    
    private lazy var trackNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var trackImageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var playerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play/Stop", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setViews()
        setConstraints()
        presenter?.viewDidLoaded()
    }
    
    //MARK: - Private methods
    
    @objc private func playButtonPressed() {
        presenter?.isPlayerPlaying.toggle()
        let isPlaying = presenter?.isPlayerPlaying ?? false
        guard let url = URL(string: presenter?.detailModel?.trackUrl ?? "") else { return }
        player = AVPlayer(url: url)
        if isPlaying {
            player?.play()
        } else {
            player?.pause()
            player?.rate = 0
        }
    }
    
    private func setViews() {
        view.addSubview(trackNameLabel)
        view.addSubview(playerButton)
        view.addSubview(trackImageImageView)
        view.addSubview(artistNameLabel)
    }
    private func setConstraints() {
        trackImageImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        trackImageImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        trackImageImageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        trackImageImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        trackNameLabel.topAnchor.constraint(equalTo: trackImageImageView.bottomAnchor, constant: 30).isActive = true
        trackNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        trackNameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        artistNameLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 10).isActive = true
        artistNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        artistNameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        playerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playerButton.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 15).isActive = true
    }
}
    //MARK: - Extensions
extension DetailSongViewViewController: DetailSongViewViewControllerProtocol {
    func showDetail(details: DetailSongViewModel) {
        DispatchQueue.main.async {
            self.trackNameLabel.text = details.trackName
            self.artistNameLabel.text = details.artistName
        }
    }
    func succes(image: UIImage) {
        DispatchQueue.main.async {
            self.trackImageImageView.image = image
        }
    }
}
