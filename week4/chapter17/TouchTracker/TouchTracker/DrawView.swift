//
//  DrawView.swift
//  TouchTracker
//
//  Created by Kangsoo on 22/07/2017.
//  Copyright © 2017 Dough. All rights reserved.
//

import UIKit

class DrawView: UIView {
    @IBInspectable var currentLineColor: UIColor = UIColor.red {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var finishedLineColor: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var lineThickness: CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var currentLines = [NSValue: Line]()
    var finishedLines = [Line]()
    
    override func draw(_ rect: CGRect) {
        finishedLineColor.setStroke()
        for line in finishedLines {
            strokeLine(line: line)
        }
        
        currentLineColor.setStroke()
        for (_, line) in currentLines {
            strokeLine(line: line)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        
        for touch in touches {
            let locaton = touch.location(in: self)
            let newLine = Line(begin: locaton, end: locaton)
            let key = NSValue(nonretainedObject: touch)
            currentLines[key] = newLine
        }
        
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            currentLines[key]?.end = touch.location(in: self)
        }
        
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            if var line = currentLines[key] {
                line.end = touch.location(in: self)
                finishedLines.append(line)
                currentLines.removeValue(forKey: key)
            }
        }
        
        setNeedsDisplay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        
        currentLines.removeAll()
        setNeedsDisplay()
    }
    
    private func strokeLine(line: Line) {
        let path = UIBezierPath()
        path.lineWidth = lineThickness
        path.lineCapStyle = CGLineCap.round
        
        path.move(to: line.begin)
        path.addLine(to: line.end)
        path.stroke()
    }
}
