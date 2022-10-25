//
//  FirstOnboardingViewController.swift
//  SHOPPING-APP
//
//  Created by AKIN on 24.10.2022.
//

import UIKit
import AVFoundation
import Combine

class FirstOnboardingViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var darkView: UIView!
    @IBOutlet weak var getStartedButton: UIButton!
    
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    private let notificationCenter = NotificationCenter.default
    private var appEventSubscribers = [AnyCancellable]()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        observeAppEvent()
        setupPlayerIfNeeded()
        restartVideo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        removeAppEventsSubscribers()
        removePlayer()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer?.frame = view.bounds
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    
    // MARK: - Helpers
    
    private func setupViews() {
        getStartedButton.layer.cornerRadius = getStartedButton.frame.height / 2
        getStartedButton.layer.masksToBounds = true
        darkView.backgroundColor = UIColor.init(white: 0.1, alpha: 0.4)
    }
    
    private func buildPlayer() -> AVPlayer? {
        guard let filePath = Bundle.main.path(forResource: "onboardingVideo", ofType: "mp4") else { return nil }
        let url = URL(fileURLWithPath: filePath)
        let player = AVPlayer(url: url)
        player.actionAtItemEnd = .none
        player.isMuted = true
        return player
    }
    
    private func buildPlayerLayer() -> AVPlayerLayer? {
        let layer = AVPlayerLayer(player: player)
        layer.videoGravity = .resizeAspectFill
        return layer
    }
    
    private func playVideo() {
        player?.play()
    }
    
    private func restartVideo() {
        player?.seek(to: .zero)
        playVideo()
    }
    
    private func pauseVide() {
        player?.pause()
    }
    
    private func setupPlayerIfNeeded() {
        player = buildPlayer()
        playerLayer = buildPlayerLayer()
        
        if let layer = self.playerLayer,
            view.layer.sublayers?.contains(layer) == false {
                view.layer.insertSublayer(layer, at: 0)
        }
    }
    
    private func removePlayer() {
        player?.pause()
        player = nil
        playerLayer?.removeFromSuperlayer()
        playerLayer = nil
    }
    
    private func observeAppEvent() {
        notificationCenter.publisher(for: .AVPlayerItemDidPlayToEndTime).sink { [weak self] _ in
            self?.restartVideo()
        }.store(in: &appEventSubscribers)
        
        notificationCenter.publisher(for: UIApplication.willResignActiveNotification).sink { [weak self] _ in
            self?.pauseVide()
        }.store(in: &appEventSubscribers)
        
        notificationCenter.publisher(for: UIApplication.didBecomeActiveNotification).sink { [weak self] _ in
            self?.playVideo()
        }.store(in: &appEventSubscribers)
    }
    
    private func removeAppEventsSubscribers() {
        appEventSubscribers.forEach { subscriber in
            subscriber.cancel()
        }
    }

    // MARK: - IBActions
    
    @IBAction func getStartedButtonTapped(_ sender: Any) {
        let controller = OnboardingController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
