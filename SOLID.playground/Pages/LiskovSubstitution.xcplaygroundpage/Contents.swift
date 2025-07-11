import UIKit

/* This below approach is not a good appoarch, if your parent class having any property or methods and being present in the child class if you are inheriting that parent class then you should not go for any parent class modification so here on the below MARK side we use Liskov Substitution Principle */

class Rectangle {
    
    var width: Double = 0
    var height: Double = 0
    
    func calculateArea() -> Double {
        return width * height
    }
}

class Sqare: Rectangle {
    
    override var width: Double {
        didSet {
            height = width
        }
    }
}

let objRectangle = Rectangle()
objRectangle.height = 10
objRectangle.width = 20
print("Bad Implementation Area of rectangle is: \(objRectangle.calculateArea())")

let objSqare = Sqare()
objSqare.width = 10
print("Bad Implementation Area of sqare is: \(objSqare.calculateArea())")

// MARK: - LSP

protocol Shape {
    var area: Double { get }
}

class Rectangle_LSP: Shape {
    
    var width: Double = 0
    var height: Double = 0
    
    var area: Double {
        return height * width
    }
}

class Square_LSP: Shape {
    
    var side: Double = 0
    
    var area: Double {
        return side * side
    }
}

let objRectangle_LSP = Rectangle_LSP()
objRectangle_LSP.height = 10
objRectangle_LSP.width = 20
print("Good Implementation Area of rectangle is: \(objRectangle_LSP.area)")

let objSquare_LSP = Square_LSP()
objSquare_LSP.side = 10
print("Good Implementation Area of square is: \(objSquare_LSP.area)")
