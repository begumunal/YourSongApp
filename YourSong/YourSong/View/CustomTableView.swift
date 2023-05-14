//
//  CustomTableView.swift
//  YourSong
//
//  Created by Begum Unal on 10.05.2023.
//

import Foundation
import UIKit

class CustomTableView: UITableView {
    var imageCache = [String: UIImage]()
    var model : AnyObject?
    init(frame: CGRect, style: UITableView.Style, model: AnyObject) {
        self.model = model 
        super.init(frame: frame, style: style)
        register(CustomTableViewCell.self, forCellReuseIdentifier: Constants.customTableCellID)
        register(CustomTableViewFirstCell.self, forCellReuseIdentifier: Constants.customTableFirstCellID)
        self.separatorStyle = .none
        delegate = self
        dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        register(CustomTableViewCell.self, forCellReuseIdentifier: Constants.customTableCellID)
        
        
    }
    
}
