<div align="center">

# ◈ NEON//TRACE: DHAKA 2047

### *Investigate the signal. Survive the system.*

<img src="https://readme-typing-svg.demolab.com?font=JetBrains+Mono&size=18&duration=2800&pause=900&color=00F5FF&center=true&vCenter=true&width=680&lines=Observe.+Infiltrate.+Hack.+Escape.;A+cyber-investigation+thriller+set+in+Dhaka+2047.;Stealth+%7C+Hacking+%7C+Evidence+%7C+Security+AI" alt="Animated project tagline" />

<p>
  <img src="https://img.shields.io/badge/ENGINE-Godot%204.7.2-478CBF?style=for-the-badge&logo=godotengine&logoColor=white" alt="Godot 4.7.2" />
  <img src="https://img.shields.io/badge/LANGUAGE-GDScript-478CBF?style=for-the-badge&logo=godotengine&logoColor=white" alt="GDScript" />
  <img src="https://img.shields.io/badge/GENRE-Stealth%20%2B%20Investigation-111827?style=for-the-badge" alt="Stealth and investigation" />
  <img src="https://img.shields.io/badge/STATUS-Vertical%20Slice-00B8D4?style=for-the-badge" alt="Vertical slice" />
</p>

<p>
  <a href="https://github.com/tracolerd/neon-trace-dhaka-2047/releases/tag/v0.1.1-android-compatible"><strong>↓ Download Android APK</strong></a>
  &nbsp;·&nbsp;
  <a href="https://github.com/tracolerd/neon-trace-dhaka-2047/releases"><strong>View Releases</strong></a>
</p>

</div>

---

## ◈ The Premise

**NEON//TRACE: DHAKA 2047** is a third-person 3D cyber-investigation thriller set in a fictionalized near-future Dhaka.

Observe the environment. Infiltrate controlled spaces. Manipulate connected systems. Collect evidence. Manage security pressure. Reach extraction and uncover what the city is hiding.

The project is built around a **playable vertical-slice foundation**, with the current work focused on tightening the stealth-and-extraction loop before expanding into a larger campaign.

---

## ◈ Gameplay Pillars

<table>
<tr>
<td width="20%" align="center"><b>INVESTIGATION</b><br/><sub>Find clues. Read the environment. Build the case.</sub></td>
<td width="20%" align="center"><b>STEALTH</b><br/><sub>Stay hidden. Manage exposure. Survive detection.</sub></td>
<td width="20%" align="center"><b>HACKING</b><br/><sub>Access terminals and manipulate connected systems.</sub></td>
<td width="20%" align="center"><b>SECURITY</b><br/><sub>Patrols, detection and escalating threat states.</sub></td>
<td width="20%" align="center"><b>NARRATIVE</b><br/><sub>Mission state, fail states and outcome resolution.</sub></td>
</tr>
</table>

---

## ◈ Core Gameplay Loop

```text
┌──────────────────────┐
│     START MISSION    │
└──────────┬───────────┘
           ↓
┌──────────────────────┐
│      EXPLORE         │
│   Observe + Scan     │
└──────────┬───────────┘
           ↓
┌──────────────────────┐
│ INVESTIGATE SYSTEMS  │
│ Evidence + Terminals │
└──────────┬───────────┘
           ↓
┌──────────────────────┐
│    MANAGE THREAT     │
│  Stealth + Security  │
└──────────┬───────────┘
           ↓
┌──────────────────────┐
│     COMPLETE GOAL    │
│   Extraction / Exit  │
└──────────┬───────────┘
           ↓
┌──────────────────────┐
│    RESOLVE OUTCOME   │
└──────────────────────┘
```

---

## ◈ Current Prototype

The repository currently contains the foundation for:

