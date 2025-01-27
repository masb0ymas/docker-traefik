set -e

BASE_ENV_FILE=".env.example"
ENV_FILE=".env"

OS_TYPE=$(grep -w "ID" /etc/os-release | cut -d "=" -f 2 | tr -d '"')
OS_VERSION=$(grep -w "VERSION_ID" /etc/os-release | cut -d "=" -f 2 | tr -d '"')

if [ "$OS_TYPE" = "ubuntu" ]; then
  OS_TYPE="ubuntu"

  echo -e "Cleaning previous docker installation...\n"
  for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

  echo -e "Installing dependencies for docker...\n"
  # Add Docker's official GPG key:
  sudo apt-get update
  sudo apt-get install ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  # Add the repository to Apt sources:
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
    sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

  echo -e "Installing docker...\n"
  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  # Pull first image
  sudo docker run hello-world
fi

DOCKER_VERSION=$(docker version --format '{{.Server.Version}}')

if [[ "$OSTYPE" == "darwin"* ]]; then
  OS_TYPE="macos"
fi

echo -e "---------------------------------------------"
echo "| Operating System  | $OS_TYPE $OS_VERSION"
echo "| Docker            | $DOCKER_VERSION"
echo -e "---------------------------------------------\n"

if [ -f "$BASE_ENV_FILE" ]; then
  cp "$BASE_ENV_FILE" "$ENV_FILE"
  echo " - Copy $BASE_ENV_FILE to $ENV_FILE"

  if [ "$OS_TYPE" = "macos" ]; then
    # Generate a secure DB_PASSWORD
    sed -i '' "s|^DB_PASSWORD=.*|DB_PASSWORD='$(openssl rand -hex 16)'|" "$ENV_FILE"
  elif [ "$OS_TYPE" = "ubuntu" ]; then
    # Generate a secure DB_PASSWORD
    sed -i "s|^DB_PASSWORD=.*|DB_PASSWORD='$(openssl rand -hex 16)'|" "$ENV_FILE"
  fi

  echo "Secrets have been generated and saved to .env file"
fi

echo -e "\nYour setup is ready to use!\n"
