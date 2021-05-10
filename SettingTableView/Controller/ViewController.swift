//
//  ViewController.swift
//  SettingTableView
//
//  Created by MIN SEONG KIM on 2021/05/10.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            self.tableView.dataSource  = self
            self.tableView.delegate = self
            self.tableView.separatorInset.left = 63
            self.tableView.register(UINib(nibName: "SettingTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingTableViewCell")
        }
    }
    
    
    
    var model = [Section]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // searchController를 네비게이션바 안에 넣기(네비게이션 아이템으로 넣기)
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "검색"
        self.navigationItem.searchController = searchController


       
        

        model = [
            
            Section(title: "", data: [
                Data(title: "에어플레인 모드", icon: UIImage(systemName: "airplane"), iconBackgroundColor: .systemOrange){},
                Data(title: "Wi-Fi", icon: UIImage(systemName: "wifi"), iconBackgroundColor: .systemBlue){},
                Data(title: "배경화면", icon: UIImage(systemName: "circle.grid.hex"), iconBackgroundColor: .systemBlue){},
                Data(title: "셀룰러", icon: UIImage(systemName: "antenna.radiowaves.left.and.right"), iconBackgroundColor: .systemGreen){},
                Data(title: "개인용 핫스팟", icon: UIImage(systemName: "personalhotspot"), iconBackgroundColor: .systemGreen){},
                Data(title: "암호", icon: UIImage(systemName: "key.fill"), iconBackgroundColor: .systemBlue){}
            ]),
            Section(title: "", data: [
                Data(title: "알림", icon: UIImage(systemName: "app.badge"), iconBackgroundColor: .systemRed){},
                Data(title: "사운드 및 햅틱", icon: UIImage(systemName: "speaker.wave.3.fill"), iconBackgroundColor: .systemPink){},
                Data(title: "방해금지 모드", icon: UIImage(systemName: "moon.fill"), iconBackgroundColor: .systemIndigo){},
                Data(title: "스크린 타임", icon: UIImage(systemName: "hourglass"), iconBackgroundColor: .systemIndigo){}
            ]),
            Section(title: "", data: [
                Data(title: "일반", icon: UIImage(systemName: "gear"), iconBackgroundColor: .systemGray){},
                Data(title: "제어 센터", icon: UIImage(systemName: "switch.2"), iconBackgroundColor: .systemGray){},
                Data(title: "디스플레이 및 밝기", icon: UIImage(systemName: "a"), iconBackgroundColor: .systemBlue){},
                Data(title: "배터리", icon: UIImage(systemName: "battery.100"), iconBackgroundColor: .systemGreen){},
                Data(title: "개인 정보 보호", icon: UIImage(systemName: "hand.raised.fill"), iconBackgroundColor: .systemBlue){}
            ])
        ]
      
    }
    
}
    
extension ViewController: UITableViewDataSource {
    
    // section title 설정
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = model[section]
        return section.title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model[section].data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = model[indexPath.section].data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as! SettingTableViewCell
        
        cell.title.text = model.title
        cell.iconImage.image = model.icon
        cell.iconBackgroundImage.backgroundColor = model.iconBackgroundColor
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 클릭 후 회색잔상 안남기기
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
    


    
    
    
    
    
