#!/usr/bin/env bash
# Install PlantUML
set -e

PLANTUML_URL="${PLANTUML_URL:-http://github.com/plantuml/plantuml/releases/latest/download/plantuml.jar}"

if [[ -f "/opt/plantuml/plantuml.jar" && -f "/usr/bin/plantuml" ]]; then
  echo '[plantuml] PlantUML already installed.'
  exit
fi

echo '[plantuml] Installing PlantUML...'
apt-get install -y default-jre graphviz

mkdir -p /opt/plantuml
curl -o /opt/plantuml/plantuml.jar -L "${PLANTUML_URL}"
printf '#!/bin/sh\nexec java -Djava.awt.headless=true -jar /opt/plantuml/plantuml.jar "$@"' > /usr/bin/plantuml
chmod +x /usr/bin/plantuml
