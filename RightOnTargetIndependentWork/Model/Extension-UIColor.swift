//
//  Extension-UIColor.swift
//  RightOnTargetIndependentWork
//
//  Created by Егор Астахов on 16.10.2021.
//

import Foundation
import UIKit

// Расширение UIColor в котором мы будем переводить из HEX(16-ти ричного представления цвета) значения цвета в обычное (RGB)
extension UIColor {
    convenience init?(hex: String) {
        // Избавляемся от пробелов и различных переносов
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        // Изменяем решетку на отсутсвие символа ПРИМЕР #007600 получется 007600
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        // Сохраняем длину нашей строки, потому что цвет может быть как из 6 цифр, так и из 8 (Мы можем передавать двумя цифрами нашу альфу(ПРОЗРАЧНОСТЬ НАШЕГО ЦВЕТА)
        let lenght = hexSanitized.count
        // Переменная RGB, которая будет отвечать за преобразование цвета (64 битное число)
        var rgb: UInt64 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        // альфа по умолчанию должна быть равна единице
        var a: CGFloat = 1.0
        // Теперь нам необходимо преобразовать нашу строку в 64 битное число
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }
        // Блоки, которые будут обрабатывать 6 цифр и 8 цифры, если пердаем еще и значение альфа
        if lenght == 6 {
            // логика перевода числа из 16-ти ричного формата в RGB
            // делим на 255, потому что у нас будут значения от 0 до 255
            // благодаря оператору & мы применили битовую маску чтобы отделить первыедва разряда
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            // таким образом мы перевели число из 16-ти ричного представления в систему RGB где каждый параметр является числом от 0 до 1, потому что мы делили число на 255
        } else if lenght == 8 {
            // Случай когда мы учитываем альфу
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
        } else {
            return nil
        }
        // Воспользуемся готовым конструктором и передадим значение rgb которые будут от 0 до 1
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
