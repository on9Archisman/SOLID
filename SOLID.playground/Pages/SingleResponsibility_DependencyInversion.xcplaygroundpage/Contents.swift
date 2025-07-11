import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

// MARK: - Constant

private enum Constants {
    static let fetchEmployeeRecordsURL: String = "https://dummy.restapiexample.com/api/v1/employees"
    static let fetchRandomRecordsURL: String = {
        return "https://jsonplaceholder.typicode.com/posts"
    }()
}

print("Employee Records URL =", Constants.fetchEmployeeRecordsURL)
print("Random Records URL =", Constants.fetchRandomRecordsURL)

// MARK: - Model

// MARK: For Employess
struct Employee: Codable {
    let id: Int
    let employeeName: String
    let employeeSalary: Double
    let employeeAge: Int
    let profileImage: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case employeeName = "employee_name"
        case employeeSalary = "employee_salary"
        case employeeAge = "employee_age"
        case profileImage = "profile_image"
    }
}

struct EmployeeRecord: Codable {
    let status, message: String
    let data: [Employee]?
}

// MARK: For Randoms
struct RandomRecord: Codable {
    let userId, id: Int
    let title, body: String
}

// MARK: - Network Configuration

enum NetworkError: Error {
    case badURL
    case decodingError
    case invalidResponse
    case noData
    case urlSessionError(Error)
    
    func description() -> String {
        switch self {
        case .badURL:
            return "Bad URL"
        case .decodingError:
            return "Decoding Error"
        case .invalidResponse:
            return "Invalid Response"
        case .noData:
            return "No Data"
        case .urlSessionError(let error):
            return error.localizedDescription
        }
    }
}

protocol HttpHandlerProtocol {
    func getRecordsFromAPI<T: Codable>(from urlString: String, returnType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void)
}

class HttpHandler: HttpHandlerProtocol {
    func getRecordsFromAPI<T: Codable>(from urlString: String, returnType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: urlString)
        else {
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.urlSessionError(error)))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodingError))
                }
            } else {
                completion(.failure(.noData))
            }
        }.resume()
    }
}

// MARK: - Database

protocol DatabaseHandlerProtocol {
    func saveToDatabase<T>(data: T.Type)
}

class DatabaseHandler: DatabaseHandlerProtocol {
    func saveToDatabase<T>(data: T.Type) {
        // TODO: Will do after Coredata Full Recap
    }
}

// MARK: - Main Class Creation

// MARK: For Employess
protocol EmployeesProtocol {
    // TODO: For DI Variable declaration will do after DI Recap
    
    func fetchEmployeeRecords()
}

class Employees: EmployeesProtocol {
    let httpHandler: HttpHandlerProtocol
    let databaseHandler: DatabaseHandlerProtocol
    
    init(
        httpHandler: HttpHandlerProtocol,
        databaseHandler: DatabaseHandlerProtocol
    ) {
        self.httpHandler = httpHandler
        self.databaseHandler = databaseHandler
    }
    
    func fetchEmployeeRecords() {
        httpHandler.getRecordsFromAPI(from: Constants.fetchEmployeeRecordsURL, returnType: EmployeeRecord.self) { [weak self] result in
            guard let self else { return }
            
            switch result {
                
            case .success(let response):
                print("Status = \(response.status) || Message = \(response.message)")
                
                response.data?.forEach {
                    print("Employee Name: \($0.employeeName) && Employee Age: \($0.employeeAge)")
                }
                
                // self.databaseHandler.saveToDatabase(data: EmployeeRecord.self)
                
            case .failure(let error):
                print(error.description())
            }
        }
    }
}

// MARK: For Randoms
protocol RandRandomProtocol {
    // TODO: For DI Variable declaration will do after DI Recap
    
    func fetchRandomRecords()
}

class Randoms: RandRandomProtocol {
    let httpHandler: HttpHandlerProtocol
    let databaseHandler: DatabaseHandlerProtocol
    
    init(
        httpHandler: HttpHandlerProtocol,
        databaseHandler: DatabaseHandlerProtocol
    ) {
        self.httpHandler = httpHandler
        self.databaseHandler = databaseHandler
    }
    
    func fetchRandomRecords() {
        httpHandler.getRecordsFromAPI(from: Constants.fetchRandomRecordsURL, returnType: [RandomRecord].self) { [weak self] result in
            guard let self else { return }
            
            switch result {
                
            case .success(let response):
                response.forEach {
                    print("Id: \($0.id) && Title: \($0.title)")
                }
                
                // self.databaseHandler.saveToDatabase(data: [RandomRecord].self)
                
            case .failure(let error):
                print(error.description())
            }
        }
    }
}

// MARK: - Main Object Creation

/*
 NOTE: Here HttpHandler() & DatabaseHandler() is the DEPENDENCY INVERSION because in the main classes their Protocol is Injected but while object creation we injected the classes itself
 */

// MARK: For Employess
let objEmployees = Employees(
    httpHandler: HttpHandler(),
    databaseHandler: DatabaseHandler()
)
objEmployees.fetchEmployeeRecords()

// MARK: For Randoms
let objRandoms = Randoms(
    httpHandler: HttpHandler(),
    databaseHandler: DatabaseHandler()
)
objRandoms.fetchRandomRecords()

