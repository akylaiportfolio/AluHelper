//
//  UserServices.swift
//  EduConnect
//
//  Created by Akylai Bekbolsunova on 21/4/24.
//

import FirebaseAuth
import FirebaseDatabase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class UserServices {
    
    // MARK: USER STATUS
    // student
    // teacher
    // admin
    // form
    
    enum LoginErrorType {
        case notValid
        case notCreate
    }
    
    enum LoginStatus {
        case error(type: LoginErrorType)
        case pass(model: UserModel)
    }
    
    //
    
    enum FormErrorType {
        case notValid
        case notCreate
    }
    
    enum FormStatus {
        case error(type: FormErrorType)
        case pass
    }
    
    static let shered = UserServices()
    
    private let database = Database.database().reference()
    
    func login(_ email: String, _ password: String, result: @escaping (LoginStatus) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [self] data, error in
            if let uid = data?.user.uid {
                findUser(uid) { model in
                    if let model {
                        result(.pass(model: model))
                    } else {
                        result(.error(type: .notCreate))
                    }
                }
            } else {
                result(.error(type: .notCreate))
            }
        }
    }
    
    func findUser(_ uid: String, result: @escaping (UserModel?) -> Void) {
        database.child("users").getData { error, data in
            if let data = data?.children.allObjects {
                data.forEach { user in
                    let check = (user as? DataSnapshot)?.key
                    
                    if check == uid {
                        result(self.convert(user, type: UserModel.self))
                    }
                }
            } else {
                result(nil)
            }
        }
    }

    func sendForm(
        _ avatar: UIImage,
        _ email: String,
        _ fullName: String,
        _ dateOfBirth: String,
        _ courses: String,
        _ password: String,
        result: @escaping (FormStatus) -> Void
    ) {
        Auth.auth().createUser(withEmail: email, password: password) { [self] data, error in
            if let uid = data?.user.uid {
                saveAvatar(avatar, uid: uid) { url in
                    if let url {
                        self.createForm(uid, url, email, fullName, dateOfBirth, courses, result)
                    } else {
                        result(.error(type: .notCreate))
                    }
                }
            } else {
                result(.error(type: .notValid))
            }
        }
    }
    
    func createForm(
        _ uid: String,
        _ avatar: String,
        _ email: String,
        _ fullName: String,
        _ dateOfBirth: String,
        _ courses: String,
        _ result: @escaping (FormStatus) -> Void
    ) {
        var userData: [String: String] = [
            "avatar" : avatar,
            "group" : courses,
            "email" : email,
            "date_of_birth" : dateOfBirth,
            "full_name" : fullName,
            "uid" : uid,
            "status" : "form"
        ]
        
        database.child("users").child(uid).setValue(userData) { error, ref in
            if error == nil {
                result(.pass)
            } else {
                result(.error(type: .notCreate))
            }
        }
    }
    
    func getSigleAllGroup(result: @escaping ([GroupModel]) -> Void) {
        database.child("group").getData { [self] error, data in
            var groups: [GroupModel] = []
            
            data?.children.allObjects.forEach { [self] item in
                let model = self.convert(item, type: GroupModel.self)
                
                if let model {
                    groups.append(model)
                }
            }
            
            result(groups)
        }
    }
    
    func getAllGroup(result: @escaping ([GroupModel]) -> Void) {
        database.child("group").getData { [self] error, data in
            var groups: [GroupModel] = []
            
            data?.children.allObjects.forEach { [self] item in
                let model = self.convert(item, type: GroupModel.self)
                
                if let model {
                    groups.append(model)
                }
            }
            
            result(groups)
        }
    }
    
    func getPutGroup(models: GroupModel, action: @escaping () -> Void) {
        database.child("group").child(models.name ?? "").setValue(models.asDictionary()) { _, _ in
            action()
        }
    }
    
    func getMyGroup(result: @escaping (GroupModel) -> Void) {
        database.child("group").observe(.value) { [self] data in
            var group: GroupModel? = nil
            
            data.children.allObjects.forEach { [self] item in
                let model = self.convert(item, type: GroupModel.self)
                
                if model?.name == self.getUser()?.group {
                    group = model
                }
            }
                        
            if let group = group {
                result(group)
            }
        }
    }
    
    func getFromNameGroup(name: String, result: @escaping (GroupModel) -> Void) {
        database.child("group").observe(.value) { [self] data in
            var group: GroupModel? = nil
            
            data.children.allObjects.forEach { [self] item in
                let model = self.convert(item, type: GroupModel.self)
                
                if model?.name == name {
                    group = model
                }
            }
                        
            if let group = group {
                result(group)
            }
        }
    }
    
    func putGroup(name: String, group: GroupModel, result: @escaping () -> Void) {
        database.child("group").child(name).setValue(group.asDictionary()) { _, _ in
            result()
        }
    }
    
    func getAllOrder(result: @escaping ([OrderModel]) -> Void) {
        database.child("order").observe(.value) { data in
            var groups: [OrderModel] = []
            
            data.children.forEach { [self] item in
                let model = self.convert(item, type: OrderModel.self)
                
                if let model {
                    groups.append(model)
                }
            }
            
            result(groups)
        }
    }
    
    func getSingleAllOrder(result: @escaping ([OrderModel]) -> Void) {
        database.child("order").getData { [self] error, data in
            var groups: [OrderModel] = []
            
            data?.children.allObjects.forEach { [self] item in
                let model = self.convert(item, type: OrderModel.self)
                
                if let model {
                    groups.append(model)
                }
            }
            
            result(groups)
        }
    }
    
    func putAllOrders(models: [OrderModel], result: @escaping () -> Void) {
        self.database.child("order").setValue(models.asDictionary()) { error, test in
            result()
        }
    }
    
    func getSingleAllNews(result: @escaping ([NewsModel]) -> Void) {
        database.child("news").getData { [self] error, data in
            var groups: [NewsModel] = []
            
            data?.children.allObjects.forEach { [self] item in
                let model = self.convert(item, type: NewsModel.self)
                
                if let model {
                    groups.append(model)
                }
            }
            
            result(groups)
        }
    }
    
    func getAllNews(result: @escaping ([NewsModel]) -> Void) {
        database.child("news").observe(.value) { [self] data in
            var groups: [NewsModel] = []
            
            data.children.forEach { [self] item in
                let model = self.convert(item, type: NewsModel.self)
                
                if let model {
                    groups.append(model)
                }
            }
            
            result(groups)
        }
    }
    
    func putAllNews(models: [NewsModel], result: @escaping () -> Void) {
        self.database.child("news").setValue(models.asDictionary()) { error, test in
            result()
        }
    }
    
    func getInfoModels(result: @escaping ([InfoModel]) -> Void) {
        database.child("info").observe(.value) { data in
            var models: [InfoModel] = []
            
            data.children.forEach { user in
                let model = self.convert(user, type: InfoModel.self)
                
                if let model {
                    models.append(model)
                }
            }
            
            result(models)
        }
    }
    
    func getSingleInfoModels(result: @escaping ([InfoModel]) -> Void) {
        database.child("info").getData { _, data in
            var models: [InfoModel] = []
            
            data?.children.allObjects.forEach { user in
                let model = self.convert(user, type: InfoModel.self)
                
                if let model {
                    models.append(model)
                }
            }
            
            result(models)
        }
    }
    
    func putInfoModel(_ model: InfoModel, result: @escaping () -> Void) {
        database.child("info").getData(completion: { error, data in
            var models: [InfoModel] = []
            
            data?.children.forEach { user in
                let model = self.convert(user, type: InfoModel.self)
                
                if let model {
                    models.append(model)
                }
            }
            
            models.append(model)
            
            self.database.child("info").setValue(models.asDictionary()) { error, test in
                result()
            }
        })
    }
    
    func putInfoModel(_ models: [InfoModel], result: @escaping () -> Void) {
        self.database.child("info").setValue(models.asDictionary()) { error, test in
            result()
        }
    }
    
    func getAllUsers(result: @escaping ([UserModel]?) -> Void) {
        database.child("users").getData { error, data in
            if let data = data?.children.allObjects {
                var users: [UserModel] = []

                data.forEach { user in
                    let model = self.convert(user, type: UserModel.self)
                    
                    if let model {
                        users.append(model)
                    }
                }
                
                result(users)
            } else {
                result(nil)
            }
        }
    }
    
    func observersUsers(result: @escaping ([UserModel]) -> Void) {
        database.child("users").observe(.value) { data in
            var users: [UserModel] = []

            data.children.forEach { user in
                let model = self.convert(user, type: UserModel.self)
                
                if let model {
                    users.append(model)
                }
            }
            
            result(users)
        }
    }
    
    func getGuideModels(result: @escaping ([GuideModel]) -> Void) {
        database.child("guide").observe(.value) { data in
            var models: [GuideModel] = []
            
            data.children.forEach { user in
                let model = self.convert(user, type: GuideModel.self)
                
                if let model {
                    models.append(model)
                }
            }
            
            result(models)
        }
    }
    
    func getGuideModelsData(result: @escaping ([GuideModel]) -> Void) {
        database.child("guide").getData { _, data in
            var models: [GuideModel] = []
            
            data?.children.allObjects.forEach { user in
                let model = self.convert(user, type: GuideModel.self)
                
                if let model {
                    models.append(model)
                }
            }
            
            result(models)
        }
    }
    
    
    func putGuideModel(_ models: [GuideModel], result: @escaping () -> Void) {
        self.database.child("guide").setValue(models.asDictionary()) { error, test in
            result()
        }
    }
    
    func saveGuideImage(_ avatar: UIImage, id: Int, result: @escaping (String?) -> Void) {
        let storage = Storage.storage()

        let data = avatar.jpegData(compressionQuality: 1) ?? Data()

        let riversRef = storage.reference().child("guide/\(id).jpg")
        
        riversRef.putData(data, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                result(nil)
                
                return
            }
            
            riversRef.downloadURL { (url, error) in
                result(url?.absoluteString)
            }
        }
    }
    
    func saveNewsImage(_ avatar: UIImage, id: Int, result: @escaping (String?) -> Void) {
        let storage = Storage.storage()

        let data = avatar.jpegData(compressionQuality: 1) ?? Data()

        let riversRef = storage.reference().child("news/\(id).jpg")
        
        riversRef.putData(data, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                result(nil)
                
                return
            }
            
            riversRef.downloadURL { (url, error) in
                result(url?.absoluteString)
            }
        }
    }
    
    func savePdf(_ pdf: Data, id: Int, result: @escaping (String?) -> Void) {
        let storage = Storage.storage()

        let riversRef = storage.reference().child("order/\(id).pdf")
        
        riversRef.putData(pdf, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                result(nil)
                
                return
            }
            
            riversRef.downloadURL { (url, error) in
                result(url?.absoluteString)
            }
        }
    }
    
    func saveAvatar(_ avatar: UIImage, uid: String, result: @escaping (String?) -> Void) {
        let storage = Storage.storage()

        let data = avatar.jpegData(compressionQuality: 0.1) ?? Data()

        let riversRef = storage.reference().child("users/\(uid).jpg")
        
        riversRef.putData(data, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                result(nil)
                
                return
            }
            
            riversRef.downloadURL { (url, error) in
                result(url?.absoluteString)
            }
        }
    }
    
    func convert<T: Codable>(_ item: Any, type: T.Type) -> T? {
        let data = item as? DataSnapshot
        let dic = data?.value as? [String : Any]

        guard let dic = dic else { return nil }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)

            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            return nil
        }
    }
    
    func save(user: UserModel) {
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(user) {
            UserDefaults.standard.set(encoded, forKey: "CurrentUser")
        }
    }
    
    func getRooms(result: @escaping ([String]) -> Void) {
        database.child("rooms").getData { _, data in
            var models: [String] = []
            
            data?.children.allObjects.forEach { user in
                let model = (user as? DataSnapshot)?.value as? String
                
                if let model {
                    models.append(model)
                }
            }
            
            result(models)
        }
    }
    
    func putRooms(data: [String], result: @escaping () -> Void) {
        database.child("rooms").setValue(data) { _, _ in
            result()
        }
    }
    
    func getUser() -> UserModel? {
        if let savedPerson = UserDefaults.standard.object(forKey: "CurrentUser") as? Data {
            if let user = try? JSONDecoder().decode(UserModel.self, from: savedPerson) {
                return user
            }
        }
        
        return nil
    }
    
    func getRentRoomData(result: @escaping ([RentRoom]) -> Void) {
        database.child("rent-rooms").getData { _, data in
            var models: [RentRoom] = []
            
            data?.children.allObjects.forEach { user in
                let model = self.convert(user, type: RentRoom.self)
                
                if let model {
                    models.append(model)
                }
            }
            
            result(models)
        }
    }
    
    
    func putRentRoom(_ models: [RentRoom], result: @escaping () -> Void) {
        self.database.child("rent-rooms").setValue(models.asDictionary()) { error, test in
            result()
        }
    }
    
    func updateProfile(uid: String, avatar: String, fullname: String, dateOfBirth: String, action: @escaping () -> Void) {
        
        getAllUsers { user in
            user?.forEach { item in
                if item.uid == uid {
                    var updateProfile = item
                    
                    updateProfile.avatar = avatar
                    updateProfile.fullName = fullname
                    updateProfile.dateOfBirth = dateOfBirth
                    
                    self.database.child("users").child(uid).setValue(updateProfile.asDictionary()) { _, _ in
                        self.save(user: updateProfile)
                        
                        action()
                    }
                }
            }
        }
    }
    
    func updateProfile(uid: String, status: String, action: @escaping () -> Void) {
        getAllUsers { user in
            user?.forEach { item in
                if item.uid == uid {
                    var updateProfile = item
                    
                    updateProfile.status = status
                    
                    self.database.child("users").child(uid).setValue(updateProfile.asDictionary()) { _, _ in
                        
                        action()
                    }
                }
            }
        }
    }
    
    func logout() {
        UserDefaults.standard.set(nil, forKey: "CurrentUser")
    }
}

