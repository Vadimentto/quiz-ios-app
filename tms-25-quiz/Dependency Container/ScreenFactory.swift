//
//  ScreenFactory.swift
//  tms-25-quiz
//
//  Created by Vadym Potapov on 28.10.2022.
//

import Foundation
import UIKit

//Класс-сервис - абстрактная фабрика по созданию экранов

//ScreenFactory - input interface
protocol ScreenFactory {
    
    func makeStandardGameScreen() -> GameVC
    func makeFastGameScreen() -> FastGameVC
    func makeAuthScreen() -> AuthVC
    func makeMainScreen() -> MainVC
}

class ScreenFactoryImpl: ScreenFactory {
    
    func makeStandardGameScreen() -> GameVC {
        
        //let jsonService = JsonServiceImpl()
        let questionProvider = QuestionsProviderImpl.shared
        
        let gameVC = GameVC(questionProvider: questionProvider) //Dependency injection -> через инициализатор
        
        return gameVC
    }
    
    func makeFastGameScreen() -> FastGameVC {
        
        //let jsonService = JsonServiceImpl()
        let questionProvider = QuestionsProviderImpl.shared
        
        let fastGameVC = FastGameVC(questionProvider: questionProvider) //Dependency injection -> через инициализатор
        
        return fastGameVC
    }
    
    func makeAuthScreen() -> AuthVC {
        
        let authVC = AuthVC()
        return authVC
    }
    
    func makeMainScreen() -> MainVC {
        
        let mainVC = MainVC()
        return mainVC
    }
    
    
    
}
