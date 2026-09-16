# NEON//TRACE: DHAKA 2047

A focused third-person 3D cyber-investigation thriller set in a fictionalized Dhaka, 2047. The player combines observation, stealth, environmental manipulation and hacking to uncover a hidden city-wide system of control.

## Status

The project has reached a playable prototype foundation with boot flow, player movement, interaction, scanner, hacking, security AI, evidence, mission logic, ending resolution, fail-state handling, and save continuity. Runtime validation was completed in the local environment using Godot 4.7.2.

## Developer Info

### Nurul Faiyaz

![Developer Photo](assets/developer/nurul-faiyaz.jpg)

- Portfolio: https://nurul-faiyaz.netlify.app/
- Email: scrollfaiyaz@gmail.com
- Facebook: https://www.facebook.com/faiyaz.888
- Instagram: https://www.instagram.com/tracolerd
- LinkedIn: https://www.linkedin.com/in/faiyaz-xyz
- Twitter: https://x.com/faiyaz_explores
- GitHub: https://github.com/tracolerd

## Local play

1. Install Godot 4.7.2 (the project targets Godot 4.x and was validated on the 4.7.2 stable build).
2. Open Godot and choose `Open Project`.
3. Select `project.godot` in this folder.
4. Press `F5` or click `Run Project`.
5. Controls:
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

## Local export and deployment

This project includes a basic `export_presets.cfg` for:
- Windows Desktop export
- Web export

To export from Godot:
1. Open the project in Godot.
2. Go to `Project > Export`.
3. Add the preset you want:
   - `Windows Desktop`
   - `Web`
4. Set the output path (for example `builds/windows` or `builds/web`).
5. Click `Export Project`.

For a Windows release, it will generate a `.exe` in the chosen build folder. For web deployment, it will generate HTML5 files that can be served from a static host such as GitHub Pages, Netlify, or any web server.

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
