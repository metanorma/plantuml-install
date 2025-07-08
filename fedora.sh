#!/bin/bash
# PlantUML installation script for Fedora
# This script installs PlantUML and its dependencies on Fedora systems

set -e

PLANTUML_URL="${PLANTUML_URL:-http://github.com/plantuml/plantuml/releases/latest/download/plantuml.jar}"
PLANTUML_DIR="/opt/plantuml"
PLANTUML_BIN="/usr/local/bin/plantuml"

if [[ -f "$PLANTUML_DIR/plantuml.jar" && -f "$PLANTUML_BIN" ]]; then
  echo '[plantuml] PlantUML already installed.'
  exit
fi

echo '[plantuml] Installing PlantUML...'

# Update package manager
echo '[plantuml] Updating package manager...'
dnf update -y

# Install PlantUML dependencies
echo '[plantuml] Installing Java and Graphviz...'
dnf install -y java-latest-openjdk java-latest-openjdk-devel graphviz

# Create directory for PlantUML
mkdir -p "$PLANTUML_DIR"

# Download latest PlantUML JAR
echo '[plantuml] Downloading PlantUML...'
curl -L "$PLANTUML_URL" -o "$PLANTUML_DIR/plantuml.jar"

# Create executable script
echo '[plantuml] Creating PlantUML executable...'
cat > "$PLANTUML_BIN" << 'EOF'
#!/bin/bash
java -jar /opt/plantuml/plantuml.jar "$@"
EOF

chmod +x "$PLANTUML_BIN"

