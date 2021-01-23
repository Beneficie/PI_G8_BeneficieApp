//
//  Extensions.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 21/11/20.
//

import UIKit

extension UIView{
   open func RoundView(){
        layer.cornerRadius = bounds.size.height/2
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
    
    open func setupShadow(opacity: Float = 0, radius: CGFloat = 0, offset: CGSize = .zero, color: UIColor = .black) {
           layer.shadowOpacity = opacity
           layer.shadowRadius = radius
           layer.shadowOffset = offset
           layer.shadowColor = color.cgColor
       }
}

extension UITextField{

    open func configureTextField(placeHolder: String){
        keyboardAppearance = .dark
        textColor = .white
        leftViewMode = .always
        borderStyle = .none
        attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
}
