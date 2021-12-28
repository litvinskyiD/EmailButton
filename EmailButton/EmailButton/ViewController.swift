//
//  ViewController.swift
//  EmailButton
//
//  Created by Denys Litvinskyi on 28.12.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addEmailButton()
    }
}

// MARK: - Private methods
extension ViewController {
    
    private func addEmailButton() {
        let emailButton = ActionButton(config: .email)
        emailButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(emailButton)
        NSLayoutConstraint.activate([
            emailButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            emailButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            emailButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            emailButton.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        emailButton.addTarget(self, action: #selector(onSignInButtpnTouchUp), for: .touchUpInside)
    }
}

// MARK: - Actions
extension ViewController {
    
    @IBAction private func onSignInButtpnTouchUp() {
        print("Signed")
    }
}
