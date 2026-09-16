# Build

The project targets Godot 4.7.2 with the Compatibility renderer. The Android debug preset is
`Android Debug` in `export_presets.cfg`; it uses landscape orientation, touch/mouse emulation,
Unicode keyboard input, and signed arm64-v8a plus armeabi-v7a APK libraries.

## Android debug export

From the repository root, with Godot 4.7.2 and its Android export templates installed:

```text
Godot_v4.7.2-stable_win64_console.exe --headless --path . --editor --quit
Godot_v4.7.2-stable_win64_console.exe --headless --path . --export-debug "Android Debug" builds/android/NEON_TRACE_DHAKA_2047.apk
```

The local output directory is intentionally ignored by git. The verified public download for
older ARM/ARM64 Android devices is the signed compatible GitHub Release asset:

**[Download NEON_TRACE_DHAKA_2047_compatible.apk](https://github.com/tracolerd/neon-trace-dhaka-2047/releases/download/v0.1.1-android-compatible/NEON_TRACE_DHAKA_2047_compatible.apk)**

Install the downloaded APK on a test device with:

```text
adb install -r NEON_TRACE_DHAKA_2047.apk
```

The device must allow installation from the browser/file manager (or USB debugging for `adb`).
The APK declares minSdk 24 and includes both `arm64-v8a` and `armeabi-v7a`. Orientation is
landscape. Press the device Back button or the configured pause key to open/close the in-game
pause menu; `Developer Info` is available there.

## Validated compatible artifact

The corrected debug APK was exported successfully with Godot `4.7.2.stable.official.ed1daf0bf`:

- Path: `builds/android/NEON_TRACE_DHAKA_2047_compatible.apk`
- Public download: https://github.com/tracolerd/neon-trace-dhaka-2047/releases/download/v0.1.1-android-compatible/NEON_TRACE_DHAKA_2047_compatible.apk
- Size: `60,816,874` bytes
- SHA-256: `3C62FDE307A650A164579DB8BAB76E78EE035B91488B97C682D368079754DCC1`
- Package: `com.tracolerd.neontrace.dhaka2047`, version `0.1.1`, versionCode `2`
- ABIs: `arm64-v8a`, `armeabi-v7a`
- Signature: verified APK Signature Scheme v2 and v3 with the Godot debug certificate
- Device install: not run; no Android device was connected to `adb`

### Oppo F11 install troubleshooting

The first release was unsigned (`package/signed=false`) and arm64-only; Android can show the
generic “App is not installed” message for that artifact. Use the compatible release above.
If an older build with the same package is already installed under a different signing key,
uninstall it first, then install the new APK:

```text
adb uninstall com.tracolerd.neontrace.dhaka2047
adb install -r NEON_TRACE_DHAKA_2047_compatible.apk
```

Oppo F11 variants shipped with Android 9-era software, so this APK's minSdk 24 is compatible
with that Android API range; actual device installation was not verified because no Oppo device
was connected here.

The export emitted a non-blocking warning because no project icon is configured. It also reported
existing typed-inference/scene parse warnings while packaging; the APK was nevertheless produced
successfully. For a clean runtime verification, address those pre-existing script warnings before
shipping a release build.
