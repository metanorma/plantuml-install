#!/usr/bin/env bash
# Install PlantUML
set -e

PLANTUML_URL="${PLANTUML_URL:-http://github.com/plantuml/plantuml/releases/latest/download/plantuml.jar}"
PLANTUML_DIR="/opt/plantuml"
PLANTUML_BIN="/usr/bin/plantuml"

if [[ -f "${PLANTUML_DIR}/plantuml.jar" && -f "${PLANTUML_BIN}" ]]; then
  echo '[plantuml] PlantUML already installed.'
  exit
fi

echo '[plantuml] Installing PlantUML...'

# Detect package manager (yum for CentOS 6-7, dnf for CentOS 8+)
if command -v dnf >/dev/null 2>&1; then
  dnf install -y java-1.8.0-openjdk graphviz
else
  yum install -y java-1.8.0-openjdk graphviz
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

