import type { FirebaseConfig} from './FirebaseConfig';
import { StorageLocalKeyEnum, StorageNameEnum } from './FirebaseConfig';

export class StorageLocalService {

  private cache: Map<string, any> = new Map();

  constructor() {
  }

  get(storageLocalKeyEnum: StorageLocalKeyEnum): any {

    const key = StorageNameEnum.STORAGE_LOCAL + storageLocalKeyEnum;

    let fromCache = this.cache.get(key);
    if (!!fromCache === false) {

      const value = localStorage.getItem(key);
      if (value == null || value === 'undefined' || value === undefined) {
        return null;
      }
      fromCache = JSON.parse(value);
      this.cache.set(key,
        fromCache);
    }
    return fromCache;
  }

  set(storageLocalKeyEnum: StorageLocalKeyEnum, value: any): void {

    const key = StorageNameEnum.STORAGE_LOCAL + storageLocalKeyEnum;

    this.cache.set(key,
      value);
    localStorage.setItem(key,
      JSON.stringify(value));
  }

  remove(storageLocalKeyEnum: StorageLocalKeyEnum): void {

    const key = StorageNameEnum.STORAGE_LOCAL + storageLocalKeyEnum;

    this.cache.delete(key);
    localStorage.removeItem(key);
  }

  removeAll(): void {
    this.cache.clear();
    const arr = []; // Array to hold the keys
// Iterate over localStorage and insert the keys that meet the condition into arr
    for (let i = 0; i < localStorage.length; i++) {
      if (localStorage.key(i).substring(0, StorageNameEnum.STORAGE_LOCAL.length) === StorageNameEnum.STORAGE_LOCAL) {
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

