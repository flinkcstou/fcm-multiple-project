import Foundation

class FirebaseConfig: Codable
{
    static var FC_APPLICATION_NAME : String = "firebaseAppName";
    static var FC_PROJECT_ID : String = "projectId";
    static var FC_APPLICATION_ID : String = "applicationId";
    static var FC_API_KEY : String = "apiKey";
    static var FC_GCM_SENDER_ID : String = "gcmSenderId";
    static var FC_STORAGE_BUCKET : String = "storageBucket";
    static var FC_DATABASE_URL : String = "databaseUrl";
    static var FC_GA_TRACKING_ID : String = "gaTrackingId";


    private var firebaseAppName : String;
    private var apiKey : String;
    private var applicationId : String;
    private var databaseUrl : String;
    private var gaTrackingId : String;
    private var gcmSenderId : String;
    private var storageBucket : String;
    private var projectId : String;


    init(_ firebaseAppName : String, _ apiKey : String, _ applicationId : String, _ databaseUrl : String, _ gaTrackingId : String, _ gcmSenderId : String, _ storageBucket : String, _ projectId : String)
    {
        self.firebaseAppName = firebaseAppName;
        self.apiKey = apiKey;
        self.applicationId = applicationId;
        self.databaseUrl = databaseUrl;
        self.gaTrackingId = gaTrackingId;
        self.gcmSenderId = gcmSenderId;
        self.storageBucket = storageBucket;
        self.projectId = projectId;
    }
    func getFirebaseAppName() -> String?
    {
        return self.firebaseAppName;
    }
    func setFirebaseAppName(_ firebaseAppName : String) -> FirebaseConfig?
    {
        self.firebaseAppName = firebaseAppName;
        return self;
    }
    func getApiKey() -> String?
    {
        return self.apiKey;
    }
    func setApiKey(_ apiKey : String) -> FirebaseConfig?
    {
        self.apiKey = apiKey;
        return self;
    }
    func getApplicationId() -> String?
    {
        return self.applicationId;
    }
    func setApplicationId(_ applicationId : String) -> FirebaseConfig?
    {
        self.applicationId = applicationId;
        return self;
    }
    func getDatabaseUrl() -> String?
    {
        return self.databaseUrl;
    }
    func setDatabaseUrl(_ databaseUrl : String) -> FirebaseConfig?
    {
        self.databaseUrl = databaseUrl;
        return self;
    }
    func getGaTrackingId() -> String?
    {
        return self.gaTrackingId;
    }
    func setGaTrackingId(_ gaTrackingId : String) -> FirebaseConfig?
    {
        self.gaTrackingId = gaTrackingId;
        return self;
    }
    func getGcmSenderId() -> String?
    {
        return self.gcmSenderId;
    }
    func setGcmSenderId(_ gcmSenderId : String) -> FirebaseConfig?
    {
        self.gcmSenderId = gcmSenderId;
        return self;
    }
    func getStorageBucket() -> String?
    {
        return self.storageBucket;
    }
    func setStorageBucket(_ storageBucket : String) -> FirebaseConfig?
    {
        self.storageBucket = storageBucket;
        return self;
    }
    func getProjectId() -> String?
    {
        return self.projectId;
    }
    func setProjectId(_ projectId : String) -> FirebaseConfig?
    {
        self.projectId = projectId;
        return self;
    }
}
