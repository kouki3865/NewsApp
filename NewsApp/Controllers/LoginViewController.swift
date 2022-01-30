//
//  BaseViewController.swift
//  NewsApp
//
//  Created by koki on 2022/01/30.
//

import UIKit
import AVFoundation

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    private var player = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 15
        loginButton.addTarget(self, action: #selector(tappedLoginButton), for: .touchUpInside)
        playerSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    @objc private func tappedLoginButton(){
        player.pause()
    }
    
    private func playerSetup() {
        guard let path = Bundle.main.path(forResource: "Hanabi", ofType: "MOV") else {return}
        player = AVPlayer(url: URL(fileURLWithPath: path))
         
        let playerlayer = AVPlayerLayer(player: player)
        playerlayer.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        playerlayer.videoGravity = .resizeAspectFill
        playerlayer.repeatCount = 0
        playerlayer.zPosition = -1
        view.layer.insertSublayer(playerlayer, at: 0)
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { (_) in
            
            self.player.seek(to: .zero)
            self.player.play()
            
        }
        
        self.player.play()
    }
}
