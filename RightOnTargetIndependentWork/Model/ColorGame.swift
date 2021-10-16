//
//  ColorGame.swift
//  RightOnTargetIndependentWork
//
//  Created by Егор Астахов on 14.10.2021.
//

import Foundation
import UIKit

protocol ColorGameProtocol {
    // Переменная в которой будут находиться количество очков за все игры
    var numberOfColorPoints: Int { get }
    // Текущий цвет, который будет написан
    var currentRandomColor: String { get }
    // Проверка закончилась игра или нет
    var isColorGameEnded: Bool { get }
    // Максимальное количество очков
    var maxOfColorPoint: Int { get }
    
    // Метод, который запускает новый уровень
    func newColorLevel()
    // Метод который перезагружает игру
    func restartColorGame()
    // Метод который высчитывает результат(количество очков за раунд)
//    func scoringPoints(color: String)
    
}

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


class ColorGame: ColorGameProtocol {
    // Количество очков за игру
    var numberOfColorPoints: Int = 0
    // Текущий рандомный цвет из массива
    var currentRandomColor: String = ""
    
    // Максимальное количство очков за игру
    var maxOfColorPoint: Int = 0
    
    // Максимальное и минимальное количество уровней
    private var maxLevels: Int
    private var currentLevel: Int = 1
    
    init?(maxLevels: Int, maxOfColorPoint: Int) {
        self.maxLevels = maxLevels
        self.maxOfColorPoint = maxOfColorPoint
        currentRandomColor = massiveHexColors.removeFirst()
    }
    
    // Проверяет закончилась игра или нет
    var isColorGameEnded: Bool {
        if currentLevel >= maxLevels {
            return true
        } else {
            return false
        }
    }
    
    // Новый уровень, который дает текущему уровню + 1 и обновляет цвет кнопки
    func newColorLevel() {
        currentLevel += 1
        currentRandomColor = massiveHexColors.removeFirst() //Если удалить это то перестает меняться лейбл
    }
    
    // Перезагружает игру
    func restartColorGame() {
        numberOfColorPoints = 0
        currentLevel = 0
        newColorLevel()
    }
    
    // Массив HEX цветов
    var massiveHexColors = [
        "#E6E6FA",
        "#D8BFD8",
        "#DDA0DD",
        "#EE82EE",
        "#DA70D6",
        "#FF00FF",
        "#FF00FF",
        "#BA55D3",
        "#9370DB",
        "#8A2BE2",
        "#9400D3",
        "#9932CC",
        "#8B008B",
        "#800080",
        "#4B0082",
        "#6A5ACD",
        "#483D8B",
        "#F08080",
        "#FA8072",
        "#E9967A",
        "#FFA07A",
        "#DC143C",
        "#FF0000",
        "#B22222",
        "#8B0000",
        "#7FFF00",
        "#7CFC00",
        "#00FF00",
        "#32CD32",
        "#98FB98",
        "#90EE90",
        "#00FA9A",
        "#00FF7F",
        "#3CB371",
        "#2E8B57",
        "#228B22",
        "#008000",
        "#006400",
        "#9ACD32",
        "#6B8E23",
        "#808000",
        "#556B2F",
        "#66CDAA",
        "#8FBC8F",
        "#20B2AA",
        "#008B8B",
        "#008080",
        "#FFA07A",
        "#FF7F50",
        "#FF6347",
        "#FF4500",
        "#FF8C00",
        "#FFA500",
        "#00FFFF",
        "#00FFFF",
        "#E0FFFF",
        "#AFEEEE",
        "#7FFFD4",
        "#40E0D0",
        "#48D1CC",
        "#00CED1",
        "#5F9EA0",
        "#4682B4",
        "#B0C4DE",
        "#B0E0E6",
        "#ADD8E6",
        "#87CEEB",
        "#87CEFA",
        "#00BFFF",
        "#1E90FF",
        "#6495ED",
        "#7B68EE",
        "#4169E1",
        "#0000FF",
        "#0000CD",
        "#00008B",
        "#000080",
        "#191970",
        "#DCDCDC",
        "#D3D3D3",
        "#D3D3D3",
        "#C0C0C0",
        "#A9A9A9",
        "#A9A9A9",
        "#808080",
        "#808080",
        "#696969",
        "#696969",
        "#778899",
        "#778899",
        "#708090",
        "#708090",
        "#2F4F4F",
        "#2F4F4F",
        "#000000",
    ]


}
