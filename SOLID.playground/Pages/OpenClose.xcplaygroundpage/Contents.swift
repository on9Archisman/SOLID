import Foundation

/* This below approach is not a good appoarch, if you now want to introduced an Area of a CIRCLE then you again will going to create a another function of CIRCLE inside AreaCalculator which is not a best practise, you need to make it more generic in implementation, so here on the below MARK side we use Open Closed Principle (Open for Extension and Closed for Modification) */

class Rectangle {
    
    let width: Double
    let height: Double
    
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
    
    func calculateArea() -> Double {
        return width * height
    }
}

class Sqare {
    
    let side: Double
    
    init(side: Double) {
        self.side = side
    }
    
    func calculateArea() -> Double {
        return 4 * side
    }
}

class AreaCalculator {
    
    func getArea(from rectangle: Rectangle) -> Double {
        return rectangle.calculateArea()
    }
    
    func getArea(from square: Sqare) -> Double {
        return square.calculateArea()
    }
}

let objRectangle = Rectangle(width: 10, height: 10)

let objSqare = Sqare(side: 10)

let objAreaCalculator = AreaCalculator()
print("Bad Implementation Area of Rectangle =", objAreaCalculator.getArea(from: objRectangle))
print("Bad Implementation Area of Square =", objAreaCalculator.getArea(from: objSqare))

// MARK: - OCP

protocol Shape {
    func calculateArea() -> Double
}

class Rectangle_OCP: Shape {
    
    let width: Double
    let height: Double
    
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
    
    func calculateArea() -> Double {
        return width * height
    }
}

class Sqare_OCP: Shape {
    
    let side: Double
    
    init(side: Double) {
        self.side = side
    }
    
    func calculateArea() -> Double {
        return side * side
    }
}

class Circle_OCP: Shape {
    
    let radious: Double
    
    init(radious: Double) {
        self.radious = radious
    }
    
    func calculateArea() -> Double {
        return Double.pi * pow(radious, 2)
    }
}

class AreaCalculator_OCP {
    
    func getArea(from shape: Shape) -> Double {
        return shape.calculateArea()
    }
}

let objRectangle_OCP = Rectangle_OCP(width: 10, height: 10)

let objSqare_OCP = Sqare_OCP(side: 10)

let objCircle_OCP = Circle_OCP(radious: 10)

let objAreaCalculator_OCP = AreaCalculator_OCP()

print("Good Implementation Area of Rectangle =", objAreaCalculator_OCP.getArea(from: objRectangle_OCP))
print("Good Implementation Area of Square =", objAreaCalculator_OCP.getArea(from: objSqare_OCP))
print("Good Implementation Area of Circle =", objAreaCalculator_OCP.getArea(from: objCircle_OCP))
