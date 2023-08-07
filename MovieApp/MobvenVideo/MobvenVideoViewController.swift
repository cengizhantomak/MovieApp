//
//  MobvenVideoViewController.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 6.08.2023.
//

import UIKit
import AVFoundation

protocol MobvenVideoDisplayLogic: AnyObject {
    func displayVideoState(viewModel: MobvenVideoModels.PlayVideo.ViewModel)
}

final class MobvenVideoViewController: UIViewController {
    
    var interactor: MobvenVideoBusinessLogic?
    var router: (MobvenVideoRoutingLogic & MobvenVideoDataPassing)?
    
    // MARK: - Outlet
    
    @IBOutlet weak var videoPlayerView: UIView!
    @IBOutlet weak var playPauseButton: UIButton!
    
    // MARK: - Player Properties
    
    private var player: AVPlayer? = AVPlayer()
    private var playerLayer: AVPlayerLayer? = AVPlayerLayer()
    
    // MARK: - Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayer()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = MobvenVideoInteractor()
        let presenter = MobvenVideoPresenter()
        let router = MobvenVideoRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupPlayer() {
        playerLayer = AVPlayerLayer(player: player)
        guard let playerLayer else { return }
        playerLayer.frame = videoPlayerView.bounds
        playerLayer.videoGravity = .resize
        videoPlayerView.layer.addSublayer(playerLayer)
        interactor?.getVideo(player: player)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    // MARK: - Actions
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        player?.seek(to: CMTime.zero)
        interactor?.resetPlayState()
    }
    
    @IBAction func playPauseButtonTapped(_ sender: UIButton) {
        interactor?.togglePlayState(player: player)
    }
    
    @IBAction func forwardButtonTapped(_ sender: UIButton) {
        interactor?.moveForward(player: player)
    }
    
    @IBAction func backwardButtonTapped(_ sender: UIButton) {
        interactor?.moveBackward(player: player)
    }
}

// MARK: - DisplayLogic

extension MobvenVideoViewController: MobvenVideoDisplayLogic {
    func displayVideoState(viewModel: MobvenVideoModels.PlayVideo.ViewModel) {
        playPauseButton.setImage(UIImage(systemName: viewModel.buttonTitle), for: .normal)
    }
}
