# Android setup

This document summarizes instructions on how to get set up with the project on android. The main source of this documentation is [Godot's official android export section](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_android.html).

## Requirements

Before you can run the game on an Android device, you will need to setup the following tools on your computer.

### OpenJDK

#### On Windows

Go to the [godot's recommended website of openjdk archive](https://adoptium.net/temurin/releases/?variant=openjdk17&version=17&os=any&arch=any) and download the windows version. Once the file is downloaded, execute it to proceed to installation.

To check if everything was installed correctly, you can simply enter the following command in the terminal

```bash
java --version
# openjdk 17.0.17 2025-10-21
# OpenJDK Runtime Environment Temurin-17.0.17+10 (build 17.0.17+10)
# OpenJDK 64-Bit Server VM Temurin-17.0.17+10 (build 17.0.17+10, mixed mode, sharing)
```

Once it's done, retrieve the installation path by using the following command :

```bash
where java
# C:\Program Files\Eclipse Adoptium\jdk-17.0.17.10-hotspot\bin\java.exe
```

You can copy the path to the SDK directory (`C:\Program Files\Eclipse Adoptium\jdk-17.0.17.10-hotspot`) and then in Godot, you can go to `Editor > Editor Settings > Export > Android`. You can copy paste the path inside the Java SDK Path input.

### Android SDK

The recommanded way of configuring Android SDK is to install [Android Studio from the official website](https://developer.android.com/studio?hl=fr) and install the SDK from the software. However, since the software is 1.5 Go, here we will take the second route using the `sdkmanager` tool.

Once the manager zip file is installed you can follow [this tutorial by android developers](https://developer.android.com/tools/sdkmanager?hl=fr) to set it up. You need to :
- Extract the `commandlinetools-win-*.zip`
- Then copy the `cmdline-tools` directory to `C:\Program Files\AndroidSDK\` directory

> Optionnaly, you can move the content within `cmdline-tools` inside a `latest` directory as the documentation suggests.

The copy the path to the `bin` directory and add it to your path. To test that everything works, you can use the following command.

```bash
sdkmanager --version
# 19.0
```

Then you can use the following command to install the Android SKD.

```bash
sdkmanager --sdk_root=C:\PROGRA~1\AndroidSDK\ "platform-tools" "build-tools;35.0.1" "platforms;android-35" "cmdline-tools;latest" "cmake;3.10.2.4988404" "ndk;28.1.13356709"
```

> `PROGRA~1` is because Windows sucks so bad with is slash system, and Android sucks so bad with the `sdkmanager` cli that they both can't handle the space in `Program Files`...

Once everything is downloaded, in Godot go to `Editor > Editor Settings > Export > Android` and copy paste the Android SDK root path `C:\Program Files\AndroidSDK\` inside the Android SDK input.

### Phone in dev mode

You must connect a phone with dev mode and usb debog for Godot to detect your device. To do so :
1. Enable developer mode on your phone (look at your phone's vendor instructions)
2. In your dev settings, enable USB Debog.
3. If your phone is plugged in your computer, you should see a popup saying that the computer is requesting access.

Once access is granted, you should see a new play button inside Godot's editor. This is the remote debug play button, and if everything was set up correctly, you should see an Android section with your device name in it.

**You are all set !**

## Run the game

Do run the game, you can simply hit the play button. This will build and export an apk and deploy it to your phone. When launching the game remotely from godot to your phone, you have access to Godot's debugging features like breakpoints and log messages.

Once your phone is unplugged, you will see that the game can still be launched from your phone.

> Unfortunately, you can remote debug the game on your phone from vscode.