struct RentRoom: Codable {
    var id: Int
    var uid: String
    var room: String
    var message: String
    var startTime: String
    var endTime: String
    var status: String
}

class UserModel: Codable {
    var avatar: String
    var dateOfBirth, email, fullName, group: String
    var status: String
    var uid: String

    enum CodingKeys: String, CodingKey {
        case avatar
        case dateOfBirth = "date_of_birth"
        case email
        case fullName = "full_name"
        case group, status, uid
    }
}

struct GuideModel: Codable {
    var id: Int
    var title: String
    var message: String
    var userName: String?
    var group: String?
    var url: String?
}

struct InfoModel: Codable {
    var id: Int
    var title: String
    var message: String
    var status: String
    var userName: String?
    var group: String?
}

struct GroupModel: Codable {
    var name: String?
    var schedule: Schedule?
}

struct Schedule: Codable {
    var monday, tuesday, wednesday, thursday: [Lesson]?
    var friday, saturday, sunday: [Lesson]?
}

struct Lesson: Codable {
    var title, teacher, start, end, cabinet: String?
    var id: Int?
}

struct OrderModel: Codable {
    var id: Int?
    var title, decription: String?
    var file: String?
    var create, time: String?
}

struct NewsModel: Codable {
    let id: Int?
    let title, decription: String?
    let image: String?
    let create, time: String?
}

extension Encodable {
  func asDictionary() -> Any {
    let data = try? JSONEncoder().encode(self)
      
      if let data = data {
          guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Any else {
              return 0
          }
          return dictionary
      } else {
          return [:]
      }
  }
}
