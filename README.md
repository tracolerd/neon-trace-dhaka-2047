# NEON//TRACE: DHAKA 2047

> **A third-person 3D cyber-investigation thriller set in a fictionalized Dhaka, 2047.**
>
> Observe. Infiltrate. Hack. Collect evidence. Escape.

NEON//TRACE: DHAKA 2047 is a narrative-driven stealth and investigation prototype built around a dense cyberpunk vision of future Dhaka. The player investigates a hidden city-wide control system by combining environmental observation, stealth, hacking, evidence collection, security-system manipulation, and branching mission outcomes.

---

## Overview

The project is designed as a focused **vertical-slice foundation** rather than a full campaign. Its core gameplay loop connects player movement, interaction, scanning, hacking, security AI, evidence, objectives, mission state, fail states, and ending resolution into one coherent prototype experience.

### Core pillars

| Pillar | Description |
| --- | --- |
| **Investigation** | Discover terminals, evidence, environmental clues, and mission-critical information. |
| **Stealth** | Avoid detection, manage proximity, and respond to escalating security states. |
| **Hacking** | Interact with terminals through a lightweight, extensible hacking framework. |
| **Systems** | Use scanner feedback, security behavior, and environmental interactions to progress. |
| **Narrative** | Mission state, story flags, fail states, and ending resolution support branching outcomes. |

---

## Current Status

**Playable prototype foundation / vertical-slice development**

Implemented systems currently include:

- Boot flow and project configuration
- Player movement with acceleration, deceleration, gravity, jumping, sprinting, and crouching
- Third-person spring-arm camera
- Proximity + raycast interaction system
- Doors and terminal interactables
- Scanner toggle and nearby-object highlighting
- Hacking system foundation with puzzle/challenge support and terminal integration
- Security manager with escalating intensity states
- Guard patrol and detection foundations
- Drone and navigation controller placeholders
- Evidence resources, database, pickup flow, and evidence UI foundation
- Mission, objective, checkpoint, and progression management
- Reactive objective completion through evidence and terminal events
- Mission event log and narrative status feed
- Save/load continuity for mission and story state
- Stealth fail-state escalation and story flags
- Branching ending-resolution framework
- Exit-zone based extraction objective for a complete prototype loop

The active implementation record is maintained in [`docs/PROGRESS.md`](docs/PROGRESS.md). citeturn2file0

---

## Gameplay Loop

The intended prototype flow is:

```text
Start Mission
     ↓
Explore the Environment
     ↓
Scan & Interact
     ↓
Collect Evidence / Hack Systems
     ↓
Manage Security & Avoid Detection
     ↓
Complete Objectives
     ↓
Reach Extraction
     ↓
Resolve Mission Outcome
```

The prototype is intentionally structured so that individual systems can evolve into a larger stealth-investigation game without tightly coupling all gameplay logic together.

---

## Controls

| Action | Input |
| --- | --- |
| Move | `W` `A` `S` `D` |
| Sprint | `Shift` |
| Crouch | `Ctrl` |
| Jump | `Space` |
| Interact | `E` |
| Scanner | `Q` |
| Inventory | `Tab` |
| Pause | `Esc` |
| Camera | Arrow Keys |

Input actions are defined in the Godot project configuration. fileciteturn5file0

---

## Technical Stack

- **Engine:** Godot 4.x
- **Language:** GDScript
- **Rendering:** GL Compatibility renderer
- **Perspective:** Third-person 3D
- **Target Resolution:** 1280 × 720 prototype viewport
- **Architecture:** Modular, data-driven, signal-based systems
- **Persistence:** Versioned save/load boundary with validation

The project configuration currently targets Godot 4.x and defines the core autoload services, rendering mode, viewport, and input map. fileciteturn5file0

---

## Architecture

The codebase is organized around focused system boundaries instead of one monolithic gameplay controller.

```text
NEON//TRACE
├── assets/        # Game assets and supporting resources
├── data/          # Data-driven gameplay definitions
├── docs/          # Development and progress documentation
├── scenes/        # Godot scenes and gameplay composition
├── scripts/       # Core gameplay, services, UI, AI, and systems
├── project.godot  # Project configuration and input mapping
├── CHANGELOG.md   # Project change history
└── LICENSE        # Project license
```

Core services are exposed through Godot autoloads, including event routing, game state, settings, saving, scene transitions, and audio management. fileciteturn5file0

The development guidelines emphasize focused, data-driven, signal-based systems and milestone-oriented development. fileciteturn3file0

---

## Development Roadmap

The project follows a milestone-based development order:

1. Project Bootstrap
2. Core Services
3. Player
4. Interaction
5. Scanner
6. Hacking
7. Security & AI
8. Evidence System
9. Mission Framework
10. Vertical Slice
11. Hub, Content & Polish
12. Release Preparation

The current priority is completing and validating the **stealth-and-extraction vertical slice** before expanding into larger campaign content. fileciteturn2file0

---

## Running Locally

### Requirements

- **Godot 4.x**
- A desktop environment capable of running the Godot editor and a 3D project

### Launch

1. Clone the repository.
2. Open Godot.
3. Select **Import** / **Open Project**.
4. Choose `project.godot` from the repository root.
5. Press **F6/F5** as appropriate, or use **Run Project** from the editor.

The configured main scene is the project's boot scene. fileciteturn5file0

---

## Export

The repository includes export configuration for desktop and web targets.

From Godot:

```text
Project → Export
```

Select the desired preset, configure the output path, and export the project for the target platform.

---

## Documentation

| Document | Purpose |
| --- | --- |
| [`docs/PROGRESS.md`](docs/PROGRESS.md) | Current implementation progress and next milestone |
| [`docs/DEVELOPMENT.md`](docs/DEVELOPMENT.md) | Development conventions and architectural guidelines |
| [`CHANGELOG.md`](CHANGELOG.md) | Project change history |
| [`LICENSE`](LICENSE) | License terms |

---

## Design Direction

**NEON//TRACE: DHAKA 2047** is built around a fictionalized near-future Dhaka where surveillance, infrastructure, data, and urban systems intersect.

The design goal is to make the city itself part of the investigation: security networks, terminals, evidence, patrol routes, and environmental interactions should feel like connected parts of one living system rather than isolated game mechanics.

The project deliberately prioritizes a strong, testable vertical slice before broadening the world, campaign content, or visual scope.

---

## Project Philosophy

> **Build the systems first. Then build the city around them.**

The repository follows a modular approach so gameplay features can be tested, extended, and replaced independently as development progresses.

---

## License

See [`LICENSE`](LICENSE) for the applicable license terms.

---

<div align="center">

**NEON//TRACE: DHAKA 2047**

*Investigate the signal. Survive the system.*

</div>
