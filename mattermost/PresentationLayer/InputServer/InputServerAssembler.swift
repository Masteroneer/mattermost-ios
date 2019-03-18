//
//  InputServerAssembler.swift
//  mattermost
//
//  Created by Vadim Salmin on 15/03/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

class InputServerAssembler: BaseAssemblerProtocol {
  var presenterAssembler: BasePresenterAssemblerProtocol.Type { return InputServerPresenterAssembler.self }
  var theme: BaseThemeProtocol.Type { return InputServerTheme.self }
}
