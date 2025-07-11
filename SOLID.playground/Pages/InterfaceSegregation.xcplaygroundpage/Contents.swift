import UIKit

/* Here you can see that human protocol having four methods, our class Person and Lion both inherites that protocol but for a Person all of these four function are justified but for Lion the goToWork & goToSchool methods are meaning less so this is called FAT protocol implementation where a class or a structure composite a protocol but few of the functions are not in use or invalid in their use purpose. To correct this knowladge there is a concept that is called INTERFACE SEGREGATION PRINCIPLE where you means a class or structure should inherite that protocol only which are menaningful to them, let solve this on the below marked section */

protocol Human {
    func eat()
    func sleep()
    func goToWork()
    func goToSchool()
}

struct Person: Human {
    func eat() {}
    
    func sleep() {}
    
    func goToWork() {}
    
    func goToSchool() {}
}

struct Lion: Human {
    func eat() {}
    
    func sleep() {}
    
    func goToWork() {}
    
    func goToSchool() {}
}

// MARK: - ISP

protocol Mammal_ISP {
    func eat()
    func sleep()
}

protocol Human_ISP: Mammal_ISP {
    func goToWork()
    func goToSchool()
}

protocol Animal_ISP: Mammal_ISP {
    func hunt()
}

struct Person_ISP: Human_ISP {
    func eat() {}
    
    func sleep() {}
    
    func goToWork() {}
    
    func goToSchool() {}
}

struct Lion_ISP: Animal_ISP {
    func eat() {}
    
    func sleep() {}
    
    func hunt() {}
}
