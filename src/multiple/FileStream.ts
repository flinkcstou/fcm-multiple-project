import type { FirebaseConfig } from './FirebaseConfig';
import type { StorageLocalService } from './storage-local.service';

export class FileStream {


  constructor(private storageLocalService: StorageLocalService) {
  }

  readStorage(): FirebaseConfig[] {
    return this.storageLocalService.getFCMApps();
  }

  writeEmpty(): void {
    this.storageLocalService.setFCMApps([]);
  }

  writeStorage(firebaseConfig: FirebaseConfig): void {
    let firebaseConfigs: FirebaseConfig[] = this.storageLocalService.getFCMApps();
    firebaseConfigs = firebaseConfigs
      .filter(config => {
        return config.firebaseAppName !== firebaseConfig.firebaseAppName;
      })
      .filter(config => {
        return config.projectId !== firebaseConfig.projectId;
      });

    firebaseConfigs.push(firebaseConfig);
    this.storageLocalService.setFCMApps(firebaseConfigs);
  }

}
