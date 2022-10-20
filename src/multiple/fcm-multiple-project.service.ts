import type { FirebaseOptions } from '@firebase/app';
import { deleteApp } from '@firebase/app';
import type { Messaging } from '@firebase/messaging';
import type { FirebaseApp } from 'firebase/app';
import { getApp, getApps, initializeApp } from 'firebase/app';
import { getMessaging, getToken } from 'firebase/messaging';

import type { FCMMultipleProjectI } from './FCMMultipleProjectI';
import { FileStream } from './FileStream';
import type { FirebaseConfig } from './FirebaseConfig';

export class FcmMultipleProjectService implements FCMMultipleProjectI {

  private fileStream: FileStream = new FileStream();

  constructor() {
    console.error('init FcmMultipleProjectService');
    this.init();
  }


  test(): void {
    // this.add(firebaseConfig);
    // firebaseConfig.firebaseAppName = 'third';
    // this.add(firebaseConfig);
    // firebaseConfig.firebaseAppName = 'forth';
    // this.add(firebaseConfig);

    // todo nabu check how to work with add method if equal config but different name

  }


  init(): void {

    const firebaseConfigs: FirebaseConfig[] = this.fileStream.readStorage();
    firebaseConfigs.forEach(firebaseConfig => this.initializeApp(firebaseConfig));

  }


  add(firebaseConfig: FirebaseConfig): void {
    this.hasRights(firebaseConfig, () => {
      this.fileStream.writeStorage(firebaseConfig);
      this.remove(firebaseConfig);
      this.initializeApp(firebaseConfig);

    }, () => {
      console.error('hasRights error');
    });
  }


  clean(): void {
    const defaultFirebaseApp = this.getDefaultInstance();
    getApps()
      .filter(firebasApp => firebasApp.name !== defaultFirebaseApp.name)
      .forEach(firebaseApp => deleteApp(firebaseApp));

    this.fileStream.writeEmpty();
  }


  remove(firebaseConfig: FirebaseConfig): void {

    try {
      const firebaseApp: FirebaseApp = this.getInstance(firebaseConfig.firebaseAppName);
      console.error('InstanceApp has exist: ', firebaseConfig.firebaseAppName);
      if (firebaseApp.name === this.getDefaultInstance().name) {
        //default
        return;
      }
      deleteApp(firebaseApp).then();

    } catch (e) {
      console.error('InstanceApp not found:', firebaseConfig.firebaseAppName);
    }
  }

  getToken(firebaseConfig: FirebaseConfig, apply: (value: any) => void, reject: (value: any) => void): void {
    const firebaseMessaging: Messaging = this.getFirebaseMessaging(firebaseConfig);

    getToken(firebaseMessaging)
      .then((currentToken) => {
        console.error('currentToken', currentToken);
        apply(currentToken);
      })
      .catch((err) => {
        console.error('An error occurred while retrieving token. ', err);
        reject(err);
      });

  }


  getDefaultInstance(): FirebaseApp {
    return getApp();
  }

  getInstance(firebaseAppName: string): FirebaseApp {
    return getApp(firebaseAppName);
  }

  getFirebaseMessaging(firebaseConfig: FirebaseConfig): Messaging {

    const firebaseApp: FirebaseApp = this.getInstance(firebaseConfig.firebaseAppName);

    return getMessaging(firebaseApp);
  }

  createFirebaseConfig(obj: any): FirebaseConfig {

    const firebaseConfig: FirebaseConfig = obj;
    // used projectId because projectId has unique value from firebase
    firebaseConfig.firebaseAppName = firebaseConfig.projectId;
    return firebaseConfig;
  }


  hasRights(firebaseConfig: FirebaseConfig, apply: (value: any) => void, reject: (value: any) => void): void {
    if (!firebaseConfig?.firebaseAppName || !firebaseConfig?.projectId) {
      reject(null);
    } else {
      apply(null);
    }
  }


  initializeApp(firebaseConfig: FirebaseConfig): FirebaseApp {

    let firebaseApp: FirebaseApp;
    try {
      firebaseApp = this.getInstance(firebaseConfig.firebaseAppName);
      console.error('InstanceApp has exist: ', firebaseConfig.firebaseAppName);
    } catch (e) {
      console.error('InstanceApp not found:', firebaseConfig.firebaseAppName);
      const options: FirebaseOptions = this.createFirebaseOptions(firebaseConfig);
      firebaseApp = initializeApp(options, firebaseConfig.firebaseAppName);

    }
    return firebaseApp;
  }

  createFirebaseOptions(firebaseConfig: FirebaseConfig): FirebaseOptions {
    const firebaseOptions: FirebaseOptions = {
      apiKey: firebaseConfig.apiKey,
      authDomain: undefined,
      databaseURL: firebaseConfig?.databaseUrl,
      projectId: firebaseConfig?.projectId,
      storageBucket: firebaseConfig?.storageBucket,
      messagingSenderId: firebaseConfig?.gcmSenderId,
      appId: firebaseConfig.applicationId,
      measurementId: firebaseConfig.measurementId,
    };
    return firebaseOptions;
  }


}
