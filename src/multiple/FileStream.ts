import type { FirebaseConfig } from './FirebaseConfig';


enum StorageNameEnum {
  FCM_LOCAL_ = 'FCM_LOCAL_',

}

enum StorageLocalKeyEnum {
  FCM_APPS = 'FCM_APPS',
}

class StorageLocal {

  private cache: Map<string, any> = new Map();

  constructor() {
  }

  get(storageLocalKeyEnum: StorageLocalKeyEnum): any {

    const key = StorageNameEnum.FCM_LOCAL_ + storageLocalKeyEnum;

    let fromCache = this.cache.get(key);
    if (!!fromCache === false) {

      const value = localStorage.getItem(key);
      if (value == null || value === 'undefined' || value === undefined || value == '') {
        return null;
      }
      try {
        fromCache = JSON.parse(value);

      } catch (e) {
        fromCache = undefined;
        console.error('StorageLocalService need to refactor: ', e);
      }
      this.cache.set(key,
        fromCache);
    }
    return fromCache;
  }

  set(storageLocalKeyEnum: StorageLocalKeyEnum, value: any): void {

    const key = StorageNameEnum.FCM_LOCAL_ + storageLocalKeyEnum;

    this.cache.set(key,
      value);
    localStorage.setItem(key,
      JSON.stringify(value));
  }

  remove(storageLocalKeyEnum: StorageLocalKeyEnum): void {

    const key = StorageNameEnum.FCM_LOCAL_ + storageLocalKeyEnum;

    this.cache.delete(key);
    localStorage.removeItem(key);
  }

  removeAll(): void {
    this.cache.clear();
    const arr = []; // Array to hold the keys
// Iterate over localStorage and insert the keys that meet the condition into arr
    for (let i = 0; i < localStorage.length; i++) {
      if (localStorage.key(i).substring(0, StorageNameEnum.FCM_LOCAL_.length) === StorageNameEnum.FCM_LOCAL_) {
        arr.push(localStorage.key(i));
      }
    }
    // Iterate over arr and remove the items by key
    // tslint:disable-next-line:prefer-for-of
    arr.forEach((item) => {
      localStorage.removeItem(item);
    });
  }

  setFCMApps(value: FirebaseConfig[]): void {
    this.set(StorageLocalKeyEnum.FCM_APPS, value);
  }

  getFCMApps(): FirebaseConfig[] {
    return this.get(StorageLocalKeyEnum.FCM_APPS) || [];
  }


}

export class FileStream {

  private static storageLocal: StorageLocal = new StorageLocal();

  constructor() {
  }

  readStorage(): FirebaseConfig[] {
    return FileStream.storageLocal.getFCMApps();
  }

  writeEmpty(): void {
    FileStream.storageLocal.setFCMApps([]);
  }

  writeStorage(firebaseConfig: FirebaseConfig): void {
    let firebaseConfigs: FirebaseConfig[] = FileStream.storageLocal.getFCMApps();
    firebaseConfigs = firebaseConfigs
      .filter(config => {
        return config.firebaseAppName !== firebaseConfig.firebaseAppName;
      })
      .filter(config => {
        return config.projectId !== firebaseConfig.projectId;
      });

    firebaseConfigs.push(firebaseConfig);
    FileStream.storageLocal.setFCMApps(firebaseConfigs);
  }

}

