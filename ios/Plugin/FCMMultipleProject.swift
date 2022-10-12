import Foundation

@objc public class FCMMultipleProject: NSObject {
    
    
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
    
    func test(){
        
    }
    
    func create(){
        
        let firebaseConfigs = FileStream.read()
        
        firebaseConfigs
            .forEach{(value)->Void in
                
            }
    }
    
    func add(_ firebaseConfig:FirebaseConfig){
        
    }
    
    func clean(){
        
    }
    
    func remove(_ firebaseConfig: FirebaseConfig){
        
    }
    
    func getToken(_ firebaseConfig:FirebaseConfig){
        
    }
    
    
    func getInstance(_ firebaseAppName:String){
        
        
    }
    
    
    func getFirebaseMessaging(_ firebaseConfig:FirebaseConfig){
        
    }
    
    
    func createFirebaseConfig(_ firebaseConfig:FirebaseConfig){
        
    }
    
    
    func hasRights(_ firebaseConfig:FirebaseConfig){
        
    }
    
    func initializeApp(_ firebaseConfig:FirebaseConfig){
        
    }
    
    func createFirebaseOptions(_ firebaseConfig:FirebaseConfig){
        
        
        FirebaseOptions()
        
    }
    
    
    
}
