//
//  CellProtocol.swift
//  YourSong
//
//  Created by Begum Unal on 15.05.2023.
//

import Foundation

protocol CellProtocol: class {
    var indexPath: IndexPath? { get set }
    func didTapCell(at indexPath: IndexPath)
    func didTapLikeButton(at indexPath: IndexPath)
}
