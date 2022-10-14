import Foundation
import FirebaseMessaging
import FirebaseCore
import Capacitor


@objc public class FCMMultipleProject: NSObject {
    
    
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
    
    func test(){

//        FileStream.writeToFile()
//        add(firebaseConfig)
//        remove(firebaseConfig)
//        add(firebaseConfig)
//        FileStream.saveToFile(firebaseConfig)
//        firebaseConfig.setFirebaseAppName("third").build()
//        add(firebaseConfig)
//        clean()
//
//        firebaseConfig.setFirebaseAppName("fourth").build()
//        add(firebaseConfig)
        
        
    }
    
    func create(){
        
        setAutoEnabled()
        
        let firebaseConfigs = FileStream.read()
        
        firebaseConfigs
            .forEach{(value)->Void in
                initializeApp(value)
            }
    }
    
    func add(_ firebaseConfig:FirebaseConfig){
        
        let apply: (String) -> Void = { [self](empty: String) in
            
            FileStream.saveToFile(firebaseConfig)
            remove(firebaseConfig)
            initializeApp(firebaseConfig)
            
        }
        let reject: (String) -> Void = {_ in };
        
        hasRights(firebaseConfig, apply, reject)
        
    }
    
    func clean(){
        
        
         FirebaseApp.allApps!
            .filter{(key, value) -> Bool in
                return value.name == getDefaultInstance()!.name
                
            }
            .forEach{ (value) in
                
                if #available(iOS 13.0, *) {
                    Task {
                        await value.value.delete()
                    }
                } else {
                    print(FCMStatic.LOGGER_TAG + "InstanceApp not removed because is lower version than IOS 13")
                    // Fallback on earlier versions
                }
            }
        
        FileStream.writeToFile()
    }
    
    
    
    
    func remove(_ firebaseConfig: FirebaseConfig) {
        
        
        if let firebaseApp  = getInstance(firebaseConfig.getFirebaseAppName()!){
            
            
            if(firebaseApp.name != getDefaultInstance()!.name){
                
                if #available(iOS 13.0, *) {
                    Task {
                        await firebaseApp.delete()
                    }
                } else {
                    print(FCMStatic.LOGGER_TAG + "InstanceApp not removed because is lower version than IOS 13")
                    // Fallback on earlier versions
                }
                
            }
            
        }else{
            print(FCMStatic.LOGGER_TAG + "InstanceApp not found:", firebaseConfig.getFirebaseAppName()!)
        }
        
        
    }
    
    func getToken(_ firebaseConfig:FirebaseConfig, _ apply: @escaping (String) -> Void, _ reject: @escaping (String) -> Void){
        
        
        getFirebaseMessaging().retrieveFCMToken(forSenderID: firebaseConfig.getGcmSenderId()!,
                                                completion: {(token, error) in
            
            if let error = error{
            
                print(FCMStatic.LOGGER_TAG + "An error occurred while retrieving token. ", error)
                reject(error.localizedDescription)
                
            } else if let token = token {
                
                print("GET MULTIPE TOKEN SUCCESS: ", token)
                apply(token)
            
                
            }
            
        })
        
    }
    
    
    func getDefaultInstance() -> FirebaseApp?{
        
        return FirebaseApp.app();
    }
    
    
    func getInstance(_ firebaseAppName:String) -> FirebaseApp?{
        
        return FirebaseApp.app(name: firebaseAppName)
        
    }
    
    func setAutoEnabled(){
        getFirebaseMessaging().isAutoInitEnabled = true;
    }
    
    
    func getFirebaseMessaging() -> Messaging{
        
        return Messaging.messaging()
        
    }
    
    
    func createFirebaseConfig(_ call: CAPPluginCall) -> FirebaseConfig {
        
        let firebaseConfig = FirebaseConfig()
        
        firebaseConfig
            .setFirebaseAppName(call.getString(FirebaseConfig.FC_PROJECT_ID) ?? "")
            .setProjectId(call.getString(FirebaseConfig.FC_PROJECT_ID) ?? "")
            .setApplicationId(call.getString(FirebaseConfig.FC_APPLICATION_ID) ?? "")
            .setApiKey(call.getString(FirebaseConfig.FC_API_KEY) ?? "")
            .setGcmSenderId(call.getString(FirebaseConfig.FC_GCM_SENDER_ID) ?? "")
            .setStorageBucket(call.getString(FirebaseConfig.FC_STORAGE_BUCKET) ?? "")
            .setDatabaseUrl(call.getString(FirebaseConfig.FC_DATABASE_URL) ?? "")
            .build()
        
        return firebaseConfig
        
    }
    
    
    func hasRights(_ firebaseConfig:FirebaseConfig, _ apply: (String) -> Void, _ reject: (String) -> Void){
        
        //todo nabu check if nil
        if (firebaseConfig.getFirebaseAppName() ?? "").isEmpty ||
            (firebaseConfig.getProjectId() ?? "").isEmpty
        
        {
            
            reject(FCMStatic.EMPTY);
            
        }else{
            
            apply(FCMStatic.EMPTY);
        }
        
        
    }
    
    func initializeApp(_ firebaseConfig:FirebaseConfig) -> FirebaseApp{
        
        var firebaseApp: FirebaseApp;
        
        do {
            guard let fApp = getInstance(firebaseConfig.getFirebaseAppName()!)
            else{
                throw FirebaseAppError.notExist
            }
            
            firebaseApp = fApp
            
            print(FCMStatic.LOGGER_TAG + "InstanceApp has already exist:", firebaseConfig.getFirebaseAppName()!)
        } catch {
            
            let firebaseOption = createFirebaseOptions(firebaseConfig)
            
            FirebaseApp.configure(name:firebaseConfig.getFirebaseAppName()!, options: firebaseOption)
            
            firebaseApp = getInstance(firebaseConfig.getFirebaseAppName()!)!
            
        }
        
        return firebaseApp;
        
    }
    
    func createFirebaseOptions(_ firebaseConfig:FirebaseConfig)->FirebaseOptions{
        
        let firebaseOption = FirebaseOptions(
            googleAppID: firebaseConfig.getApplicationId()!,
            gcmSenderID: firebaseConfig.getGcmSenderId()!)
        
        firebaseOption.apiKey = firebaseConfig.getApiKey()
        firebaseOption.projectID = firebaseConfig.getProjectId()
        firebaseOption.databaseURL = firebaseConfig.getDatabaseUrl()
        firebaseOption.storageBucket = firebaseConfig.getStorageBucket()
        
        return firebaseOption;
        
    }
    
    
    
}
