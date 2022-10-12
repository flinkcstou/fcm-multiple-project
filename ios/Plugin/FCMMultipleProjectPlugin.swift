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


      call.resolve()
    }

    @objc func clean(_ call: CAPPluginCall){

      call.resolve()
    }


}
