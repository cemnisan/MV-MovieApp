//
//  CastDetailsRouter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 28.05.2022.
//

import UIKit

final class CastDetailsRouter {
    
    private unowned var view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
}

extension CastDetailsRouter: CastDetailsRoute {}