- Boot flow, startup validation and core services
- Third-person player controller with movement states
- Acceleration, deceleration, gravity, jump, sprint and crouch
- Spring-arm third-person camera
- Proximity + raycast interaction
- Doors and terminal interactables
- Scanner system with nearby-object highlighting
- Hacking framework and terminal challenge flow
- Security manager with escalating intensity states
- Guard patrol and distance-based detection foundation
- Drone and navigation controller placeholders
- Evidence resources, database, pickup flow and evidence UI
- Mission, objective and checkpoint management
- Reactive objective progression driven by gameplay events
- Mission event logging and narrative status feed
- Save/load continuity for mission and story state
- Stealth fail-state escalation and story flags
- Branching ending-resolution framework
- Exit-zone extraction objective

> **Current development focus:** complete and validate the stealth-and-extraction vertical slice before significantly expanding world and campaign content.

---

## ◈ Recent Engineering Updates

The latest development pass refines both gameplay foundations and release infrastructure:

| Area | Update |
|:--|:--|
| **Boot / Startup** | Refined boot scene structure with a dedicated loading/status UI and startup controller boundary. |
| **Security AI** | Refined guard presentation, patrol setup and player-threat evaluation with distance-based detection. |
| **Interaction** | Updated interaction logic during the current reliability pass. |
| **Scanner** | Refined scanner behavior and system integration. |
| **Mission Flow** | Tightened mission-manager state handling and extraction/exit progression. |
| **Evidence UI** | Updated the evidence panel scene in the latest prototype pass. |
| **Windows Export** | Added a tracked Windows Desktop export preset for Godot 4.7.2. |
| **Android** | Replaced the earlier unsigned arm64-only build with a signed dual-ABI compatible debug release. |

---

## ◈ Controls

| Action | Key |
|:--|:--:|
| Move | `W` `A` `S` `D` |
| Sprint | `Shift` |
| Crouch | `Ctrl` |
| Jump | `Space` |
| Interact | `E` |
| Scanner | `Q` |
| Inventory | `Tab` |
| Pause | `Esc` |
| Camera | `Arrow Keys` |

---

## ◈ Technical Architecture

The project follows a **modular, data-driven, signal-based architecture** with explicit boundaries between presentation, gameplay, systems and data.

```text
Presentation
     ↓
Gameplay
     ↓
Systems
     ↓
Data
     ↓
Godot Engine
```

Global services are limited to application-wide concerns and communicate through the `EventBus`. Gameplay systems are intentionally kept separate from direct UI manipulation.

### Core service boundaries

`EventBus` · `GameManager` · `SettingsManager` · `SaveManager` · `SceneManager` · `AudioManager`

### Repository structure

```text
NEON//TRACE: DHAKA 2047
│
├── assets/             → Visual and supporting assets
├── data/               → Data-driven gameplay definitions
├── docs/               → Architecture, testing and development records
├── scenes/             → Godot scene composition
├── scripts/            → Gameplay, AI, UI, services and system logic
├── project.godot       → Engine configuration and input map
├── export_presets.cfg  → Platform export configuration
├── CHANGELOG.md        → Project change history
└── LICENSE             → License terms
```

---

## ◈ Tech Stack

| Layer | Technology |
|:--|:--|
| Engine | **Godot 4.7.2** |
| Language | **GDScript** |
| Rendering | **GL Compatibility** |
| Game Type | **Third-person 3D** |
| Prototype Viewport | **1280 × 720** |
| Architecture | **Modular / Data-driven / Signal-based** |
| Persistence | **Validated save/load boundary** |

---

## ◈ Android Release

The current public Android artifact is the **signed compatible debug build** released as `v0.1.1-android-compatible`.

| Property | Value |
|:--|:--|
| Release | `v0.1.1-android-compatible` |
| Artifact | `NEON_TRACE_DHAKA_2047_compatible.apk` |
| Engine | **Godot 4.7.2** |
| Orientation | **Landscape** |
| ABIs | **arm64-v8a + armeabi-v7a** |
| Min SDK | **24** |
| Version | **0.1.1** (`versionCode 2`) |
| Size | **60,816,874 bytes** |
| SHA-256 | `3C62FDE307A650A164579DB8BAB76E78EE035B91488B97C682D368079754DCC1` |
| Signature | **APK Signature Scheme v2 + v3** with the Godot debug certificate |

