import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(FCMMultipleProjectPlugin)
public class FCMMultipleProjectPlugin: CAPPlugin {
    private let fcmMultipleProject = FCMMultipleProject()
    
    
    override public func load() {
        fcmMultipleProject.create()
    }
    
    
    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": fcmMultipleProject.echo(value)
        ])
    }
    
    @objc func add(_ call: CAPPluginCall){
        
        let firebaseConfig: FirebaseConfig = fcmMultipleProject.createFirebaseConfig(call)
        
        let apply: (String) -> Void = { [self](empty: String) in
            
            fcmMultipleProject.add(firebaseConfig);
            fcmMultipleProject.getToken(firebaseConfig,
                                        {(token:String) in
                
                
                let data: PluginCallResultData = [
                    FCMStatic.FCM_TOKEN: token,
                    FirebaseConfig.FC_APPLICATION_NAME : firebaseConfig.getFirebaseAppName()!
                ]
                notifyListeners(FCMStatic.FCM_EVENT_TOKEN_SUCCESS, data: data)
                
            },
                                        {(error:String) in
                
                let data: PluginCallResultData = [
                    FCMStatic.FCM_ERROR: error,
                    FirebaseConfig.FC_APPLICATION_NAME : firebaseConfig.getFirebaseAppName()!
                ]
                
                notifyListeners(FCMStatic.FCM_EVENT_TOKEN_ERROR, data: data)
            }
            )
            
            call.resolve()
            
            
        }
        let reject: (String) -> Void = {_ in
            
            call.reject("No valid permission FirebaseConfig")
        };
        
        fcmMultipleProject.hasRights(firebaseConfig, apply, reject)
        
    }
    
    @objc func clean(_ call: CAPPluginCall){
        
        fcmMultipleProject.clean()
        call.resolve()
        
    }
    
    
}
