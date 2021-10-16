//
//  ColorGameViewController.swift
//  RightOnTargetIndependentWork
//
//  Created by Егор Астахов on 14.10.2021.
//

import UIKit

class ColorGameViewController: UIViewController {
    
    
    // MARK: - Outlets
    // Лейбл в котором будет отображаться код цвета
    @IBOutlet weak var hexColorCode: UILabel!
    @IBOutlet var firstButton: UIButton!
    @IBOutlet var secondButton: UIButton!
    @IBOutlet var thirdButton: UIButton!
    @IBOutlet var fourthButton: UIButton!
    
    
    //MARK: - Properties
    var colorGame: ColorGame!
    var numberOfPoints: Int = 0
    var correctButtonTag: Int = 0
    var buttonsColletion: [UIButton]!
    var variableColor: String {
        colorGame.massiveHexColors.randomElement()!
    }
    let backColorButton = UIBarButtonItem()
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Создаем экземпляр класса с количеством уровней и максимальным количеством очков
        colorGame = ColorGame(maxLevels: 10, maxOfColorPoint: 250)
        // Даем лейблу текст в зависимости от currentRandomColor
        hexColorCode.text = colorGame.currentRandomColor
        // Создаем массив баттонов
        buttonsColletion = [firstButton, secondButton, thirdButton, fourthButton]
        // Делаем закругление углов у кнопок
        firstButton.layer.cornerRadius = 10
        secondButton.layer.cornerRadius = 10
        thirdButton.layer.cornerRadius = 10
        fourthButton.layer.cornerRadius = 10
        // Обновляем цвет кнопок
        updateButtons(secretColor: UIColor(hex: colorGame.currentRandomColor)!)
        // Меняем текст на кнопке назад
        backColorButton.title = "Назад"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backColorButton
    }
    
    // Метод обновления цветов кнопок в рандомной последовательности
    func updateButtons(secretColor: UIColor) {
        correctButtonTag = Array(1...4).randomElement()!
        buttonsColletion.forEach { button in
            if button.tag == correctButtonTag {
                button.backgroundColor = secretColor
            } else {
                let randomColorForOtherButtons = UIColor(hex: colorGame.massiveHexColors.randomElement()!)
                button.backgroundColor = randomColorForOtherButtons
            }
        }
    }
    
    // Обновляем текст лейбла
    func updateHexText(newText: String) {
        hexColorCode.text = newText
    }
    
    // Делаем алерт который выскочит в конце игры
    func showAlert(score: Int) {
        let alert = UIAlertController(title: "Игра окончена", message: "За эту игру вы заработали \(score) очков", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: -Action
    // Кнопки с помощью которых надо угадать цвет
    // ПРИ НАЖАТИИ НА ЛЮБУЮ КНОПКУ
    @IBAction func firstButtonSelection() {
        if firstButton.backgroundColor == UIColor(hex: colorGame.currentRandomColor) {
            numberOfPoints += 50
        } else {
            numberOfPoints -= 50
        }
        // Проверяем закончилась игра или нет
        if colorGame.isColorGameEnded {
            showAlert(score: numberOfPoints)
            colorGame.restartColorGame()
            updateButtons(secretColor: UIColor(hex: colorGame.currentRandomColor)!)
        } else {
            colorGame.newColorLevel()
            updateButtons(secretColor: UIColor(hex: colorGame.currentRandomColor)!)
            
        }
        // Обновляем текст в лейбле после каждого нажатия на кнопку
        updateHexText(newText: colorGame.currentRandomColor)
    }
    
    
    @IBAction func secondButtonSelection() {
        if secondButton.backgroundColor == UIColor(hex: colorGame.currentRandomColor) {
            numberOfPoints += 50
        } else {
            numberOfPoints -= 50
        }
        // Проверяем закончилась игра или нет
        if colorGame.isColorGameEnded {
            showAlert(score: numberOfPoints)
            colorGame.restartColorGame()
            updateButtons(secretColor: UIColor(hex: colorGame.currentRandomColor)!)
        } else {
            colorGame.newColorLevel()
            updateButtons(secretColor: UIColor(hex: colorGame.currentRandomColor)!)
            
        }
        // Обновляем текст в лейбле после каждого нажатия на кнопку
        updateHexText(newText: colorGame.currentRandomColor)
    }
    
    
    @IBAction func thirdButtonSelection() {
        if thirdButton.backgroundColor == UIColor(hex: colorGame.currentRandomColor) {
            numberOfPoints += 50
        } else {
            numberOfPoints -= 50
        }
        // Проверяем закончилась игра или нет
        if colorGame.isColorGameEnded {
            showAlert(score: numberOfPoints)
            colorGame.restartColorGame()
            updateButtons(secretColor: UIColor(hex: colorGame.currentRandomColor)!)
        } else {
            colorGame.newColorLevel()
            updateButtons(secretColor: UIColor(hex: colorGame.currentRandomColor)!)
            
        }
        // Обновляем текст в лейбле после каждого нажатия на кнопку
        updateHexText(newText: colorGame.currentRandomColor)
    }
    
    
    @IBAction func fourthButtonSelection() {
        if fourthButton.backgroundColor == UIColor(hex: colorGame.currentRandomColor) {
            numberOfPoints += 50
        } else {
            numberOfPoints -= 50
        }
        // Проверяем закончилась игра или нет
        if colorGame.isColorGameEnded {
            showAlert(score: numberOfPoints)
            colorGame.restartColorGame()
            updateButtons(secretColor: UIColor(hex: colorGame.currentRandomColor)!)
        } else {
            colorGame.newColorLevel()
            updateButtons(secretColor: UIColor(hex: colorGame.currentRandomColor)!)
            
        }
        // Обновляем текст в лейбле после каждого нажатия на кнопку
        updateHexText(newText: colorGame.currentRandomColor)
    }
    
}
