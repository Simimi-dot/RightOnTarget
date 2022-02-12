//
//  Game.swift
//  RightOnTargetIndependentWork
//
//  Created by Егор Астахов on 14.10.2021.
//

import Foundation

// Создаем протокол
protocol Game {
    // Количество очков за все завершенные раунды игры
    var numberOfPoints: Int { get }
    // Рандомное число
    var currentRandomValue: Int { get }
    // Переменная, которая позволит узнать, закончилась игра или нет
    var isGameEnded: Bool { get }
    
    // Метод который начинает следующий уровень
    func newLevel()
    // Метод который перезагружает игру
    func restartGame()
    // Метод подсчитывает количество заработанных очков за раунд
    func calculateScore(with: Int)
}


class CurrentGame: Game {
    var numberOfPoints: Int = 0
    
    // Минимальное и максимальное рандомное число
    private var minRandomValue: Int
    private var maxRandomValue: Int
    var currentRandomValue: Int = 0
    
    // Последний уровень и текущий уровень
    private var lastRound: Int
    private var currentLevel: Int = 1
    
    // Проверяет закончить игру или нет
    var isGameEnded: Bool {
        if currentLevel >= lastRound {
            return true
        } else {
            return false
        }
    }
    
    init?(startValue: Int, endValue: Int, rounds: Int) {
        // Проверяет чтобы стартовое число не могло быть больше последнего
        guard startValue <= endValue else {
            return nil
        }
        minRandomValue = startValue
        maxRandomValue = endValue
        lastRound = rounds
        currentRandomValue = self.getNewRandomValue()
    }
    
    // Метод загружает новый уровень (Обновляет рандомное значение и добавляет +1 к текущему уровню
    func newLevel() {
        currentRandomValue = self.getNewRandomValue()
        currentLevel += 1
    }
    
    // Метод перезагружает игру (Сбрасывает все количество очков, текущий уровень и запускает метод newLevel)
    func restartGame() {
        numberOfPoints = 0
        currentLevel = 0
        newLevel()
    }
    
    // Метод считает количество очков в зависимости от того где будет находиться слайдер
    func calculateScore(with value: Int) {
        if value > currentRandomValue {
            numberOfPoints = 50 - value + currentRandomValue
        } else if value < currentRandomValue {
            numberOfPoints = 50 - value + currentRandomValue
        } else {
            numberOfPoints += 50
        }
    }
    
    // Метод высчитывает рандомное число от 1 до 50
    func getNewRandomValue() -> Int {
        (minRandomValue...maxRandomValue).randomElement()!
    }
}
