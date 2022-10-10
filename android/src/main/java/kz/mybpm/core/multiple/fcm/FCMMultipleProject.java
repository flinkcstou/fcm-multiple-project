package kz.mybpm.core.multiple.fcm;

import static kz.mybpm.core.multiple.fcm.FCMStatic.EMPTY;
import static kz.mybpm.core.multiple.fcm.FCMStatic.LOGGER_TAG;
import static kz.mybpm.core.multiple.fcm.FirebaseConfig.FC_API_KEY;
import static kz.mybpm.core.multiple.fcm.FirebaseConfig.FC_APPLICATION_ID;
import static kz.mybpm.core.multiple.fcm.FirebaseConfig.FC_DATABASE_URL;
import static kz.mybpm.core.multiple.fcm.FirebaseConfig.FC_GCM_SENDER_ID;
import static kz.mybpm.core.multiple.fcm.FirebaseConfig.FC_PROJECT_ID;
import static kz.mybpm.core.multiple.fcm.FirebaseConfig.FC_STORAGE_BUCKET;

import android.annotation.SuppressLint;
import android.content.Context;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.util.Log;
import com.getcapacitor.PluginCall;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.messaging.FirebaseMessaging;
import java.util.List;
import java.util.Objects;
import java.util.function.Consumer;
import java.util.stream.Collectors;

public class FCMMultipleProject {

  public String echo(String value) {
    Log.i("Echo", value);
    return value;
  }


  private final Context context;

  public FCMMultipleProject(Context context) {
    this.context = context;
  }

  public void test() {
    FirebaseConfig firebaseConfig = new FirebaseConfig();
    
  }

  public void init() {

    List<FirebaseConfig> firebaseConfigs = FileStream.read(context);

    if (VERSION.SDK_INT >= VERSION_CODES.N) {
      firebaseConfigs.forEach(firebaseConfig -> {
        initializeApp(firebaseConfig);
      });
    }
  }

  public void add(FirebaseConfig firebaseConfig) {

    Consumer<String> consumer = x -> {
      FileStream.saveToFile(firebaseConfig, context);
      remove(firebaseConfig);
      // todo nabu has one mistake it's save file by filter projectId but sometimes we have two initialize with other ApplicationName
      initializeApp(firebaseConfig);
    };

    hasRights(firebaseConfig, consumer, s -> {});

  }

  @SuppressLint("VisibleForTests")
  public void clean() {
    List<FirebaseApp> apps = FirebaseApp.getApps(context);

    if (VERSION.SDK_INT >= VERSION_CODES.N) {
      List<FirebaseApp> collect = apps.stream()
                                      .filter(firebaseApp -> !firebaseApp.isDefaultApp())
                                      .collect(Collectors.toList());
      collect.forEach(FirebaseApp::delete);
    }

    FileStream.writeToFile(EMPTY, context);
  }

  @SuppressLint("VisibleForTests")
  public void remove(FirebaseConfig firebaseConfig) {

    try {
      FirebaseApp instance = getInstance(firebaseConfig.getFirebaseAppName());
      if (!instance.isDefaultApp()) {
        instance.delete();
      }
    } catch (Throwable t) {
      Log.d(LOGGER_TAG, "InstanceApp not found:" + firebaseConfig.getFirebaseAppName());
    }

  }

  public void getToken(FirebaseConfig firebaseConfig, Consumer<String> apply, Consumer<String> reject) {
    FirebaseMessaging firebaseMessaging = getFirebaseMessaging(firebaseConfig);
    firebaseMessaging.setAutoInitEnabled(true);

    firebaseMessaging.getToken().addOnCompleteListener(task -> {
      if (VERSION.SDK_INT >= VERSION_CODES.N) {
        apply.accept(task.getResult());
      }
      System.out.println(task.getResult());
    });

    firebaseMessaging.getToken().addOnSuccessListener(token -> {
      if (VERSION.SDK_INT >= VERSION_CODES.N) {
        apply.accept(token);
      }
      System.out.println(token);
    });

    firebaseMessaging.getToken().addOnFailureListener(e -> {
      if (VERSION.SDK_INT >= VERSION_CODES.N) {
        reject.accept(e.getLocalizedMessage());
      }
    });

  }

  public FirebaseApp getInstance(String firebaseAppName) {
    return FirebaseApp.getInstance(firebaseAppName);
  }

  public FirebaseMessaging getFirebaseMessaging(FirebaseConfig firebaseConfig) {

    FirebaseApp instance = getInstance(firebaseConfig.getFirebaseAppName());
    FirebaseMessaging firebaseMessaging = instance.get(FirebaseMessaging.class);
    return firebaseMessaging;
  }

  public FirebaseConfig createFirebaseConfig(PluginCall call) {
    FirebaseConfig firebaseConfig = new FirebaseConfig();

    // used projectId because projectId has unique value from firebase
    firebaseConfig.setFirebaseAppName(call.getString(FC_PROJECT_ID));
    firebaseConfig.setProjectId(call.getString(FC_PROJECT_ID));
    firebaseConfig.setApplicationId(call.getString(FC_APPLICATION_ID));
    firebaseConfig.setApiKey(call.getString(FC_API_KEY));
    firebaseConfig.setGcmSenderId(call.getString(FC_GCM_SENDER_ID));

    firebaseConfig.setStorageBucket(call.getString(FC_STORAGE_BUCKET));
    firebaseConfig.setDatabaseUrl(call.getString(FC_DATABASE_URL));

    return firebaseConfig;
  }

  public void hasRights(FirebaseConfig firebaseConfig, Consumer<String> apply, Consumer<String> reject) {
    if (Objects.isNull(firebaseConfig) ||
      Objects.isNull(firebaseConfig.getFirebaseAppName()) ||
      Objects.isNull(firebaseConfig.getProjectId())
    ) {
      if (VERSION.SDK_INT >= VERSION_CODES.N) {
        reject.accept(null);
      }
    }
    if (VERSION.SDK_INT >= VERSION_CODES.N) {
      apply.accept(null);
    }

  }

  private FirebaseApp initializeApp(FirebaseConfig firebaseConfig) {
    FirebaseApp firebaseApp;
    try {
      firebaseApp = getInstance(firebaseConfig.getFirebaseAppName());
      Log.d(LOGGER_TAG, "InstanceApp has already exist:" + firebaseConfig.getFirebaseAppName());
    } catch (Throwable t) {

      FirebaseOptions options = createFirebaseOptions(firebaseConfig);

      firebaseApp = FirebaseApp.initializeApp(context, options, firebaseConfig.getFirebaseAppName());

    }
    return firebaseApp;

  }

  private FirebaseOptions createFirebaseOptions(FirebaseConfig firebaseConfig) {
    FirebaseOptions options = new FirebaseOptions.Builder()
      .setProjectId(firebaseConfig.getProjectId())
      .setApplicationId(firebaseConfig.getApplicationId())
      .setApiKey(firebaseConfig.getApiKey())
      .setGcmSenderId(firebaseConfig.getGcmSenderId())

      .setStorageBucket(firebaseConfig.getStorageBucket())
      .setDatabaseUrl(firebaseConfig.getDatabaseUrl())
      .build();
    return options;
  }


}
