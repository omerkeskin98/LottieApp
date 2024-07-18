//
//  ViewController.swift
//  LottieApp
//
//  Created by Omer Keskin on 18.07.2024.
//


import UIKit
import Lottie

class ViewController: UIViewController {
    
    var animationView: LottieAnimationView!
    var startButton: UIButton!
    var stopButton: UIButton!
    var savedPercentage: CGFloat = 0.0
    var isAnimating = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
      
        animationView = LottieAnimationView(name: "loading_animation")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit
        view.addSubview(animationView)
        
        
        startButton = UIButton(type: .system)
        startButton.setTitle("Start", for: .normal)
        startButton.addTarget(self, action: #selector(startAnimation), for: .touchUpInside)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startButton)
        
        
        stopButton = UIButton(type: .system)
        stopButton.setTitle("Stop", for: .normal)
        stopButton.addTarget(self, action: #selector(stopAnimation), for: .touchUpInside)
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stopButton)
        
       
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            animationView.widthAnchor.constraint(equalToConstant: 300),
            animationView.heightAnchor.constraint(equalToConstant: 300),
            
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 20),
            startButton.widthAnchor.constraint(equalToConstant: 200),
            startButton.heightAnchor.constraint(equalToConstant: 50),
            
            stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stopButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 20),
            stopButton.widthAnchor.constraint(equalToConstant: 200),
            stopButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    @objc func startAnimation() {
        if !isAnimating {
            isAnimating = true
            playAnimation(from: savedPercentage, to: 1.0)
        }
    }
    
    func playAnimation(from startProgress: CGFloat, to endProgress: CGFloat) {
        animationView.play(fromProgress: startProgress, toProgress: endProgress, loopMode: .none) { [weak self] (finished) in
            if finished {
                self?.savedPercentage = 0.0
                self?.playAnimation(from: 0.0, to: 1.0)
            }
        }
    }
    
    @objc func stopAnimation() {
        if isAnimating {
            animationView.pause()
            savedPercentage = animationView.realtimeAnimationProgress
            isAnimating = false
        }
    }
}

