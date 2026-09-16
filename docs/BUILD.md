# Build

The project targets Godot 4.7.2 with the Compatibility renderer. The Android debug preset is
`Android Debug` in `export_presets.cfg`; it uses landscape orientation, touch/mouse emulation,
Unicode keyboard input, and an arm64-v8a APK.

## Android debug export

From the repository root, with Godot 4.7.2 and its Android export templates installed:

```text
godot --headless --path . --editor --quit
godot --headless --path . --export-debug "Android Debug" builds/android/neon-trace-dhaka-2047-debug.apk
```

The output directory is intentionally ignored by git. Install the APK on a test device with:

```text
adb install -r builds/android/neon-trace-dhaka-2047-debug.apk
```

The device must allow USB debugging and support arm64-v8a. Orientation is landscape. Press the
device Back button or the configured pause key to open/close the in-game pause menu; `Developer
Info` is available there.

## Current validation

Godot 4.7.2 export templates and the Android SDK directories are present in the local user
installation, but the Godot editor/CLI was not available in this environment at validation time.
Therefore no APK was generated here; run the commands above on a machine with the Godot editor/CLI,
SDK, JDK, and templates configured.
