import { WebPlugin } from '@capacitor/core';

import type { FCMMultipleProjectPlugin } from './definitions';
import type { FCMMultipleProjectI } from './multiple/FCMMultipleProjectI';
import type { FirebaseConfig, FirebaseToken, FirebaseTokenError } from './multiple/FirebaseConfig';
import { FCM_EVENT_TOKEN_ERROR, FCM_EVENT_TOKEN_SUCCESS } from './multiple/FirebaseConfig';
import { FcmMultipleProjectService } from './multiple/fcm-multiple-project.service';

export class FCMMultipleProjectWeb extends WebPlugin implements FCMMultipleProjectPlugin {

  fcmMultipleProject: FCMMultipleProjectI = new FcmMultipleProjectService();

  private static instance: FCMMultipleProjectWeb;

  /**
   * The Singleton's constructor should always be private to prevent direct
   * construction calls with the `new` operator.
   */
  private constructor() {
    super();
    console.error('FCMMultipleProjectWeb');

  }

  public static getInstance(): FCMMultipleProjectWeb {
    if (!FCMMultipleProjectWeb.instance) {
      FCMMultipleProjectWeb.instance = new FCMMultipleProjectWeb();
    }
    return FCMMultipleProjectWeb.instance;
  }


  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }

  add(firebaseConfig: FirebaseConfig): Promise<void> {
    return new Promise((resolve, reject) => {
      const originFirebaseConfig = this.fcmMultipleProject.createFirebaseConfig(firebaseConfig);
      this.fcmMultipleProject.hasRights(originFirebaseConfig,
        () => {
          this.fcmMultipleProject.add(originFirebaseConfig);
          this.fcmMultipleProject.getToken(originFirebaseConfig,
            (token) => {
              const firebaseToken: FirebaseToken = {
                token,
                firebaseAppName: originFirebaseConfig.firebaseAppName,
              };
              this.notifyListeners(FCM_EVENT_TOKEN_SUCCESS, firebaseToken);
            },
            (error) => {
              const firebaseTokenError: FirebaseTokenError = {
                error,
                firebaseAppName: originFirebaseConfig.firebaseAppName,
              };
              this.notifyListeners(FCM_EVENT_TOKEN_ERROR, firebaseTokenError);
            },
          );

          resolve();
        },
        () => {
          reject('No valid permission FirebaseConfig');
        },
      );
      resolve(null);
    });
  }

  clean(): Promise<void> {
    this.fcmMultipleProject.clean();
    return;
  }


}
