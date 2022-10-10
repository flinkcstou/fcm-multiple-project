# fcm-multiple-project

Firebase messaging multiple project. It send push notification from multiple project firebase.

## Install

```bash
npm install fcm-multiple-project
npx cap sync
```

## API

<docgen-index>

* [`echo(...)`](#echo)
* [`add(...)`](#add)
* [`addListener(...)`](#addlistener)
* [`addListener(...)`](#addlistener)
* [`removeAllListeners()`](#removealllisteners)
* [`clean()`](#clean)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### echo(...)

```typescript
echo(options: { value: string; }) => Promise<{ value: string; }>
```

| Param         | Type                            |
| ------------- | ------------------------------- |
| **`options`** | <code>{ value: string; }</code> |

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


### add(...)

```typescript
add(firebaseConfig: FirebaseConfig) => Promise<void>
```

| Param                | Type                                                      |
| -------------------- | --------------------------------------------------------- |
| **`firebaseConfig`** | <code><a href="#firebaseconfig">FirebaseConfig</a></code> |

--------------------


### addListener(...)

```typescript
addListener(eventName: 'multipleToken', listenerFunc: (token: FirebaseToken) => void) => Promise<PluginListenerHandle> & PluginListenerHandle
```

| Param              | Type                                                                        |
| ------------------ | --------------------------------------------------------------------------- |
| **`eventName`**    | <code>"multipleToken"</code>                                                |
| **`listenerFunc`** | <code>(token: <a href="#firebasetoken">FirebaseToken</a>) =&gt; void</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt; & <a href="#pluginlistenerhandle">PluginListenerHandle</a></code>

--------------------


### addListener(...)

```typescript
addListener(eventName: 'multipleTokenError', listenerFunc: (error: FirebaseTokenError) => void) => Promise<PluginListenerHandle> & PluginListenerHandle
```

| Param              | Type                                                                                  |
| ------------------ | ------------------------------------------------------------------------------------- |
| **`eventName`**    | <code>"multipleTokenError"</code>                                                     |
| **`listenerFunc`** | <code>(error: <a href="#firebasetokenerror">FirebaseTokenError</a>) =&gt; void</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt; & <a href="#pluginlistenerhandle">PluginListenerHandle</a></code>

--------------------


### removeAllListeners()

```typescript
removeAllListeners() => Promise<void>
```

--------------------


### clean()

```typescript
clean() => Promise<void>
```

--------------------


### Interfaces


#### FirebaseConfig

| Prop                  | Type                |
| --------------------- | ------------------- |
| **`firebaseAppName`** | <code>string</code> |
| **`apiKey`**          | <code>string</code> |
| **`applicationId`**   | <code>string</code> |
| **`databaseUrl`**     | <code>string</code> |
| **`gaTrackingId`**    | <code>string</code> |
| **`gcmSenderId`**     | <code>string</code> |
| **`storageBucket`**   | <code>string</code> |
| **`projectId`**       | <code>string</code> |
| **`measurementId`**   | <code>string</code> |


#### PluginListenerHandle

| Prop         | Type                                      |
| ------------ | ----------------------------------------- |
| **`remove`** | <code>() =&gt; Promise&lt;void&gt;</code> |


#### FirebaseToken

| Prop                  | Type                |
| --------------------- | ------------------- |
| **`token`**           | <code>string</code> |
| **`firebaseAppName`** | <code>string</code> |


#### FirebaseTokenError

| Prop                  | Type                |
| --------------------- | ------------------- |
| **`error`**           | <code>string</code> |
| **`firebaseAppName`** | <code>string</code> |

</docgen-api>
