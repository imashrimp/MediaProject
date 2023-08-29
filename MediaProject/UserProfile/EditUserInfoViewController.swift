//
//  EditUserInfoViewController.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/29.
//

import UIKit
import SnapKit

class EditUserInfoViewController: UIViewController {
    
    var titleValue: String?
    var dataPassType: DataPassType?
    
    let mainVC = EditUserInfoView()
    
    var delegate: ChangeNickNameProtocol?
    
    override func loadView() {
        self.view = mainVC
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.title = titleValue
        mainVC.label.text = titleValue
        mainVC.textField.becomeFirstResponder()
                
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        guard let textFieldValue = mainVC.textField.text else { return }
        
        switch dataPassType {
        case .noti:
            NotificationCenter.default.post(name: NSNotification.Name("name"), object: nil, userInfo: ["name": textFieldValue])
        case .delegate:
            delegate?.recieveNickName(data: textFieldValue)
        case .closure:
            print("hi")
        case .none:
            print("none")
        }
    }
}
