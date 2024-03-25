#!/usr/bin/env sh
# Install PlantUML
set -e

PLANTUML_URL="${PLANTUML_URL:-http://github.com/plantuml/plantuml/releases/latest/download/plantuml.jar}"

if [ -f "/usr/share/java/plantuml.jar" -a -f "/usr/bin/plantuml" ]; then
  echo '[plantuml] PlantUML already installed.'
  exit
fi

echo '[plantuml] Installing PlantUML...'
apk add curl graphviz fontconfig
apk add ttf-droid ttf-droid-nonlatin --repository=http://dl-cdn.alpinelinux.org/alpine/v3.16/community

mkdir -p /opt/plantuml
curl -o /opt/plantuml/plantuml.jar -L "${PLANTUML_URL}"
printf '#!/bin/sh\nexec java -Djava.awt.headless=true -jar /opt/plantuml/plantuml.jar "$@"' > /usr/bin/plantuml
chmod +x /usr/bin/plantuml
