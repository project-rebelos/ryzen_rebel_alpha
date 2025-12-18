# CentOS Stream 9 BlueBuild Image - Lenovo IdeaPad 5

Immutable CentOS Stream 9 desktop image with Budgie DE, built with BlueBuild for AMD Ryzen laptops.

## What Was Fixed

The original project had an incorrect recipe syntax. The error:

```
ERROR: failed to resolve source metadata for docker.io/modules/audio-pipewire.yml:latest
```

This happened because:

1. **Wrong syntax**: Used `type: include` with `source:` which doesn't exist in BlueBuild
2. **Wrong location**: Module files were in `modules/` instead of `recipes/`

### Before (broken)
```yaml
modules:
  - type: include
    source: modules/audio-pipewire.yml  # ❌ BlueBuild interprets this as a Docker image!
```

### After (fixed)
```yaml
modules:
  - from-file: audio-pipewire.yml  # ✅ Correct BlueBuild syntax
```

## Project Structure

```
.
├── .github/
│   └── workflows/
│       └── build.yml           # GitHub Actions CI/CD
├── recipes/
│   ├── recipe.yml              # Main recipe (entry point)
│   ├── base-repos.yml          # Repository configuration
│   ├── base-system.yml         # Core packages
│   ├── hardware-amd-laptop.yml # AMD Ryzen hardware support
│   ├── networking.yml          # Network tools & VPN
│   ├── audio-pipewire.yml      # PipeWire audio stack
│   ├── power-management.yml    # Laptop power management
│   ├── desktop-budgie.yml      # Budgie DE (default)
│   ├── apps-browser.yml        # Firefox
│   ├── apps-containers.yml     # Podman, Buildah, etc.
│   ├── apps-server.yml         # Cockpit, firewall, SELinux
│   ├── apps-dev.yml            # Development tools (optional)
│   └── system-config.yml       # Final systemd configuration
├── scripts/
│   ├── enable-repos.sh         # Enable EPEL + Budgie COPR
│   └── set-graphical-target.sh # Set graphical boot target
└── files/                      # Custom config files (if needed)
```

## Key Points

1. **All module files go in `recipes/`** - BlueBuild's `from-file:` directive looks here
2. **Use `from-file:` not `type: include`** - The include syntax doesn't exist
3. **Single module files use schema `module-v1.json`**
4. **Multi-module files use schema `module-list-v1.json`** with `modules:` wrapper

## Building

### GitHub Actions (recommended)
Push to main branch - image builds automatically and publishes to:
```
ghcr.io/YOUR_USERNAME/centos9-ideapad5-server:latest
```

### Local Build
```bash
# Install BlueBuild CLI
cargo install blue-build

# Build
bluebuild build recipes/recipe.yml
```

## Switching Desktop Environments

Edit `recipes/recipe.yml` and change the desktop include:

```yaml
# For XFCE (lightweight)
- from-file: desktop-xfce.yml

# For Plasma/KDE (full-featured)  
- from-file: desktop-plasma.yml

# For GNOME (modern)
- from-file: desktop-gnome.yml

# For Budgie (current)
- from-file: desktop-budgie.yml
```

## References

- [BlueBuild Documentation](https://blue-build.org/)
- [BlueBuild Recipe Reference](https://blue-build.org/reference/recipe/)
- [How to split configuration into multiple files](https://blue-build.org/how-to/multiple-files/)
- [CentOS bootc images](https://quay.io/repository/centos-bootc/centos-bootc)
