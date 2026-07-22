# Nixify

A modular Nix flake configuration built with `flake-parts` for declaratively
managing and wrapping application configurations. This repository is an
ongoing project aimed at transitioning all personal apps and system
configurations to Nix and NixOS.

## Overview

- **Flake Parts Architecture**: Structured for multi-system support
  (`x86_64-linux`, `aarch64-linux`, `x86_64-darwin`, `aarch64-darwin`).
- **Auto-Importing**: Built with `import-tree` to automatically discover and
  import modules added under the `./modules` directory.
- **Application Wrapping**: Uses `nix-wrapper-modules` to bundle applications with
  their runtime dependencies and configuration files into self-contained
  packages.

## Directory Structure

```text
.
├── flake.nix       # Main flake inputs and evaluation setup
├── flake.lock      # Locked dependencies
└── modules/        # Configuration modules and wrapped app definitions
```

## Getting Started

### 1. Clone the Repository

Clone this repository along with its submodules or worktree setup:

```bash
git clone https://github.com/ajdev-gh/nix
cd nix
```

### 2. Inspect Available Outputs

Check the packages and apps exposed by the flake for your current architecture:

```bash
nix flake show
```

### 3. Build a Package

Build a specific output target defined in the modules:

```bash
nix build .#<package-name>
```

### 4. Run an Application Directly

Run any wrapped application directly without installing it globally:

```bash
nix run .#<package-name>
```

## Development & Adding Modules

Any new module or application added inside the `./modules/` folder is
automatically imported by `import-tree`. Simply create a standard Nix module
inside `./modules/` (e.g., `./modules/apps/<app-name>/default.nix`) to add new
packages or system configurations to the repository.
