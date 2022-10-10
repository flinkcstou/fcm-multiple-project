package kz.mybpm.core.multiple.fcm;

public class FirebaseConfig {

  public static final String FC_APPLICATION_NAME = "firebaseAppName";
  public static final String FC_PROJECT_ID = "projectId";
  public static final String FC_APPLICATION_ID = "applicationId";
  public static final String FC_API_KEY = "apiKey";
  public static final String FC_GCM_SENDER_ID = "gcmSenderId";
  public static final String FC_STORAGE_BUCKET = "storageBucket";
  public static final String FC_DATABASE_URL = "databaseUrl";
  public static final String FC_GA_TRACKING_ID = "gaTrackingId";



  private String firebaseAppName;
  private String apiKey;
  private String applicationId;
  private String databaseUrl;
  private String gaTrackingId;
  private String gcmSenderId;
  private String storageBucket;
  private String projectId;


  public FirebaseConfig() {

  }

  public FirebaseConfig(String firebaseAppName, String apiKey, String applicationId, String databaseUrl,
                        String gaTrackingId, String gcmSenderId, String storageBucket, String projectId) {
    this.firebaseAppName = firebaseAppName;
    this.apiKey = apiKey;
    this.applicationId = applicationId;
    this.databaseUrl = databaseUrl;
    this.gaTrackingId = gaTrackingId;
    this.gcmSenderId = gcmSenderId;
    this.storageBucket = storageBucket;
    this.projectId = projectId;
  }

  public String getFirebaseAppName() {
    return firebaseAppName;
  }

  public FirebaseConfig setFirebaseAppName(String firebaseAppName) {
    this.firebaseAppName = firebaseAppName;
    return this;
  }

  public String getApiKey() {
    return apiKey;
  }

  public FirebaseConfig setApiKey(String apiKey) {
    this.apiKey = apiKey;
    return this;
  }

  public String getApplicationId() {
    return applicationId;
  }

  public FirebaseConfig setApplicationId(String applicationId) {
    this.applicationId = applicationId;
    return this;
  }

  public String getDatabaseUrl() {
    return databaseUrl;
  }

  public FirebaseConfig setDatabaseUrl(String databaseUrl) {
    this.databaseUrl = databaseUrl;
    return this;
  }

  public String getGaTrackingId() {
    return gaTrackingId;
  }

  public FirebaseConfig setGaTrackingId(String gaTrackingId) {
    this.gaTrackingId = gaTrackingId;
    return this;
  }

  public String getGcmSenderId() {
    return gcmSenderId;
  }

  public FirebaseConfig setGcmSenderId(String gcmSenderId) {
    this.gcmSenderId = gcmSenderId;
    return this;
  }

  public String getStorageBucket() {
    return storageBucket;
  }

  public FirebaseConfig setStorageBucket(String storageBucket) {
    this.storageBucket = storageBucket;
    return this;
  }

  public String getProjectId() {
    return projectId;
  }

  public FirebaseConfig setProjectId(String projectId) {
    this.projectId = projectId;
    return this;
  }


}
