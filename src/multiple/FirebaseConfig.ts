export interface FirebaseConfig {
  firebaseAppName: string;
  apiKey: string;
  applicationId: string;
  databaseUrl: string;
  gaTrackingId: string;
  gcmSenderId: string;
  storageBucket: string;
  projectId: string;
  measurementId: string;
}

export interface FirebaseToken {
  token: string;
  firebaseAppName: string;
}

export interface FirebaseTokenError {
  error: string;
  firebaseAppName: string;
}

//todo nabu remove it
export enum StorageNameEnum {
  STORAGE_LOCAL = 'LOCAL_',
  STORAGE_LOCAL_PROFILE = 'LOCAL_PROFILE_',

}

export enum StorageLocalKeyEnum {
  FCM_APPS = 'FCM_APPS',
}

export const FCM_EVENT_TOKEN_SUCCESS = 'multipleToken';
export const FCM_EVENT_TOKEN_ERROR = 'multipleTokenError';
