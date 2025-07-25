#!/usr/bin/env sh
# Install PlantUML
set -e

PLANTUML_URL="https://github.com/plantuml/plantuml/releases/latest/download/plantuml.jar"
PLANTUML_DIR="/opt/plantuml/"
PLANTUML_BIN="/usr/local/bin/plantuml"

if [ -f "${PLANTUML_DIR}plantuml.jar" ] && [ -f "${PLANTUML_BIN}" ]; then
  echo '[plantuml] PlantUML already installed.'
  exit
fi

echo '[plantuml] Installing PlantUML...'
apk add curl openjdk8-jre graphviz fontconfig

# shellcheck disable=SC1091
. /etc/os-release
ALPINE_MAJOR=$(echo "$VERSION_ID" | cut -d. -f1)
ALPINE_MINOR=$(echo "$VERSION_ID" | cut -d. -f2)

echo '[plantuml] Installing font packages...'
if [ "${ALPINE_MAJOR}" -ge 3 ] && [ "${ALPINE_MINOR}" -ge 17 ]; then
  apk add font-droid font-droid-nonlatin
else
  apk add ttf-droid ttf-droid-nonlatin
fi

# Create directory for PlantUML
mkdir -p "$PLANTUML_DIR"

# Download latest PlantUML JAR
echo '[plantuml] Downloading PlantUML...'
curl -L "$PLANTUML_URL" -o "$PLANTUML_DIR/plantuml.jar"

# Create executable script
echo '[plantuml] Creating PlantUML executable...'
cat > "$PLANTUML_BIN" << 'EOF'
#!/bin/sh
exec java -Djava.awt.headless=true -jar /opt/plantuml/plantuml.jar "$@"
EOF

chmod +x "$PLANTUML_BIN"

