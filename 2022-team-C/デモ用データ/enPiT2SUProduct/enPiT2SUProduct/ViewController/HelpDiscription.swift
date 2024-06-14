//
//  HelpDiscription.swift
//  enPiT2SUProduct
//
//  Created by 益子　陸 on 2022/12/26.
//

import UIKit

class HelpDiscription: UIViewController {

    @IBOutlet weak var mainView: UIScrollView!
    var info: HelpInfo!
    var selectedCell : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = info.name
        print("select")
        print(selectedCell)
        if (selectedCell == 0) {
            let button = UIButton()
            let image = UIImage(systemName: "cross.case.fill")
            button.setTitleColor(UIColor(red: 25/255, green: 78/255, blue: 252/255, alpha: 0.4), for: .normal)
            button.frame = CGRect(x: 20, y: 50, width: 40, height: 40)
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor(red: 25/255, green: 78/255, blue: 252/255, alpha: 0.4).cgColor
            button.layer.cornerRadius = 5
            button.setImage(image, for: .normal)
            let label = UILabel()
            label.frame = CGRect(x: 20, y: -30, width: 500, height: 500)
            label.text = info.description
            label.numberOfLines = 0
            mainView.addSubview(button)
            mainView.addSubview(label)
        } else if (selectedCell == 1) {
            let button = UIButton()
            let image = UIImage(systemName: "trash.fill")
            button.setTitleColor(UIColor(red: 25/255, green: 78/255, blue: 252/255, alpha: 0.4), for: .normal)
            button.frame = CGRect(x: 20, y: 60, width: 40, height: 40)
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor(red: 25/255, green: 78/255, blue: 252/255, alpha: 0.4).cgColor
            button.layer.cornerRadius = 5
            button.setImage(image, for: .normal)
            let label = UILabel()
            label.frame = CGRect(x: 20, y: 0, width: 500, height: 500)
            label.text = info.description
            label.numberOfLines = 0
            mainView.addSubview(button)
            mainView.addSubview(label)
        } else if (selectedCell == 2) {
            let label = UILabel()
            label.frame = CGRect(x: 20, y: -50, width: 500, height: 500)
            label.text = info.description
            label.numberOfLines = 0
            mainView.addSubview(label)
        } else if (selectedCell == 3) {
            let button = UIButton()
            let image = UIImage(systemName: "doc.on.clipboard")
            button.setTitleColor(UIColor(red: 25/255, green: 78/255, blue: 252/255, alpha: 0.4), for: .normal)
            button.frame = CGRect(x: 20, y: 50, width: 40, height: 40)
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor(red: 25/255, green: 78/255, blue: 252/255, alpha: 0.4).cgColor
            button.layer.cornerRadius = 5
            button.setImage(image, for: .normal)
            let label1 = UILabel()
            label1.frame = CGRect(x: 20, y: 100, width: 500, height: 500)
            label1.text = info.description
            label1.numberOfLines = 0
            let label2 = UILabel()
            label2.frame = CGRect(x: 20, y: 440, width: 500, height: 500)
            label2.text = info.description2
            label2.numberOfLines = 0
            mainView.addSubview(button)
            mainView.addSubview(label1)
            mainView.addSubview(label2)
        } else if (selectedCell == 4) {
            let label = UILabel()
            label.frame = CGRect(x: 20, y: -50, width: 500, height: 500)
            label.text = info.description
            label.numberOfLines = 0
            mainView.addSubview(label)
        }
        }

    @IBAction func closeModal(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
