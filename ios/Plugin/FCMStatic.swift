import Foundation

class FCMStatic {
    static var EMPTY : String = "";
    static var EMPTY_ARRAY : String = "[]";
    static var FILE_NAME : String = "firebase_config.json";
    static var LOGGER_TAG : String = "FCM_MULTIPLE ";
    static var FCM_TOKEN : String = "token";
    static var FCM_ERROR : String = "error";
    static var FCM_EVENT_TOKEN_SUCCESS : String = "multipleToken";
    static var FCM_EVENT_TOKEN_ERROR : String = "multipleTokenError";
    
    
    
}

enum FirebaseAppError: Error{

    case notExist
}
