//
//  main.swift
//  Lesson 4
//
//  Created by Сергей Беляков on 14.03.2021.
//

import Foundation

//MARK: -

class Car {
    
    enum Color: String {
        case black = "black"
        case darkGray = "darkGray"
        case lightGray = "lightGray"
        case white = "white"
        case gray = "gray"
        case red = "red"
        case green = "green"
        case blue = "blue"
        case cyan = "cyan"
        case yellow = "yellow"
        case magenta = "magenta"
        case orange = "orange"
        case purple = "purple"
        case brown = "brown"
    }
    
    enum Transmission: String {
        case auto = "автомат"
        case manual = "механика"
    }
    
    enum DoorState: String {
        case open = "открыты"
        case closed = "закрыты"
    }
    
    enum EngineState: String {
        case running = "запущен"
        case stopped = "заглушен"
    }
    
    
    let color: Color
    let model: String
    let mp3: Bool
    let transmission: Transmission
    var doorState: DoorState
    var trunkVolume: Double
    var engineState: EngineState
    
    
    init(color: Color, model: String, mp3: Bool, transmission: Transmission, doorState: DoorState, trunkVolume: Double, engine: EngineState) {
        self.color = color
        self.model = model
        self.mp3 = mp3
        self.transmission = transmission
        self.doorState = doorState
        self.trunkVolume = trunkVolume
        self.engineState = engine
    }
    
    
    func printInfo() {}
    func doorSwitch(_ door: DoorState) {}
    func engineSwitch(_ engine: EngineState) {}
    
}

//MARK: -

class TrunkCar: Car {
    
    enum TrailerState: String {
        case installed = "установлен"
        case uninstalled = "снят"
    }
    
    var trailerState: TrailerState
    let trailerVolume: Double
    var usedTrunkVolume: Double
    var totalTrunkVolume: Double {
        get {
            if trailerState == .installed {
                return trunkVolume + trailerVolume
            } else { return trunkVolume }
        }
    }
    
    init(color: Color, model: String, mp3: Bool, transmission: Transmission, doorState: DoorState, trunkVolume: Double, engine: EngineState, trailerState: TrailerState, trailerVolume: Double, usedTrunkVolume: Double) {
        self.trailerState = trailerState
        self.trailerVolume = trailerVolume
        self.usedTrunkVolume = usedTrunkVolume
        super.init(color: color, model: model, mp3: mp3, transmission: transmission, doorState: doorState, trunkVolume: trunkVolume, engine: engine)
    }
    
    
    override func printInfo() {
        print("---------------------------------")
        print("Информация:")
        print("Марка: \(self.model)")
        print("Объем основного кузова: \(self.trunkVolume)")
        print("Прицеп: \(self.trailerState.rawValue)")
        print("Объем прицепа: \(self.trailerVolume)")
        print("Общий объем кузова: \(self.totalTrunkVolume)")
        print("Двигатель: \(self.engineState.rawValue)")
        print("Загрузка кузова: \(self.usedTrunkVolume) из \(self.totalTrunkVolume)")
        print("---------------------------------")
    }
    
    
    override func doorSwitch(_ door: DoorState) {
        doorState = door
        print("Двери грузовика были \(doorState.rawValue)")
    }
    
    
    override func engineSwitch(_ engine: EngineState) {
        engineState = engine
        print("Двигатель грузовика был \(engine.rawValue)")
    }
    
    
    func trailerSwitch(_ trailer: TrailerState) {
        trailerState = trailer
        print("Прицеп был \(trailerState.rawValue)")
        print("Теперь объем кузова: \(totalTrunkVolume)")
    }
    
    
    func trunkLoad(_ cargo: Double) {
        print("---------------------------------")
        print("Пытаемся загрузить груз объемом \(cargo)")
        if (usedTrunkVolume + cargo) <= totalTrunkVolume {
            usedTrunkVolume += cargo
            print("Груз загружен.")
            printTrunkLoad()
        }
        else if (usedTrunkVolume + cargo) > totalTrunkVolume && trailerState == .uninstalled {
            print("Недостаточно места. Свободно только \(totalTrunkVolume - usedTrunkVolume). Выгрузите \(cargo - (totalTrunkVolume - usedTrunkVolume)), или установите прицеп")
            printTrunkLoad()
        } else if (usedTrunkVolume + cargo) > totalTrunkVolume && trailerState == .installed {
            print("Недостаточно места. Свободно только \(totalTrunkVolume - usedTrunkVolume). Выгрузите \(cargo - (totalTrunkVolume - usedTrunkVolume))")
            printTrunkLoad() }
    }
    
    
    func trunkUnload(_ cargo: Double) {
        print("---------------------------------")
        print("Выгружаем груз объемом \(cargo)")
        if (usedTrunkVolume - cargo) >= 0 {
            usedTrunkVolume -= cargo
            print("Груз выгружен.")
            printTrunkLoad()
        }
        else if (usedTrunkVolume - cargo) < 0 {
            print("Вы пытаетесь выгрузить больше груза, чем есть в багажнике. Будет выгружен весь оставшийся груз: \(usedTrunkVolume)")
            usedTrunkVolume = 0
            printTrunkLoad()
        }
    }
    
    
    func printTrunkLoad() {
        print("Загрузка багажника: \(usedTrunkVolume) из \(totalTrunkVolume)")
        print("Прицеп  сейчас \(trailerState.rawValue)")
        
        if usedTrunkVolume <= trunkVolume && trailerState == .installed {
            print("Если не планируете добавлять груз, прицеп можно отсоединить, так как объема основного кузова достаточно для текущего груза")
        }
    }
}

