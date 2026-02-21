# CLAUDE.md — AI Assistant Guide for SSH_connect

This file provides context for AI assistants working on the SSH_connect codebase.

---

## Project Overview

SSH_connect is a single-file Bash utility that provides a `whiptail`-based interactive menu for quickly establishing SSH connections from a jumpbox to a predefined list of internal servers.

**Architecture:**

```
YOU ---> JUMPBOX (runs ssh_connect.sh) ---> INTERNAL SERVERS
```

The script is intended to live in the user's home directory and optionally auto-launch when a new bash shell starts.

---

## Repository Structure

```
SSH_connect/
├── ssh_connect.sh    # Entire application — a single executable bash script
├── README.md         # Brief feature summary and architecture overview
├── LICENSE.md        # GNU General Public License v3
└── CLAUDE.md         # This file
```

There are no build systems, package managers, test frameworks, CI/CD pipelines, or external configuration files. Everything is self-contained in `ssh_connect.sh`.

---

## Key Conventions

### Naming

| Pattern | Used for |
|---|---|
| `UPPERCASE` | Internal state variables (`customSERVER`, `serverSELECTION`, `portSELECTION`) |
| `lowercase_underscore` | User-editable config variables (`server1`, `server1_desc`, `server1_port`) |
| `CamelCase()` | Function names (`mainMenu`, `customServer`, `advanceMenu`) |
| `UPPER_SNAKE_CASE()` | Special lifecycle functions (`START`, `EXIT`, `AUTOSTART`) |

### Code Style

- Section headers are delimited by `#*#*#*...*#*#*#` banner comments.
- The top of the file (lines 32–71) is the **only** section users should edit.
- A "do not edit below this line" comment at line 73 marks the boundary between user config and script logic.
- Functions return to `mainMenu` after completion (recursive loop pattern — no explicit `while` loop).

### UI Framework

All dialogs use [`whiptail`](https://linux.die.net/man/1/whiptail):
- `--menu` for selection lists
- `--inputbox` for free-text user input
- `--msgbox` for informational popups
- `--yesno` for confirmations
- The `3>&1 1>&2 2>&3` fd-swap idiom is used on every `whiptail` call to capture output.

---

## Script Internals

### Execution Flow

```
clear
START()           → root check, then runningINhome()
mainMenu()        → whiptail menu loop (recursive; never returns)
  ├── SSH_port_picker()   → sets portSELECTION based on serverSELECTION
  ├── customServer()      → prompts for ad-hoc FQDN/port/user, then ssh
  ├── advanceMenu()       → sub-menu for auto-start config
  │     └── AUTOSTART()   → appends launcher line to ~/.bashrc
  ├── SSH_connect()       → executes ssh with pre-configured server & port
  └── EXIT()              → clear + exit
```

### Configuration Variables (lines 32–71)

Up to 10 static servers can be defined. Each server has three variables:

```bash
server1="server1-hostname"   # FQDN or IP
server1_desc="description"   # Label shown in the menu
server1_port="22"            # SSH port; must be a string
```

To disable a slot, leave all three variables empty:
```bash
server10=
server10_desc=
server10_port=
```

### Internal State Variables (lines 82–86)

| Variable | Purpose |
|---|---|
| `customSERVER` | Holds FQDN entered for ad-hoc connections |
| `serverSELECTION` | Holds the menu item the user selected |
| `portSELECTION` | Port resolved for the selected server |
| `userSELECTION` | Username entered during custom server flow |
| `advanceMenu_selection` | Holds selection from the advanced sub-menu |

### Arrays (lines 89–112)

- `servers[]`: Flat array of `hostname description` pairs for all configured servers.
- `defaultmenu[]`: Static entries appended to every menu (`Custom`, `Advanced`, `Exit`).
- `mainMenuARRAY[]`: Concatenation of `servers` + `defaultmenu` passed to `whiptail`.

### Auto-start Mechanism (AUTOSTART function, lines 225–240)

Appends the following lines to `~/.bashrc`:
```bash
#_**_#
# ^^ tag used by the ssh_connect.sh script
~/ssh_connect.sh
```

The marker `#_**_#` is used as a sentinel so the function won't add the lines a second time (`grep -Fxq "#_**_#" .bashrc`).

### Home Directory Enforcement (lines 247–269)

`runningINhome()` resolves the script's absolute path at runtime and compares it to `$HOME`. If they differ, `moveTOhome()` offers to `mv` the script to `$HOME` and then exits.

---

## Dependencies

| Dependency | Notes |
|---|---|
| `bash` | Shebang is `#!/bin/bash`; not POSIX sh compatible |
| `whiptail` | Required for all UI dialogs; usually in the `newt` or `whiptail` package |
| `ssh` | Standard OpenSSH client |

No package manager (pip, npm, etc.) is needed. Install `whiptail` via the system package manager if missing:
```bash
# Debian/Ubuntu
sudo apt install whiptail

# RHEL/CentOS/Fedora
sudo dnf install newt
```

---

## Development Workflow

### Making Changes

1. Edit `ssh_connect.sh` directly — there is no build step.
2. Test manually by running the script in a terminal with `whiptail` available.
3. The script must **not** be run as root (`START()` enforces this).

### Running Locally

```bash
# Place in home directory (required for AUTOSTART and moveTOhome logic)
cp ssh_connect.sh ~/
chmod +x ~/ssh_connect.sh
~/ssh_connect.sh
```

### No Test Suite

There are no automated tests. Validation is done manually by running the script and exercising the menus. When adding features, test each menu path by hand.

### Branch Strategy

- `master`: Stable main branch.
- Feature branches should follow the pattern `claude/<short-description>-<id>` for AI-assisted work.

---

## Planned Features (from README)

These are not yet implemented:

1. Option to launch from every new bash shell vs. only SSH-connected shells.
2. SSH installation check with prompt to install.
3. Auto SSH key deployment to destination servers.
4. Connection logging with timestamps and error logging.

---

## Important Constraints for AI Assistants

- **Do not add external dependencies.** The script is intentionally dependency-free beyond `bash`, `ssh`, and `whiptail`.
- **Do not restructure into multiple files.** Single-file simplicity is a deliberate design choice.
- **Keep the user-editable section clearly marked** and separate from logic. Users are expected to edit lines 32–71 and nothing else.
- **Preserve the `whiptail` UI pattern** — do not replace dialogs with readline/read-based prompts.
- **Do not break the home-directory assumption.** The auto-start and path-management functions depend on the script living at `~/ssh_connect.sh`.
- **No build step should ever be required.** The script must remain executable as-is.
- **The script must never run as root** — the `START()` root check is a security boundary; do not remove it.
