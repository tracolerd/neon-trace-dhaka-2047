# NEON//TRACE: DHAKA 2047

A focused third-person 3D cyber-investigation thriller set in a fictionalized Dhaka, 2047. Combine observation, stealth, environmental manipulation and hacking to uncover a hidden city-wide system of control.

## Project status

The project is in the vertical-slice prototype phase. The current foundation includes:

- Boot flow and core scene loading
- Third-person player movement, sprint, crouch and jump
- Interaction, scanning and environmental evidence
- Terminal hacking and signal-alignment puzzle flow
- Security intensity, guard detection and mission progression
- Ending resolution, fail-state handling and save continuity

The project targets Godot 4.7.2 and uses the Compatibility renderer. See [`CHANGELOG.md`](CHANGELOG.md) for the current release record and [`docs/PROGRESS.md`](docs/PROGRESS.md) for implementation status.

## Developer

### Nurul Faiyaz

![Developer Photo](assets/developer/nurul-faiyaz.jpg)

- Portfolio: https://nurul-faiyaz.netlify.app/
- Email: scrollfaiyaz@gmail.com
- Facebook: https://www.facebook.com/faiyaz.888
- Instagram: https://www.instagram.com/tracolerd
- LinkedIn: https://www.linkedin.com/in/faiyaz-xyz
- Twitter: https://x.com/faiyaz_explores
- GitHub: https://github.com/tracolerd

## Requirements

- Godot 4.7.2 stable
- Windows 10/11 for the Windows Desktop export

## Run locally

1. Install Godot 4.7.2 (the project targets Godot 4.x and was validated on the 4.7.2 stable build).
2. Open Godot and choose `Open Project`.
3. Select `project.godot` in this folder.
4. Press `F6`/`F5` or click `Run Project`.
5. Use the following controls:
   - WASD: move
   - Shift: sprint
   - Ctrl: crouch
   - Space: jump
   - E: interact
   - Q: scanner
   - Esc: close hacking UI
6. The prototype loop is:
   - start mission
   - interact with the terminal and evidence
   - avoid or manipulate guard detection
   - escape through the exit zone
   - experience the resolved ending

## Export a Windows build

The tracked [`export_presets.cfg`](export_presets.cfg) defines the Windows Desktop release preset. Export templates are required; install the matching 4.7.2 templates through the Godot editor before exporting.

From the Godot editor:

1. Open `Project > Export`.
2. Select `Windows Desktop`.
3. Confirm the output path is `builds/windows/NEON_TRACE_DHAKA_2047.exe`.
4. Click `Export Project`.

From a terminal:

```text
godot --headless --path . --editor --quit
godot --headless --path . --export-release "Windows Desktop" builds/windows/NEON_TRACE_DHAKA_2047.exe
```

Build output is intentionally ignored by Git. Keep release binaries in the build artifacts for a release rather than committing them to the source repository.

## Documentation

- [`docs/BUILD.md`](docs/BUILD.md): validation and export commands
- [`docs/CONTROLS.md`](docs/CONTROLS.md): gameplay controls
- [`docs/PROGRESS.md`](docs/PROGRESS.md): implementation roadmap
- [`docs/TESTING.md`](docs/TESTING.md): foundation test matrix
- [`LICENSE`](LICENSE): project license

## Development order

1. Project bootstrap
2. Core services
3. Player
4. Interaction
5. Scanner
6. Hacking
7. Security and AI
8. Evidence and missions
9. Vertical slice
10. Hub, content, polish and release

See `docs/PROGRESS.md` and `docs/DEVELOPMENT.md` for the active implementation record.
