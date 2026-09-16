# Architecture

The project follows Presentation -> Gameplay -> Systems -> Data -> Godot Engine. Global services are limited to application-wide concerns and communicate through `EventBus` signals. Gameplay systems should not directly manipulate UI.

## Foundation services

- `GameManager`: application/session state.
- `SaveManager`: versioned save boundary.
- `SettingsManager`: user settings boundary.
- `SceneManager`: validated scene transitions.
- `AudioManager`: audio state boundary.
- `EventBus`: cross-system signals.

The boot scene owns startup validation and does not contain gameplay logic.
