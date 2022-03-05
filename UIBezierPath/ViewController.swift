//
//  ViewController.swift
//  UIBezierPath
//
//  Created by Chu Go-Go on 2022/3/1.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var GreenSlider: UISlider!
    @IBOutlet weak var BlueSlider: UISlider!
    @IBOutlet weak var AlphaSlider: UISlider!
    @IBOutlet weak var redLB: UILabel!
    @IBOutlet weak var greenLB: UILabel!
    @IBOutlet weak var blueLB: UILabel!
    @IBOutlet weak var alphaLB: UILabel!
    @IBOutlet weak var circularProgressRingVW: UIView!
    @IBOutlet weak var BluePercentLB: UILabel!
    @IBOutlet weak var redPercentLB: UILabel!
    @IBOutlet weak var greenPercentLB: UILabel!
    //    設定角度
    let aDegree = CGFloat.pi / 180
    //    設定邊匡粗度
    let lineWidth: CGFloat = 10
    //    設定他的半徑長度
    let radius: CGFloat = 80
    //    設定起始的角度
    let starDegree: CGFloat = 0
    let redStarDegree: CGFloat = 120
    let greenStarDegree: CGFloat = 240
//    設定起始顏色
    var red:Float  =  255 / 255
    var green:Float = 255 / 255
    var blue:Float = 255 / 255
    //    先宣告屬性 才不會重疊
    let circleLayer = CAShapeLayer()
    let bluepercentTageLayer = CAShapeLayer()
    let greenPercentTageLayer = CAShapeLayer()
    let redPercentTageLayer = CAShapeLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        //        在一開始把layer加入到view裡面
        circularProgressRing()
        circularProgressRingVW.layer.addSublayer(circleLayer)
        circularProgressRingVW.layer.addSublayer(bluepercentTageLayer)
        circularProgressRingVW.layer.addSublayer(redPercentTageLayer)
        circularProgressRingVW.layer.addSublayer(greenPercentTageLayer)
        circularProgressRingVW.backgroundColor = UIColor.clear
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeColor(_ sender: UISlider) {
        circularProgressRing()
        changeBackGroundColor()
    }
    @IBAction func resetButton(_ sender: Any) {
        red =  1
        green  = 1
        blue = 1
        redSlider.value = 1
        GreenSlider.value = 1
        BlueSlider.value = 1
        AlphaSlider.value = 1
        view.backgroundColor = UIColor.white
        BluePercentLB.text = "B:100%"
        redPercentLB.text = "R:100%"
        greenPercentLB.text = "G:100%"
        redLB.text = "255/255"
        greenLB.text = "255/255"
        blueLB.text = "255/255"
        alphaLB.text = "1"
        circularProgressRing()

    }
    
//    製作圓型圖
    func circularProgressRing() {
        //        設定一個圓以及他的半徑周長
        let circlePath = UIBezierPath(ovalIn: CGRect(x: lineWidth, y: lineWidth, width: radius * 2, height: radius * 2))
        //在設定他的 circleLayer.path
        circleLayer.path = circlePath.cgPath
        //        設定圓圈顏色
        circleLayer.strokeColor = UIColor.clear.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
        //        設定粗度
        circleLayer.lineWidth = lineWidth
        //        建立藍色的線條用你的slider控制
        let bluePercentTage = blue * 100
        //設定線條的基準點
        let bluepercentTagePath = UIBezierPath(arcCenter: CGPoint(x: lineWidth + radius, y: lineWidth + radius), radius: radius, startAngle: aDegree * starDegree, endAngle: aDegree * (starDegree + 120 * CGFloat(bluePercentTage / 100)), clockwise: true)
//        print("\n\n\nendAngle: aDegree * (starDegree + 120 * CGFloat(bluePercentTage / 100)):\( aDegree * (starDegree + 120 * CGFloat(bluePercentTage / 100)))")
//        讓線條顯示在.path上面
        bluepercentTageLayer.path = bluepercentTagePath.cgPath
//        設定顏色
        bluepercentTageLayer.strokeColor = UIColor(red: 0, green: 0, blue: 1, alpha:CGFloat(AlphaSlider.value)).cgColor
//        設定粗度
        bluepercentTageLayer.lineWidth = lineWidth
//        設定背景顏色
        bluepercentTageLayer.fillColor = UIColor.clear.cgColor
//        設定先顯示的％數
        BluePercentLB.text = "B:\(String(format: "%.0f", bluePercentTage))%"

        let redPercentTage = red * 100
        let redPercentTagePath = UIBezierPath(arcCenter: CGPoint(x: lineWidth + radius, y: lineWidth + radius), radius: radius, startAngle:aDegree * redStarDegree, endAngle: aDegree * (redStarDegree + 120 * CGFloat(redPercentTage / 100)), clockwise: true)
        
        redPercentTageLayer.path = redPercentTagePath.cgPath
        redPercentTageLayer.strokeColor = UIColor(red: 1, green: 0, blue: 0, alpha: CGFloat(AlphaSlider.value)).cgColor
        redPercentTageLayer.lineWidth = lineWidth
        redPercentTageLayer.fillColor = UIColor.clear.cgColor
        let greenPercentTage = green * 100
        let greenPercentTagePath = UIBezierPath(arcCenter: CGPoint(x: lineWidth + radius, y: lineWidth + radius), radius: radius, startAngle: aDegree * greenStarDegree, endAngle: aDegree * (greenStarDegree + 120 * CGFloat(greenPercentTage / 100)), clockwise: true)
        
        greenPercentTageLayer.path = greenPercentTagePath.cgPath
        greenPercentTageLayer.strokeColor = UIColor(red: 0, green: 1, blue: 0, alpha: CGFloat(AlphaSlider.value)).cgColor
        greenPercentTageLayer.lineWidth = lineWidth
        greenPercentTageLayer.fillColor = UIColor.clear.cgColor
        
  
        redPercentLB.text = "R:\(String(format: "%.0f", redPercentTage))%"
        greenPercentLB.text = "G:\(String(format: "%.0f", greenPercentTage))%"
        print("藍色度數\(bluePercentTage)")
        print("紅色度數\(redPercentTage)")
    }
    
    func changeBackGroundColor(){
//        顏色的值會等於Slider.value
        red = redSlider.value
        green = GreenSlider.value
        blue = BlueSlider.value
//        設定如何調背景顏色
        view.backgroundColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(AlphaSlider.value))
//        當改變值時你的label的值也會跟著改變
        redLB.text = "\(String(format: "%.0f", red * 255))/255"
        greenLB.text = "\(String(format: "%.0f", green * 255))/255"
        blueLB.text = "\(String(format: "%.0f", blue * 255))/255"
        alphaLB.text = String(format: "%.1f", AlphaSlider.value)
    }
}

