//
//  ViewController.swift
//  familyclock
//
//  Created by Alexis Ferrante on 4/23/19.
//  Copyright © 2019 Alexis Ferrante. All rights reserved.
//

import UIKit
import FirebaseDatabase
import GoogleSignIn

class ViewController: UIViewController {

    @IBOutlet weak var imageOutlet: UIImageView!

    var anchor: UIView! = UIView.init()
    var anchor2: UIView! = UIView.init()
    var anchor3: UIView! = UIView.init()
    var anchor4: UIView! = UIView.init()
    var anchor5: UIView! = UIView.init()
    var anchor6: UIView! = UIView.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let ref = Database.database().reference()

        anchor = createAnchor(anchor: anchor)
        anchor.backgroundColor = UIColor.orange
        anchor2 = createAnchor(anchor: anchor2)
        anchor2.backgroundColor = UIColor.red
        anchor3 = createAnchor(anchor: anchor3)
        anchor3.backgroundColor = UIColor.green
        anchor4 = createAnchor(anchor: anchor4)
        anchor4.backgroundColor = UIColor.cyan
        anchor5 = createAnchor(anchor: anchor5)
        anchor5.backgroundColor = UIColor.magenta
        anchor6 = createAnchor(anchor: anchor6)
        anchor6.backgroundColor = UIColor.yellow
        rotate()
        

        //set data
        ref.child("someid").setValue("alexis")
        // Do any additional setup after loading the view, typically from a nib.

        //retrieve data
        ref.child("someid").observeSingleEvent(of: .value){
            (snapshot) in
            let name = snapshot.value as? String
            print(name)
        }
    }
    
    func createAnchor(anchor: UIView) -> UIView {
        let anchorLength = 110
        anchor.center = self.view.center
        anchor.layer.bounds = CGRect(x: 0, y: 0, width: 3, height: anchorLength)
        anchor.layer.anchorPoint = CGPoint(x: 1, y: 1)
        anchor.layer.cornerRadius = 1
        self.view.addSubview(anchor)
        return anchor
    }
    
    func rotate() {
        
        UIView.animate(withDuration: 3) {
            self.anchor2.transform = CGAffineTransform(rotationAngle: .pi / 3.2)
            self.anchor3.transform = CGAffineTransform(rotationAngle: .pi)
            self.anchor4.transform = CGAffineTransform(rotationAngle: -.pi / 3.5)
            self.anchor5.transform = CGAffineTransform(rotationAngle: .pi / 1.5)
            self.anchor6.transform = CGAffineTransform(rotationAngle: -.pi / 1.5)
        }
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            anchor.center = self.view.center
        }
    }
   
}

class MyView: UIView {
    
    
    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()!
        
        ctx.translateBy (x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        ctx.scaleBy (x: 1, y: -1)
        
        drawText(context: ctx, text: "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~", radius: 198, angle: -.pi / 5.5, color: UIColor.white, font: UIFont.init(name: "Zapfino", size: 18)!, flip: false)
        drawText(context: ctx, text: "HOME 🏠", radius: 165, angle: -.pi / 5.8, color: UIColor.white, font: UIFont.init(name: "Zapfino", size: 16.5)!, flip: false)
        drawText(context: ctx, text: "WORK 🗄️", radius: 160, angle: .pi / 5.5, color: UIColor.white, font: UIFont.init(name: "Zapfino", size: 16.5)!, flip: true)
        drawText(context: ctx, text: "LOST ❓", radius: 160, angle: .pi / 2, color: UIColor.white, font: UIFont.init(name: "Zapfino", size: 16.5)!, flip: true)
        drawText(context: ctx, text: "SCHOOL 🏫", radius: 160, angle: -.pi / 2, color: UIColor.white, font: UIFont.init(name: "Zapfino", size: 16.5)!, flip: false)
        drawText(context: ctx, text: "GYM 💪🏼", radius: 160, angle: .pi / 0.85, color: UIColor.white, font: UIFont.init(name: "Zapfino", size: 16.5)!, flip: false)
        drawText(context: ctx, text: "CLINIC 🏥", radius: 160, angle: -.pi / 0.85, color: UIColor.white, font: UIFont.init(name: "Zapfino", size: 16.5)!, flip: true)
    }
    
    func drawText(context: CGContext, text str: String, radius r: CGFloat, angle delta: CGFloat, color c: UIColor, font: UIFont, flip: Bool){
       
        
        let characters: [String] = str.map { String($0) }
        let charsAmount = characters.count
        let attributes = [NSAttributedString.Key.font: font]
        
        var word: [CGFloat] = []
        var totalWords: CGFloat = 0
        
        
        for i in 0 ..< charsAmount {
            word += [distanceToWord(characters[i].size(withAttributes: attributes).width, radius: r)]
            totalWords += word[i]
        }
        
        let direction: CGFloat = flip ? -1 : 1
        let slope: CGFloat = flip ? -.pi / 2 : .pi / 2
        
        var theta = delta - direction * totalWords / 2
        
        for i in 0 ..< charsAmount {
            theta += direction * word[i] / 2
            
            center(context: context, text: characters[i], radius: r, angle: theta, colour: c, font: font, inclination: theta + slope)
            
            theta += direction * word[i] / 2
        }
    }
    
    func distanceToWord(_ chord: CGFloat, radius: CGFloat) -> CGFloat {
        
        return asin(chord / (radius * 2)) * 2
    }
    
    func center(context: CGContext, text str: String, radius r: CGFloat, angle theta: CGFloat, colour c: UIColor, font: UIFont, inclination: CGFloat) {
        
        let attributes = [NSAttributedString.Key.foregroundColor: c, NSAttributedString.Key.font: font]
        let wordOffset = str.size(withAttributes: attributes)
        
        context.saveGState()
        context.scaleBy(x: 1, y: -1)
        context.translateBy(x: r * cos(theta), y: -(r * sin(theta)))
        context.rotate(by: -inclination)
        
        context.translateBy (x: -wordOffset.width / 2, y: -wordOffset.height / 2)
        str.draw(at: CGPoint(x: 0, y: 0), withAttributes: attributes)
        context.restoreGState()
    }
}

