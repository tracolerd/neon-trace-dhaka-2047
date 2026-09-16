# Testing

## Foundation test cases

| ID | Title | Expected Result | Status |
|---|---|---|---|
| BOOT-001 | Boot loads core scene | Boot validates input and transitions to Game | NOT VERIFIED — Godot 4.x unavailable |
| SAVE-001 | Invalid save is rejected | Invalid JSON/version does not replace defaults | NOT VERIFIED — Godot 4.x unavailable |
| SET-001 | Settings persist | Known settings save and reload from user config | NOT VERIFIED — Godot 4.x unavailable |
| AUDIO-001 | Audio buses initialize | Required buses exist at runtime | NOT VERIFIED — Godot 4.x unavailable |
| PLAYER-001 | Player moves | WASD changes player position with acceleration/deceleration | NOT VERIFIED — Godot 4.x unavailable |
| PLAYER-002 | Player jump/crouch/sprint | Space, Ctrl and Shift change movement behavior/state | NOT VERIFIED — Godot 4.x unavailable |
| PLAYER-003 | Camera follows | Camera follows player and responds to mouse orbit | NOT VERIFIED — Godot 4.x unavailable |
| INTERACT-001 | Interaction prompt appears | Nearby interactable shows UI prompt | NOT VERIFIED — Godot 4.x unavailable |
| INTERACT-002 | Door opens | E on door toggles open/closed state | NOT VERIFIED — Godot 4.x unavailable |
| INTERACT-003 | Terminal triggers signal | E on terminal emits notification and action | NOT VERIFIED — Godot 4.x unavailable |
| SCAN-001 | Scanner toggles | Q activates scanner and updates overlay | NOT VERIFIED — Godot 4.x unavailable |
| SCAN-002 | Highlight appears | Nearby interactable glows while scanner is active | NOT VERIFIED — Godot 4.x unavailable |
| SCAN-003 | No target state | Scanner shows 'NO TARGET IN RANGE' when no valid object exists | NOT VERIFIED — Godot 4.x unavailable |
| HACK-001 | Hack starts | Interacting with a terminal opens the hacking interface | NOT VERIFIED — Godot 4.x unavailable |
| HACK-002 | Puzzle loads | Signal alignment challenge loads into interface | NOT VERIFIED — Godot 4.x unavailable |
| HACK-003 | Success condition | Correct answer grants access and triggers notification | NOT VERIFIED — Godot 4.x unavailable |
| HACK-004 | Fail condition | Incorrect answer triggers failed attempt flow | NOT VERIFIED — Godot 4.x unavailable |
| SEC-001 | Security state updates | Security intensity changes from calm to alert and lockdown thresholds | NOT VERIFIED — Godot 4.x unavailable |
| AI-001 | Guard patrols | Guard maintains patrol route and state label | NOT VERIFIED — Godot 4.x unavailable |
| AI-002 | Detection response | Nearby player increases guard intensity and triggers security manager | NOT VERIFIED — Godot 4.x unavailable |
| EVIDENCE-001 | Evidence register | Pickup adds evidence to manager with discovered ID | NOT VERIFIED — Godot 4.x unavailable |
| EVIDENCE-002 | Evidence list | Evidence panel receives known evidence entries | NOT VERIFIED — Godot 4.x unavailable |
| EVIDENCE-003 | Evidence scan | Scanner reveals evidence category and metadata | NOT VERIFIED — Godot 4.x unavailable |
| UI-DEV-001 | Developer Info entry | Pause menu opens Developer Info and keyboard focus lands on a link | NOT VERIFIED — Godot CLI unavailable |
| UI-DEV-002 | Developer links | Each link opens through the OS browser; failures show an error message | NOT VERIFIED — Godot CLI unavailable |
| ANDROID-001 | Android debug export | `Android Debug` preset produces an arm64-v8a APK | BLOCKED — Godot CLI unavailable |

Runtime testing is not yet verified because Godot 4.x is unavailable in the current environment.
