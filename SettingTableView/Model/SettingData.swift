//
//  SettingData.swift
//  SettingTableView
//
//  Created by MIN SEONG KIM on 2021/05/10.
//

import UIKit

struct K {
    static let model = [
        
        Section(title: "", data: [
            .switchCell(model: SwitchData(title: "에어플레인 모드", icon: UIImage(systemName: "airplane"), iconBackgroundColor: .systemOrange, handler: {}, isOn: false)),
            .staticCell(model: Data(title: "Wi-Fi", icon: UIImage(systemName: "wifi"), iconBackgroundColor: .systemBlue){}),
            .staticCell(model: Data(title: "배경화면", icon: UIImage(systemName: "circle.grid.hex"), iconBackgroundColor: .systemBlue){}),
            .staticCell(model: Data(title: "셀룰러", icon: UIImage(systemName: "antenna.radiowaves.left.and.right"), iconBackgroundColor: .systemGreen){}),
            .staticCell(model: Data(title: "개인용 핫스팟", icon: UIImage(systemName: "personalhotspot"), iconBackgroundColor: .systemGreen){}),
            .staticCell(model: Data(title: "암호", icon: UIImage(systemName: "key.fill"), iconBackgroundColor: .systemBlue){})
        ]),
        Section(title: "", data: [
            .staticCell(model: Data(title: "알림", icon: UIImage(systemName: "app.badge"), iconBackgroundColor: .systemRed){}),
            .staticCell(model: Data(title: "사운드 및 햅틱", icon: UIImage(systemName: "speaker.wave.3.fill"), iconBackgroundColor: .systemPink){}),
            .staticCell(model: Data(title: "방해금지 모드", icon: UIImage(systemName: "moon.fill"), iconBackgroundColor: .systemIndigo){}),
            .staticCell(model: Data(title: "스크린 타임", icon: UIImage(systemName: "hourglass"), iconBackgroundColor: .systemIndigo){})
        ]),
        Section(title: "", data: [
            .staticCell(model: Data(title: "일반", icon: UIImage(systemName: "gear"), iconBackgroundColor: .systemGray){}),
            .staticCell(model: Data(title: "제어 센터", icon: UIImage(systemName: "switch.2"), iconBackgroundColor: .systemGray){}),
            .staticCell(model: Data(title: "디스플레이 및 밝기", icon: UIImage(systemName: "a"), iconBackgroundColor: .systemBlue){}),
            .staticCell(model: Data(title: "배터리", icon: UIImage(systemName: "battery.100"), iconBackgroundColor: .systemGreen){}),
            .staticCell(model: Data(title: "개인 정보 보호", icon: UIImage(systemName: "hand.raised.fill"), iconBackgroundColor: .systemBlue){})
        ])
    ]

}
