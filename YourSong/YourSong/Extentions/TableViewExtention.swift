//
//  TableViewExtention.swift
//  YourSong
//
//  Created by Begum Unal on 10.05.2023.
//

import Foundation
import UIKit

extension CustomTableView : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            _ = CustomTableViewFirstCell(style: .default, reuseIdentifier: Constants.customTableFirstCellID)
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.customTableFirstCellID, for: indexPath) as! CustomTableViewFirstCell
            
            return cell
        }else{
            _ = CustomTableViewCell(style: .default, reuseIdentifier: Constants.customTableCellID)
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.customTableCellID, for: indexPath) as! CustomTableViewCell
            
            if let model = model as? AlbumDatum{
                cell.customView.label.text = model.name
                if let url = URL(string: model.picture){
                    if let imageData = try? Data(contentsOf: url) {
                        if let image = UIImage(data: imageData) {
                            cell.imageView!.image = image
                        }
                    }
                }
            }else{
                print("dönüştüremedi")
            }
            
            return cell
        }
        

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0{
            return 200
        }else{
            return 70 // hücre yüksekliği
        }
        
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10 // hücreler arasındaki boşluk yüksekliği
    }
    
}