### Download

**[Download NEON_TRACE_DHAKA_2047_compatible.apk](https://github.com/tracolerd/neon-trace-dhaka-2047/releases/download/v0.1.1-android-compatible/NEON_TRACE_DHAKA_2047_compatible.apk)**

> This is a **debug build**. The artifact was exported and verified, but device installation was not exercised because no Android device was connected to `adb` during validation.

### Reproduce the build

```bash
Godot_v4.7.2-stable_win64_console.exe --headless --path . --editor --quit
Godot_v4.7.2-stable_win64_console.exe --headless --path . --export-debug "Android Debug" builds/android/NEON_TRACE_DHAKA_2047_compatible.apk
```

Install a downloaded APK with:

```bash
adb install -r NEON_TRACE_DHAKA_2047_compatible.apk
```

If an older build with the same package is installed under a different signing key, uninstall it first:

```bash
adb uninstall com.tracolerd.neontrace.dhaka2047
adb install -r NEON_TRACE_DHAKA_2047_compatible.apk
```

Package name: `com.tracolerd.neontrace.dhaka2047`.

---

## ◈ Run Locally

### Requirements

- Godot 4.7.2 stable
- Windows 10/11 for the Windows Desktop export

### Launch

```text
1. Clone the repository
2. Open Godot
3. Import / Open Project
4. Select project.godot
5. Run the project
```

The configured entry scene is `scenes/boot/Boot.tscn`.

---

## ◈ Windows Export

A tracked **Windows Desktop** export preset is included for Godot 4.7.2.

From the Godot editor:

```text
Project → Export → Windows Desktop → Export Project
```

Or from a compatible Godot 4.7.2 console build:

```bash
godot --headless --path . --editor --quit
godot --headless --path . --export-release "Windows Desktop" builds/windows/NEON_TRACE_DHAKA_2047.exe
```

Build output remains ignored by Git; release binaries belong in GitHub Releases or another artifact store rather than in the source tree.

---

## ◈ Development Roadmap

```text
[✓] Project Bootstrap
[✓] Core Services
[✓] Player Foundation
[✓] Interaction
[✓] Scanner
[✓] Hacking Foundation
[✓] Security & AI Foundation
[✓] Evidence System Foundation
[✓] Mission Framework
[→] Stealth + Extraction Vertical Slice
[ ] Hub + World Content
[ ] Narrative Expansion
[ ] Visual Polish
[ ] Release Preparation
```

---

## ◈ Documentation

| Document | Purpose |
|:--|:--|
| [`docs/PROGRESS.md`](docs/PROGRESS.md) | Implementation progress and active milestone |
| [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) | System and architecture notes |
| [`docs/GAME_DESIGN.md`](docs/GAME_DESIGN.md) | Gameplay design notes |
| [`docs/CONTROLS.md`](docs/CONTROLS.md) | Input and control reference |
| [`docs/BUILD.md`](docs/BUILD.md) | Build and export instructions |
| [`docs/TESTING.md`](docs/TESTING.md) | Validation and testing records |
| [`docs/DEVELOPMENT.md`](docs/DEVELOPMENT.md) | Development conventions |
| [`CHANGELOG.md`](CHANGELOG.md) | Change history |

---

## ◈ Design Direction

Dhaka is not just a backdrop.

The long-term design direction treats the city itself as part of the investigation: **surveillance infrastructure, terminals, evidence, patrol routes, security states and environmental interactions should feel interconnected.**

---

## ◈ Project Philosophy

> **Build the systems first. Then build the city around them.**

NEON//TRACE is intentionally structured so individual gameplay systems can evolve independently without forcing the entire project into a monolithic controller or tightly coupled feature stack.

---

<div align="center">

### ◈ INVESTIGATE THE SIGNAL ◈
### **SURVIVE THE SYSTEM**

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:00F5FF,100:5B21B6&height=100&section=footer" alt="Animated footer" />

</div>
