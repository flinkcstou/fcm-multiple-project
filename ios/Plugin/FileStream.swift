import Foundation

class FileStream {
    
    
    static func saveToFile(_ firebaseConfig: FirebaseConfig){
        
        let firebaseConfigs:Array<FirebaseConfig> = FileStream.read()
        var collect:Array<FirebaseConfig> = []
        
        
        collect = firebaseConfigs
            .filter {(value)-> Bool in
                
                return !value.getFirebaseAppName()!.contains(firebaseConfig.getFirebaseAppName()!)
                
            }
            .filter{(value)-> Bool in
                return !value.getProjectId()!.contains(firebaseConfig.getProjectId()!)
                
            }
        
        collect.append(firebaseConfig)
        FileStream.write(collect)
        
    }
    
    
    static func write(_ firebaseConfigs: Array<FirebaseConfig> = []){
        
        let jsonString = FileStream.json(firebaseConfigs)
        FileStream.writeToFile(jsonString)
    }
    
    
    
    static func writeToFile(_ apiResponse: String = FCMStatic.EMPTY_ARRAY) {
        // todo nabu add clean
        
        do {
            let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(FCMStatic.FILE_NAME)
            
            try apiResponse.write(to: filePath, atomically: true, encoding: .utf8)
            
        }
        catch{
            print(FCMStatic.LOGGER_TAG + "FileStream write: ", error)
        }
        
    }
    
    
    static func read() -> Array<FirebaseConfig>{
        
        let jsonString = FileStream.readFromFile();
        return FileStream.jsonDecode(jsonString)
        
    }
    
    static func readFromFile() -> String{
        
        var result:String = FCMStatic.EMPTY_ARRAY;
        
        do{
            let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(FCMStatic.FILE_NAME)
            try result = String(contentsOf: filePath, encoding: .utf8)
            return result
        }catch{
            print(FCMStatic.LOGGER_TAG + "FileStream read: ", error)
            return result;
        }
        
        
    }
    
    
    static func jsonDecode(_ jsonString:String = FCMStatic.EMPTY_ARRAY)-> Array<FirebaseConfig>{
        
        var firebaseConfigs:Array<FirebaseConfig> = [];
        
        do{
            let data = Data(jsonString.utf8)
            try firebaseConfigs =  JSONDecoder().decode([FirebaseConfig].self, from: data)
            
        }
        catch{
            print(FCMStatic.LOGGER_TAG + "jsonDecode error: ", error)
        }
        
        return firebaseConfigs;
        
    }
    
    
    static func json(_ object: Array<FirebaseConfig>) -> String {
        
        do{
            
    
            let data = try JSONEncoder().encode(object)
            
//            let arr = Array(arrayLiteral: object)
//
//            let isValid = JSONSerialization.isValidJSONObject(arr)
//
//            let data = try JSONSerialization.data(withJSONObject: object, options: [])
//
            return String(data: data, encoding: String.Encoding.utf8)!
            
        } catch{
            
            print(error)
            return FCMStatic.EMPTY;
            
        }
        
     
        
    }
    
    
}