//MARK: -



var kamaz = TrunkCar(color: .black, model: "Kamaz", mp3: false, transmission: .manual, doorState: .closed, trunkVolume: 1000, engine: .stopped, trailerState: .uninstalled, trailerVolume: 1500, usedTrunkVolume: 300)

kamaz.printInfo()
kamaz.doorSwitch(.open)
kamaz.engineSwitch(.running)
kamaz.trunkLoad(1500)
kamaz.trailerSwitch(.installed)
kamaz.trunkLoad(1500)
kamaz.trunkUnload(800)
kamaz.trailerSwitch(.uninstalled)
kamaz.engineSwitch(.stopped)
kamaz.doorSwitch(.closed)
kamaz.printInfo()



var man = TrunkCar(color: .black, model: "Man", mp3: true, transmission: .auto, doorState: .closed, trunkVolume: 2000, engine: .running, trailerState: .uninstalled, trailerVolume: 3000, usedTrunkVolume: 0)

man.printInfo()
man.trunkLoad(3500)
man.trailerSwitch(.installed)
man.trunkLoad(3500)
man.trunkUnload(1500)
man.trailerSwitch(.uninstalled)
man.printInfo()


//MARK: -
class SportCar: Car {
    
    enum RoofState: String {
        case open = "открыта"
        case closed = "закрыта"
    }
    
    enum SpoilerState: String {
        case raised = "поднят"
        case lowered = "опущен"
    }
    
    
    var spoilerState: SpoilerState
    var roofState: RoofState
    
    
    init(color: Color, model: String, mp3: Bool, transmission: Transmission, doorState: DoorState, trunkVolume: Double, engine: EngineState, spoilerState: SpoilerState, roofState: RoofState) {
        
        self.spoilerState = spoilerState
        self.roofState = roofState
        super.init(color: color, model: model, mp3: mp3, transmission: transmission, doorState: doorState, trunkVolume: trunkVolume, engine: engine)
    }
    
    
    override func doorSwitch(_ door: DoorState) {
        doorState = door
        print("Двери спорткара были \(doorState.rawValue)")
    }
    
    
    override func engineSwitch(_ engine: EngineState) {
        engineState = engine
        print("Двигатель спорткара был \(engine.rawValue)")
    }
    
    
    override func printInfo() {
        print("---------------------------------")
        print("Информация:")
        print("Марка: \(self.model)")
        print("Цвет: \(self.model)")
        print("Магнитола: \(self.mp3 ? "есть" : "нет")")
        print("Трансмиссия: \(self.transmission.rawValue)")
        print("Двери: \(self.doorState.rawValue)")
        print("Объем багажника: \(self.trunkVolume)")
        print("Откидная крыша: \(self.roofState.rawValue)")
        print("Положение спойлера: \(self.spoilerState.rawValue)")
        print("Двигатель: \(self.engineState.rawValue)")
        print("---------------------------------")
    }
    
    
    func spoilerSwitch(_ spoiler: SpoilerState) {
        spoilerState = spoiler
        print("Спойлер был \(spoilerState.rawValue)")
    }
    
    
    func roofSwitch(_ roof: RoofState) {
        roofState = roof
        print("Откидная крыша была \(roofState.rawValue)")
    }
    
}

//MARK: -



var supra = SportCar(color: .red, model: "Toyota Supra", mp3: true, transmission: .auto, doorState: .closed, trunkVolume: 300, engine: .stopped, spoilerState: .lowered, roofState: .closed)

supra.printInfo()
supra.doorSwitch(.open)
supra.engineSwitch(.running)
supra.roofSwitch(.open)
supra.spoilerSwitch(.raised)
supra.printInfo()



var skyline = SportCar(color: .white, model: "Nissan Skyline", mp3: false, transmission: .auto, doorState: .closed, trunkVolume: 500, engine: .stopped, spoilerState: .lowered, roofState: .closed)

skyline.printInfo()
skyline.doorSwitch(.open)
skyline.roofSwitch(.open)
skyline.engineSwitch(.running)
skyline.spoilerSwitch(.raised)
skyline.engineSwitch(.stopped)
skyline.spoilerSwitch(.lowered)
skyline.doorSwitch(.closed)
skyline.printInfo()
