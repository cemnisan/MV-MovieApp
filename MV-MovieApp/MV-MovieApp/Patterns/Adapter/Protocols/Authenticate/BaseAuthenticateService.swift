//
//  BaseAuthenticateService.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 7.05.2022.
//

import Foundation
import UIKit.UIViewController


protocol BaseAuthenticateService {
    func login(presenterViewController presenter: UIViewController,
               completed: @escaping () -> Void,
               failure: @escaping (Error) -> Void)
}
