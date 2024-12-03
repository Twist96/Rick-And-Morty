//
//  TableVIew.swift
//  Rick And Morty
//
//  Created by Matthew Chukwuemeka on 03/12/2024.
//

import SwiftUI
import UIKit

public struct TableView<Content: View>: UIViewRepresentable {
    public typealias UIViewType = UITableView
    
    let items: [Character]
    let threshold: Int = 5
    let loadMore: (() -> Void)?
    let content: (Character) -> Content
    
    public func makeUIView(context: Context) -> UIViewType {
        let tableView = UITableView()
        tableView.dataSource = context.coordinator
        tableView.delegate = context.coordinator
        tableView.register(TableViewCell<Content>.self, forCellReuseIdentifier: "TableViewCell")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }

    public func updateUIView(_ uiView: UITableView, context: Context) {
        context.coordinator.parent = self
        uiView.reloadData()
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public class Coordinator: NSObject, UITableViewDataSource, UITableViewDelegate {
        var parent: TableView

        init(_ parent: TableView) {
            self.parent = parent
        }

        public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            parent.items.count
        }

        public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell<Content>
            let item = parent.items[indexPath.row]
            cell.configure(with: parent.content(item))

            //check if you need to load more
            if indexPath.row >= parent.items.count - parent.threshold {
                parent.loadMore?()
            }
            return cell
        }

        public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            UITableView.automaticDimension
        }
    }
}
