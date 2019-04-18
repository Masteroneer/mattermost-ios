//
//  ChatViewController.swift
//  mattermost
//
//  Created by vadim on 11/04/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation
import UIKit

struct Message {
  var id: String
  var name: String
  var text: String
}

final class ChatViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - private
  
  
  private var presenter: ChatPresenterProtocol? { return basePresenter as? ChatPresenterProtocol }
  private var messages: [Message] = [
    Message(id: "1", name: "Иванов Иван", text: """
@AndroidSobes - телеграм-канал с разбором вопросов собеседований по Android
@JavaSobes- телеграм-канал с разбором вопросов собеседований по "чистой" Java
Рекомендую всем заинтересованным, если ещё не подписаны)
"""),
    Message(id: "1", name: "Иванов Иван", text: """
@AndroidSobes - телеграм-канал с разбором вопросов собеседований по Android
@JavaSobes- телеграм-кана.
"""),
    Message(id: "1", name: "Иванов Иван", text: "Всем привет!!!")
  ]
  
  
  // MARK: - Lifecicle
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 44.0
    
    tableView.register(cellType: ChatCell.self)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    presenter?.onViewWillAppear()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ChatCell.self)
    cell.messageText.text = messages[indexPath.row].text
    cell.name.text = messages[indexPath.row].name
    cell.selectionStyle = .none
    return cell
  }
}
