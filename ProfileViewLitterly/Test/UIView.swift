//
//  UIView.swift
//  ProfileViewLitterly
//
//  Created by Joseph Sylvanovich on 4/13/19.
//  Copyright © 2019 Joseph Sylvanovich. All rights reserved.
//
import UIKit


@IBDesignable
class CustomSegmentedControl: UIControl {
    var buttons = [UIButton]()
    var selector: UIView!
    
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable
    var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable
    var selectorColor: UIColor = .darkGray {
        didSet{
            updateView()
        }
    }
    @IBInspectable
    var selectorTextColor: UIColor = .white {
        didSet{
            updateView()
        }
    }
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = 7
        
    }
    @IBInspectable
    var commaSeparatedButtonTitles: String = " " {
        didSet {
            updateView()
        }
    }
    @IBInspectable
    var textColor: UIColor = .lightGray{
        didSet {
            updateView()
        }
    }
    func updateView() {
        buttons.removeAll()
        subviews.forEach { $0.removeFromSuperview() }
        let buttonTitles = commaSeparatedButtonTitles.components(separatedBy: ",")
        
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        
        let selectorWidth = frame.width / CGFloat(buttonTitles.count)
        selector = UIView(frame: CGRect(x: 0, y: 0, width: selectorWidth, height: frame.height))
        selector.layer.cornerRadius = 7
        selector.backgroundColor = selectorColor
        addSubview(selector)
        
        
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        //stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        addSubview(stackView)
        
        //constraints of the button
        stackView.translatesAutoresizingMaskIntoConstraints = false //setting own constraints which
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    @objc func buttonTapped(button: UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            if btn == button {
                let selectorStartPosition = frame.width/CGFloat(buttons.count) * CGFloat(buttonIndex)
                UIView.animate(withDuration: 0.3, animations: {
                    self.selector.frame.origin.x = selectorStartPosition
                })
                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
        sendActions(for: .valueChanged)
        
    }
    
    
}
