#!/usr/bin/env sh
# Install PlantUML
set -e

PLANTUML_URL="${PLANTUML_URL:-http://github.com/plantuml/plantuml/releases/latest/download/plantuml.jar}"

if [ -f "/usr/share/java/plantuml.jar" ] && [ -f "/usr/bin/plantuml" ]; then
  echo '[plantuml] PlantUML already installed.'
  exit
fi

echo '[plantuml] Installing PlantUML...'
apk add curl openjdk8-jre graphviz fontconfig

source /etc/os-release
ALPINE_MAJOR=$(echo "$VERSION_ID" | cut -d. -f1)
ALPINE_MINOR=$(echo "$VERSION_ID)" | cut -d. -f2)

if [ "${ALPINE_MAJOR}" -ge 3 ] && [ "${ALPINE_MINOR}" -ge 17 ]; then
  apk add font-droid font-droid-nonlatin
else
  apk add ttf-droid ttf-droid-nonlatin
fi

mkdir -p /opt/plantuml
curl -o /opt/plantuml/plantuml.jar -L "${PLANTUML_URL}"
printf '#!/bin/sh\nexec java -Djava.awt.headless=true -jar /opt/plantuml/plantuml.jar "$@"' > /usr/bin/plantuml
chmod +x /usr/bin/plantuml
