//
//  AlertExtension.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/23.
//

import UIKit

extension UIViewController {
    
    //MARK: - 권한 있을 때랑 없을 때랑 다르게 분기처리를 해보자
    //그리고 새싹 영등포 어노테이션 추가되도록
    func locationAuthorizeAlert() {
        let alert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)

        let goSetting = UIAlertAction(title: "설정으로 이동", style: .default) { _ in

            guard let appSetting = URL(string: UIApplication.openSettingsURLString) else {
                print("설정 URL 잘 못 가져왔음.")
                return
            }
            UIApplication.shared.open(appSetting)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)

        alert.addAction(goSetting)
        alert.addAction(cancel)

        present(alert, animated: true)
    }
    
    func filteringActionSheet(lotte: @escaping (UIAlertAction) -> (), cgv: @escaping (UIAlertAction) -> (), megaBox: @escaping (UIAlertAction) -> (), all: @escaping (UIAlertAction) -> ()) {

        let filterActionsheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let lotteCinema = UIAlertAction(title: "롯데시네마", style: .default, handler: lotte)
        let cgv = UIAlertAction(title: "CGV", style: .default, handler: cgv)
        let megaBox = UIAlertAction(title: "메가박스", style: .default, handler: megaBox)
        let showAll = UIAlertAction(title: "전체보기", style: .default, handler: all)
        let cancel = UIAlertAction(title: "취소", style: .cancel)

        filterActionsheet.addAction(lotteCinema)
        filterActionsheet.addAction(cgv)
        filterActionsheet.addAction(megaBox)
        filterActionsheet.addAction(showAll)
        filterActionsheet.addAction(cancel)

        present(filterActionsheet, animated: true)
    }

}
