//
//  UITableViewCell.swift
//  Rick And Morty
//
//  Created by Matthew Chukwuemeka on 03/12/2024.
//

import SwiftUI
import UIKit

class TableViewCell<Content: View>: UITableViewCell {
    private var hostingController: UIHostingController<Content>?

    func configure(with view: Content) {
        hostingController?.view.removeFromSuperview()
        hostingController?.removeFromParent()

        let hostingController = UIHostingController(rootView: view)
        self.hostingController = hostingController

        contentView.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
