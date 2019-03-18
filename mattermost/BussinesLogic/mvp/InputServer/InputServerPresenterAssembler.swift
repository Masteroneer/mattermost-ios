//
//  InputServerPresenterAssembler.swift
//  mattermost
//
//  Created by Vadim Salmin on 18/03/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

final class InputServerPresenterAssembler: BasePresenterAssemblerProtocol {
  func assemble(baseView: BaseViewPresenterProtocol, baseInputParams: BaseInputParamsProtocol?) -> BasePresenterProtocol {
    let presenter = InputServerPresenter(baseView: baseView, inputParams: baseInputParams)
    presenter.serverUrlsService = ServerUrlsService()
    return presenter
  }
}
