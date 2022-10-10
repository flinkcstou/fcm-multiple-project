package kz.mybpm.core.multiple.fcm;

import android.content.Context;
import android.util.Log;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

public class FileStream {

  private static final String FILE_NAME = "config.txt";
  private static final Gson gson = new Gson();
  private static final Type listType = new TypeToken<List<FirebaseConfig>>() {}.getType();


  public static void writeToFile(String data, Context context) {
    try {
      OutputStreamWriter outputStreamWriter = new OutputStreamWriter(
        context.openFileOutput(FILE_NAME, Context.MODE_PRIVATE));
      outputStreamWriter.write(data);
      outputStreamWriter.close();
    } catch (IOException e) {
      Log.e("Exception", "File write failed: " + e.toString());
    }
  }

  public static String readFromFile(Context context) {

    String ret = "";

    try {
      InputStream inputStream = context.openFileInput(FILE_NAME);

      if (inputStream != null) {
        InputStreamReader inputStreamReader = new InputStreamReader(inputStream);
        BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
        String receiveString = "";
        StringBuilder stringBuilder = new StringBuilder();

        while ((receiveString = bufferedReader.readLine()) != null) {
          stringBuilder.append("\n").append(receiveString);
        }

        inputStream.close();
        ret = stringBuilder.toString();
      }
    } catch (FileNotFoundException e) {
      Log.e("login activity", "File not found: " + e.toString());
    } catch (IOException e) {
      Log.e("login activity", "Can not read file: " + e.toString());
    }

    return ret;
  }

  public static void write(List<FirebaseConfig> firebaseConfigs, Context context) {

    String json = gson.toJson(firebaseConfigs, listType);

    writeToFile(json, context);
  }

  public static List<FirebaseConfig> read(Context context) {

    String fileString = readFromFile(context);
    List<FirebaseConfig> firebaseConfigs = new ArrayList<>();

    try {
      firebaseConfigs = gson.fromJson(fileString, listType);

      if (Objects.isNull(firebaseConfigs)) {
        firebaseConfigs = new ArrayList<>();
      }

    } catch (Throwable t) {
      Log.d("FileStrem", t.toString());
    }
    return firebaseConfigs;
  }

  public static void saveToFile(FirebaseConfig firebaseConfig, Context context) {
    List<FirebaseConfig> firebaseConfigs = FileStream.read(context);
    List<FirebaseConfig> collect = new ArrayList<>();
    if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.N) {
      collect = firebaseConfigs.stream()
                               .filter(config -> !Objects.equals(config.getFirebaseAppName(),
                                                                 firebaseConfig.getFirebaseAppName()))
                               .filter(config -> !Objects.equals(config.getProjectId(),
                                                                 firebaseConfig.getProjectId()))
                               .collect(Collectors.toList());
    }
    collect.add(firebaseConfig);
    FileStream.write(collect, context);

  }


}
