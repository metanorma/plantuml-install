#!/usr/bin/env bash
# Install PlantUML
set -e

PLANTUML_URL="https://github.com/plantuml/plantuml/releases/latest/download/plantuml.jar"
PLANTUML_DIR="/opt/plantuml"
PLANTUML_BIN="/usr/bin/plantuml"

if [[ -f "${PLANTUML_DIR}/plantuml.jar" && -f "${PLANTUML_BIN}" ]]; then
  echo '[plantuml] PlantUML already installed.'
  exit
fi

echo '[plantuml] Installing PlantUML...'
dnf install -y java-1.8.0-openjdk graphviz

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

