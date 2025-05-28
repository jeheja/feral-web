# Feral Web Setup Guide

## Quick Start

1. **Clone and checkout the stable customizations branch**
   ```bash
   git clone <repository-url>
   cd feral-web
   git checkout feral-customizations-stable
   ```

2. **Configure for your region**
   ```bash
   cp config.sample.json config.json
   # Edit config.json with your settings (see below)
   ```

3. **Build**
   ```bash
   npm install
   npm run build
   ```

4. **Deploy**
   Deploy the `webapp/` directory to your web server

## Configuration

Edit `config.json` for your deployment:

```json
{
    "default_server_config": {
        "m.homeserver": {
            "base_url": "https://YOUR_MATRIX_SERVER",
            "server_name": "YOUR_MATRIX_SERVER"
        }
    },
    "brand": "Feral",
    "external_registration_url": "https://YOUR_SIGNUP_URL",
    "default_country_code": "XX",
    "branding": {
        "auth_header_logo_url": "themes/element/img/logos/feral-logo-white.svg"
    }
}
```

### Region Examples:
- France: `"external_registration_url": "https://feralisme.fr/inscription/"`
- Germany: `"external_registration_url": "https://feralismus.de/anmeldung/"`
- Spain: `"external_registration_url": "https://feralismo.es/registro/"`

## Updating from Upstream

```bash
./scripts/update-from-upstream.sh
```

## Custom Sounds (Optional)

Replace files in `res/media/`:
- `message.mp3/ogg` - Notifications
- `ring.mp3/ogg` - Incoming calls
- `callend.mp3/ogg` - Call ended