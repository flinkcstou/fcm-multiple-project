package kz.mybpm.core.multiple.fcm;

import static kz.mybpm.core.multiple.fcm.FCMStatic.FCM_ERROR;
import static kz.mybpm.core.multiple.fcm.FCMStatic.FCM_EVENT_TOKEN_ERROR;
import static kz.mybpm.core.multiple.fcm.FCMStatic.FCM_EVENT_TOKEN_SUCCESS;
import static kz.mybpm.core.multiple.fcm.FCMStatic.FCM_TOKEN;
import static kz.mybpm.core.multiple.fcm.FCMStatic.LOGGER_TAG;
import static kz.mybpm.core.multiple.fcm.FirebaseConfig.FC_APPLICATION_NAME;

import android.util.Log;
import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;
import java.util.function.Consumer;

@CapacitorPlugin(name = "FCMMultipleProject")
public class FCMMultipleProjectPlugin extends Plugin {

  private FCMMultipleProject fcmMultipleProject;


  public void load() {
    fcmMultipleProject = new FCMMultipleProject(getActivity());
    fcmMultipleProject.init();

  }


  @PluginMethod
  public void echo(PluginCall call) {
    String value = call.getString("value");

    JSObject ret = new JSObject();
    ret.put("value", fcmMultipleProject.echo(value));
    call.resolve(ret);
  }

  @PluginMethod
  public void add(PluginCall call) {

    FirebaseConfig firebaseConfig = fcmMultipleProject.createFirebaseConfig(call);

    Consumer<String> apply = x -> {
      fcmMultipleProject.add(firebaseConfig);
      fcmMultipleProject.getToken(firebaseConfig,
                                  token -> {
                                    JSObject data = new JSObject();
                                    data.put(FCM_TOKEN, token);
                                    data.put(FC_APPLICATION_NAME, firebaseConfig.getFirebaseAppName());
                                    notifyListeners(FCM_EVENT_TOKEN_SUCCESS, data, true);
                                  },
                                  errorMessage -> {
                                    JSObject data = new JSObject();
                                    data.put(FCM_ERROR, errorMessage);
                                    data.put(FC_APPLICATION_NAME, firebaseConfig.getFirebaseAppName());
                                    notifyListeners(FCM_EVENT_TOKEN_ERROR, data, true);
                                  }
      );
      call.resolve();
    };

    Consumer<String> reject = x -> {
      call.reject("No valid permission FirebaseConfig");
    };

    fcmMultipleProject.hasRights(firebaseConfig, apply, reject);

    call.resolve();
  }

  @PluginMethod
  public void clean(PluginCall call) {
    try {
      fcmMultipleProject.clean();
      call.resolve();
    } catch (Throwable t) {
      call.reject("Something wrong to clean");
      Log.d(LOGGER_TAG, t.toString());
    }
  }

}
