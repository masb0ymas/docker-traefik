set -e

BASE_ENV_FILE=".env.example"
ENV_FILE=".env"

OS_TYPE=$(grep -w "ID" /etc/os-release | cut -d "=" -f 2 | tr -d '"')
OS_VERSION=$(grep -w "VERSION_ID" /etc/os-release | cut -d "=" -f 2 | tr -d '"')

if [[ "$OSTYPE" == "darwin"* ]]; then
  OS_TYPE="macos"
fi

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
