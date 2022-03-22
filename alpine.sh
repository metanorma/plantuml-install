#!/usr/bin/env sh
set -e

if [ -f "/usr/share/java/plantuml.jar" ]; then
  echo '[plantuml] PlantUML already installed.'
  exit
fi

echo '[plantuml] Installing PlantUML...'
apk add curl graphviz ttf-droid ttf-droid-nonlatin fontconfig
apk add plantuml --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community

sed -i 's/java \-jar/java -Djava.awt.headless=true \-jar/' /usr/bin/plantuml
