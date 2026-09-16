# Build

The project targets Godot 4.7.2 with the Compatibility renderer. The Android debug preset is
`Android Debug` in `export_presets.cfg`; it uses landscape orientation, touch/mouse emulation,
Unicode keyboard input, and an arm64-v8a APK.

## Android debug export

From the repository root, with Godot 4.7.2 and its Android export templates installed:

```text
Godot_v4.7.2-stable_win64_console.exe --headless --path . --editor --quit
Godot_v4.7.2-stable_win64_console.exe --headless --path . --export-debug "Android Debug" builds/android/NEON_TRACE_DHAKA_2047.apk
```

The output directory is intentionally ignored by git. Install the APK on a test device with:

```text
adb install -r builds/android/NEON_TRACE_DHAKA_2047.apk
```

The device must allow USB debugging and support arm64-v8a. Orientation is landscape. Press the
device Back button or the configured pause key to open/close the in-game pause menu; `Developer
Info` is available there.

## Validated artifact

The debug APK was exported successfully with Godot `4.7.2.stable.official.ed1daf0bf`:

- Path: `builds/android/NEON_TRACE_DHAKA_2047.apk`
- Size: `31,493,639` bytes
- SHA-256: `62C7CE927F4E5CB37D0ACAE80847EB2AC926493ABFC2360B31D6F1685BBC7BBE`
- ABI: `arm64-v8a`
- Device install: not run; no Android device was connected to `adb`

The export emitted a non-blocking warning because no project icon is configured. It also reported
existing typed-inference/scene parse warnings while packaging; the APK was nevertheless produced
successfully. For a clean runtime verification, address those pre-existing script warnings before
shipping a release build.
