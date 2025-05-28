# Feral Web Deployment Guide

This guide explains how to deploy Feral Web for different regions/servers.

## Configuration Per Deployment

Each deployment needs its own `config.json` with region-specific settings.

### 1. External Registration URL

The `external_registration_url` field should point to your region's signup page:

```json
{
    "external_registration_url": "https://feralisme.fr/inscription/"  // For France
}
```

For other regions:
- Germany: `"external_registration_url": "https://feralismus.de/anmeldung/"`
- Spain: `"external_registration_url": "https://feralismo.es/registro/"`
- International (English): `"external_registration_url": "https://feralism.org/signup/"`

If you don't set this field, no external signup button will appear.

### 2. Homeserver Configuration

Each region should have its own homeserver:

```json
{
    "default_server_config": {
        "m.homeserver": {
            "base_url": "https://feralisme.fr",      // France
            "server_name": "feralisme.fr"
        }
    }
}
```

### 3. Language Settings

Set the default language for your region:

```json
{
    "default_country_code": "FR",  // For France
    "default_theme": "light",
    "default_language": "fr"       // Optional: set default language
}
```

### 4. Branding

The branding can remain the same across all deployments:

```json
{
    "brand": "Feral",
    "branding": {
        "auth_header_logo_url": "themes/element/img/logos/feral-logo-white.svg",
        "welcome_logo_url": "themes/element/img/logos/feral-logo-white.svg"
    }
}
```

## Deployment Steps

1. **Clone the repository**
   ```bash
   git clone <your-repo>
   cd feral-web
   ```

2. **Create region-specific config**
   ```bash
   cp config.sample.json config.json
   # Edit config.json with your region's settings
   ```

3. **Build the application**
   ```bash
   npm install
   npm run build
   ```

4. **Deploy the `webapp/` directory** to your web server

## Multiple Deployments from Same Source

To manage multiple deployments:

### Option 1: Environment-based configs
Create multiple config files:
- `config.fr.json` (France)
- `config.de.json` (Germany)
- `config.es.json` (Spain)

Then copy the appropriate one during deployment:
```bash
cp config.fr.json config.json && npm run build
```

### Option 2: Build script
Create a build script that accepts the region:
```bash
#!/bin/bash
# build-region.sh
REGION=$1
cp config.$REGION.json config.json
npm run build
mv webapp webapp-$REGION
```

Usage: `./build-region.sh fr`

### Option 3: Docker with build args
Use Docker to build region-specific images:
```dockerfile
ARG REGION=fr
COPY config.${REGION}.json config.json
RUN npm run build
```

## Important Notes

1. **Never hardcode region-specific URLs in source code** - always use config.json
2. **Test each deployment** with its specific configuration
3. **Document any region-specific customizations** beyond config changes
4. **Keep config files in version control** (except sensitive data)

## Config Template

Here's a complete config template for new regions:

```json
{
    "default_server_config": {
        "m.homeserver": {
            "base_url": "https://YOUR_DOMAIN",
            "server_name": "YOUR_DOMAIN"
        },
        "m.identity_server": {
            "base_url": "https://vector.im"
        }
    },
    "disable_custom_urls": true,
    "disable_guests": true,
    "disable_registration": true,
    "brand": "Feral",
    "default_country_code": "XX",
    "external_registration_url": "https://YOUR_SIGNUP_URL",
    "branding": {
        "auth_header_logo_url": "themes/element/img/logos/feral-logo-white.svg",
        "welcome_logo_url": "themes/element/img/logos/feral-logo-white.svg"
    },
    "setting_defaults": {
        "breadcrumbs": true,
        "UIFeature.registration": true
    }
}
```

Replace:
- `YOUR_DOMAIN` with your region's Matrix server
- `XX` with your country code (FR, DE, ES, etc.)
- `YOUR_SIGNUP_URL` with your region's signup page