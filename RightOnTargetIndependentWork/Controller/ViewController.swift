//
//  ViewController.swift
//  RightOnTargetIndependentWork
//
//  Created by Егор Астахов on 14.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    // Лейбл числа, который будет обновляться каждый раз когда начинается новая игра или новый уровень
    @IBOutlet var theHiddenNumber: UILabel!
    // Слайдер с помощью которого мы будет играть в игру в саму игру перемещая его
    @IBOutlet var slider: UISlider!
    
    // MARK: - Properties
    var game: CurrentGame!
    let backNumberButton = UIBarButtonItem()
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // При загрузке приложения создаем экземпляр Класса, чтобы лишний раз не нажимать на кнопку
        game = CurrentGame(startValue: 1, endValue: 50, rounds: 5)
        updatingTheTextNumber(newText: String(game.currentRandomValue))
        // Меняем текст на кнопке назад
        backNumberButton.title = "Назад"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backNumberButton
    }
    
    // Обновление текстового лейбла для того чтобы отобразилось новое загаданное число
    func updatingTheTextNumber(newText: String) {
        theHiddenNumber.text = newText
    }
    
    // Алерт который показывает сколько очков мы заработали с возможность нажать на кнопку и начать новую игру
    func showAlert(score: Int) {
        // Добавляет сам алерт (Экземпляр класса)
        let alert = UIAlertController(title: "Игра окончена", message: "Вы заработали \(score) очков", preferredStyle: .alert)
        // Происходит управление кнопкой (Добавлям тайтл на кнопку и стиль)
        alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: nil))
        // Добавляет на вью контроллер(self) алерт, с помощью present
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Action
    
    // ПРИ НАЖАТИИ НА КНОПКУ
    @IBAction func verificationButton() {
        // высчитывается количество очков заработанных пользователем
        game.calculateScore(with: Int(slider.value))
        // Проверяется закончилась игра или нет. Если не закончилась, то начинается новый уровень
        if game.isGameEnded {
            showAlert(score: game.numberOfPoints)
            game.restartGame()
        } else {
            game.newLevel()
        }
        // В любом из двух случаев(Когда игра началась заново или когда начался новый уровень мы обновляем лейбл)
        updatingTheTextNumber(newText: String(game.currentRandomValue))
    }

    
    
}

