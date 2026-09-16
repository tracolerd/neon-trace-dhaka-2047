<div align="center">

# ◈ NEON//TRACE: DHAKA 2047

### *Investigate the signal. Survive the system.*

<img src="https://readme-typing-svg.demolab.com?font=JetBrains+Mono&size=18&duration=2800&pause=900&color=00F5FF&center=true&vCenter=true&width=620&lines=Observe.+Infiltrate.+Hack.+Escape.;A+cyber-investigation+thriller+set+in+Dhaka+2047.;Stealth+%7C+Hacking+%7C+Evidence+%7C+Security+AI" alt="Animated project tagline" />

<p>
  <img src="https://img.shields.io/badge/ENGINE-Godot%204.x-478CBF?style=for-the-badge&logo=godotengine&logoColor=white" alt="Godot 4.x" />
  <img src="https://img.shields.io/badge/LANGUAGE-GDScript-478CBF?style=for-the-badge&logo=godotengine&logoColor=white" alt="GDScript" />
  <img src="https://img.shields.io/badge/GENRE-Stealth%20%2B%20Investigation-111827?style=for-the-badge" alt="Stealth and investigation" />
  <img src="https://img.shields.io/badge/STATUS-Vertical%20Slice-00B8D4?style=for-the-badge" alt="Vertical slice" />
</p>

</div>

---

## ◈ The Premise

**NEON//TRACE: DHAKA 2047** is a third-person 3D cyber-investigation thriller set in a fictionalized near-future Dhaka.

You are here to **observe, infiltrate, manipulate systems, collect evidence, and get out alive** while uncovering a hidden city-wide control network.

The project is currently focused on a **playable vertical-slice foundation**: the core gameplay systems are being connected into one coherent mission before the world expands into a larger campaign.

---

## ◈ Gameplay Pillars

<table>
<tr>
<td width="20%" align="center"><b>INVESTIGATION</b><br/><sub>Find clues. Read the environment. Build the case.</sub></td>
<td width="20%" align="center"><b>STEALTH</b><br/><sub>Stay hidden. Manage proximity. Control exposure.</sub></td>
<td width="20%" align="center"><b>HACKING</b><br/><sub>Access terminals and manipulate connected systems.</sub></td>
<td width="20%" align="center"><b>SECURITY</b><br/><sub>React to escalating patrol and detection states.</sub></td>
<td width="20%" align="center"><b>NARRATIVE</b><br/><sub>Mission flags, fail states and outcome resolution.</sub></td>
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

- Boot flow and core services
- Third-person player controller
- Acceleration, deceleration, gravity, jump, sprint and crouch states
- Spring-arm third-person camera
- Proximity + raycast interaction
- Doors and terminal interactables
- Scanner system with nearby-object highlighting
- Hacking framework and terminal challenge flow
- Security manager with escalating intensity
- Guard patrol and detection foundations
- Drone and navigation controller placeholders
- Evidence resources, database and pickup flow
- Evidence UI foundation
- Mission, objective and checkpoint management
- Reactive objectives driven by gameplay events
- Mission event logging and narrative status feed
- Save/load continuity for mission and story state
- Stealth fail-state escalation and story flags
- Branching ending-resolution framework
- Exit-zone extraction objective

> **Development focus:** finish and validate the stealth-and-extraction vertical slice before significantly expanding campaign content.

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

The project follows a **modular, data-driven, signal-based architecture** rather than concentrating gameplay logic inside a single controller.

```text
NEON//TRACE: DHAKA 2047
│
├── assets/             → Visual and supporting assets
├── data/               → Data-driven gameplay definitions
├── docs/               → Architecture, testing and development records
├── scenes/             → Godot scene composition
├── scripts/            → Core systems, gameplay, UI, AI and services
├── project.godot       → Engine configuration and input map
├── export_presets.cfg  → Platform export configuration
├── CHANGELOG.md        → Project change history
└── LICENSE             → License terms
```

### Core service boundaries

`EventBus` · `GameManager` · `SettingsManager` · `SaveManager` · `SceneManager` · `AudioManager`

---

## ◈ Tech Stack

| Layer | Technology |
|:--|:--|
| Engine | **Godot 4.x** |
| Language | **GDScript** |
| Rendering | **GL Compatibility** |
| Game Type | **Third-person 3D** |
| Prototype Viewport | **1280 × 720** |
| Architecture | **Modular / Data-driven / Signal-based** |
| Persistence | **Validated save/load boundary** |

---

## ◈ Android Build

A validated Android debug export was produced from the project using **Godot 4.7.2**.

```text
Artifact: NEON_TRACE_DHAKA_2047.apk
ABI:      arm64-v8a
Size:     31,493,639 bytes
SHA-256:  62C7CE927F4E5CB37D0ACAE80847EB2AC926493ABFC2360B31D6F1685BBC7BBE
```

The build output is intentionally ignored by Git, so the repository currently does **not** contain a downloadable APK blob. The values above document the validated local artifact.

### Reproduce the build

```bash
Godot_v4.7.2-stable_win64_console.exe --headless --path . --editor --quit
Godot_v4.7.2-stable_win64_console.exe --headless --path . --export-debug "Android Debug" builds/android/NEON_TRACE_DHAKA_2047.apk
```

---

## ◈ Run Locally

### Requirements

- Godot 4.x
- A desktop environment capable of running a Godot 3D project

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

The long-term design direction treats the city as part of the investigation itself: **surveillance infrastructure, terminals, evidence, patrol routes, urban systems and environmental interactions should feel interconnected.**

---

## ◈ Project Philosophy

> **Build the systems first. Then build the city around them.**

NEON//TRACE is intentionally structured so individual gameplay systems can evolve without forcing the entire project into a monolithic architecture.

---

<div align="center">

### ◈ INVESTIGATE THE SIGNAL ◈
### **SURVIVE THE SYSTEM**

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:00F5FF,100:5B21B6&height=100&section=footer" alt="Animated footer" />

</div>
