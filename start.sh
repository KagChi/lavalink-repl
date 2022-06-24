curl -sL https://github.com/shyiko/jabba/raw/master/install.sh | bash -s -- --skip-rc && . ~/.jabba/jabba.sh
jabba install zulu@1.13.0-2


if [ ! -f "Lavalink.jar" ]; then
    wget -O  Lavalink.jar "https://ci.fredboat.com/repository/download/Lavalink_Build/.lastSuccessful/Lavalink.jar?guest=1&branch=refs/heads/dev"
    java -jar Lavalink.jar
else
  if [ "$AUTO_UPDATE" = "true" ]; then
    wget -O  Lavalink.jar "https://ci.fredboat.com/repository/download/Lavalink_Build/.lastSuccessful/Lavalink.jar?guest=1&branch=refs/heads/dev"
    java -jar Lavalink.jar
  else
    java -jar Lavalink.jar
  fi
fi
