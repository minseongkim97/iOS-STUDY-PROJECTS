
import UIKit

struct Data {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
}

struct Section {
    let title: String
    let data: [DataType]
}

struct SwitchData {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
    var isOn: Bool
}
enum DataType {
    case staticCell(model: Data)
    case switchCell(model: SwitchData)
}



