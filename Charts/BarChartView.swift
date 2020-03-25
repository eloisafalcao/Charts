//
//  BarChartView.swift
//  Charts
//
//  Created by Eloisa Falcão on 25/03/20.
//  Copyright © 2020 Eloisa Falcão. All rights reserved.
//

import UIKit

class BarChartView: UIView {

    var values = [CGFloat]()
    var posY: CGFloat = 0.0
    var posX: CGFloat = 0.0
    var barHeight: CGFloat = 0.0
    var barWidth: CGFloat = 30.0
    let captionHeight: CGFloat = 10.0
    var normalizedValue: CGFloat = 0.0

    override func draw(_ rect: CGRect) {

        guard let context = UIGraphicsGetCurrentContext() else { return }

        for i in 0...10 {
            values.append(CGFloat(i))
        }

        //Encontrar o menor e o maior valor em values
        guard let maxValue = values.max() else { return }
        guard let minValue = values.min() else { return }

        values.forEach { (value) in

//            Agora sabemos que o gráfico tem dois comportamentos para se normalizar, um deles se o menor valor for 0 e outro se o menor valor for diferente de 0. A lógica é a mesma em ambos, a diferença agora é a variação dos valores.
            if minValue == 0 {
                normalizedValue = 1-((maxValue-value)/(maxValue-minValue))

            } else {
                normalizedValue = 0.1 + ((0.9*(value - minValue))/(maxValue-minValue))
            }

            barHeight = (normalizedValue*bounds.height)-captionHeight
            posY = bounds.height - barHeight

            //Criando cada barra
            let bar = CGRect(x: posX, y: posY, width: barWidth, height: barHeight)
            context.addRect(bar)
            context.setFillColor(UIColor.red.cgColor)
            context.fillPath()

            //Adicionando a legenda
            let caption = UILabel()
            caption.text = String(Double(value))
            caption.textAlignment = .center
            caption.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
            caption.frame = CGRect(x: posX, y: posY-captionHeight, width: barWidth, height: captionHeight)
            addSubview(caption)

            posX += barWidth + 5.0
        }
    }
}

