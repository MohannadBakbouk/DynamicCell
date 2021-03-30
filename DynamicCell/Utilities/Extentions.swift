//
//  Extentions.swift
//  DynamicCell
//
//  Created by Mohannad on 28.03.2021.
//

import UIKit

enum ConstraintEdge {
    case right
    case left
    case top
    case bottom
}

extension  UIView {
    func anchor(top : NSLayoutYAxisAnchor? , paddingTop : CGFloat , bottom : NSLayoutYAxisAnchor? , paddingBottom : CGFloat , left: NSLayoutXAxisAnchor?, paddingLeft: CGFloat, right: NSLayoutXAxisAnchor?, paddingRight: CGFloat, width: CGFloat, height: CGFloat){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if let left = left {
            leadingAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let right = right {
            trailingAnchor.constraint(equalTo: right, constant: paddingRight).isActive = true
        }
        
        if  width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if  height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        
        }
    }
    
    func proportionalSize(width : NSLayoutDimension? , widthPercent : CGFloat,
                          height : NSLayoutDimension? , heightPercent : CGFloat)  {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if  let width = width {
            widthAnchor.constraint(equalTo: width , multiplier: widthPercent).isActive = true
        }
        
        if  let height = height {
            heightAnchor.constraint(equalTo: height , multiplier: heightPercent).isActive = true
        }
    }
    
    
    
    
    func setSize( width : CGFloat ,  height : CGFloat)  {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if  width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if  height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        
        }
    }
    
    
    func center(centerX : NSLayoutXAxisAnchor? , centerY : NSLayoutYAxisAnchor?)  {
        
        self.center(centerX: centerX, paddingX: 0, centerY: centerY, paddingY: 0)
       
    }
    
    func center(centerX : NSLayoutXAxisAnchor? , paddingX : CGFloat   , centerY : NSLayoutYAxisAnchor? , paddingY : CGFloat)  {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let centerX = centerX {
         centerXAnchor.constraint(equalTo: centerX , constant: paddingX).isActive = true
        }
        
        if let centerY = centerY {
         centerYAnchor.constraint(equalTo: centerY , constant: paddingY).isActive = true
        }
    }
    
    
    func addHConstraint(const: NSLayoutXAxisAnchor?, edgeConst : ConstraintEdge ,  padding: CGFloat = 0 ) -> NSLayoutConstraint?{
        
        if let edge = const , edgeConst == .right   {
            let actualConst =   trailingAnchor.constraint(equalTo: edge, constant: padding)
            actualConst.isActive = true
            return actualConst
            
        }
        
        else if let edge = const , edgeConst == .left   {
            let actualConst =  leadingAnchor.constraint(equalTo: edge, constant: padding)
            actualConst.isActive = true
            return actualConst
            
        }
        return nil
    }
    
    
    func addVConstraint(const: NSLayoutYAxisAnchor?, edgeConst : ConstraintEdge ,  padding: CGFloat = 0 ) -> NSLayoutConstraint?{
        
        if let edge = const , edgeConst == .top   {
            let actualConst =  topAnchor.constraint(equalTo: edge, constant: padding)
            actualConst.isActive = true
            return actualConst
            
        }
        
        else if let edge = const , edgeConst == .bottom   {
            let actualConst =  bottomAnchor.constraint(equalTo: edge, constant: padding)
            actualConst.isActive = true
            return actualConst
            
        }
        return nil
    }
}


extension UIColor {
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
    
    static var mainColor : UIColor {
        return UIColor(hexString: "#27ae60")
    }
    
}

extension UICollectionView {
    
    func setMessage(_ message : String , icon : String){
        
        let view = UIView()
        let size = self.frame
        self.backgroundView = view
        
        let msgLab = UILabel()
        msgLab.textAlignment = .center
        msgLab.textColor = .lightGray
        msgLab.numberOfLines = 2
        msgLab.text = message
        view.addSubview(msgLab)

     
        let img  = UIImageView()
        img.image = UIImage(systemName: icon)!
        img.tintColor = .lightGray
        img.contentMode = .scaleAspectFit
        view.addSubview(img)
        
        img.translatesAutoresizingMaskIntoConstraints = false
        msgLab.translatesAutoresizingMaskIntoConstraints = false

        img.setSize(width: 50, height: 50)
        img.center(centerX: view.centerXAnchor , paddingX: 0 , centerY: view.centerYAnchor , paddingY: -50)
        msgLab.anchor(top: img.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: view.leadingAnchor, paddingLeft: 10, right: view.trailingAnchor, paddingRight: -10, width: 0, height: 30)
    
    }
    
    func toggleActivityIndicator()  {
        
        if let indicator = backgroundView as? UIActivityIndicatorView {
            indicator.stopAnimating()
            indicator.removeFromSuperview()
        }
        else {
            let indicator = UIActivityIndicatorView()
            indicator.style = .whiteLarge
            indicator.color = .mainColor
            indicator.hidesWhenStopped = true
            backgroundView = indicator
            indicator.startAnimating()
        }
    }
}












