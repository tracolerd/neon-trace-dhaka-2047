# Build

## Toolchain

- Godot 4.7.2 stable
- Compatibility renderer, as configured in `project.godot`
- Godot 4.7.2 export templates for Windows Desktop

## Headless project validation

Run these commands from the repository root:

```text
godot --headless --path . --editor --quit
```

The command imports project resources, parses scenes/scripts and exits without opening the editor UI.

## Windows Desktop export

The tracked `export_presets.cfg` contains the `Windows Desktop` release preset. Install the matching export templates, then run:

```text
godot --headless --path . --export-release "Windows Desktop" builds/windows/NEON_TRACE_DHAKA_2047.exe
```

The executable and accompanying `.pck` are written to `builds/windows/`, which is ignored by Git. Do not commit generated build output to the source repository.

## Release checklist

1. Run headless project validation.
2. Export the Windows Desktop preset.
3. Launch the generated executable on a clean Windows machine.
4. Record the Godot version, export path and validation result in the release notes.
