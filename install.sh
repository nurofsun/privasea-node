#!/bin/bash

# Function to check if Docker is installed
is_docker_installed() {
    if command -v docker &> /dev/null; then
        echo -e "\033[1;32mDocker is already installed.\033[0m"
        return 0
    else
        echo -e "\033[1;31mDocker is not installed. Installing...\033[0m"
        return 1
    fi
}

# Function to install Docker
install_docker() {
    # Update package index and install packages needed to allow apt to use a repository over HTTPS
    echo -e "\033[1;34mUpdating package index and installing required packages...\033[0m"
    sudo apt-get update
    sudo apt-get install -y \
        ca-certificates \
        curl \
        gnupg \
        lsb-release
    # Add Docker’s official GPG key
    echo -e "\033[1;34mAdding Docker’s official GPG key...\033[0m"
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    # Set up the stable repository
    echo -e "\033[1;34mSetting up the Docker stable repository...\033[0m"
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    # Update package index and install Docker CE
    echo -e "\033[1;34mUpdating package index and installing Docker CE...\033[0m"
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    # Add the user to the docker group (optional)
    echo -e "\033[1;34mAdding user to the docker group...\033[0m"
    sudo usermod -aG docker $USER
    echo -e "\033[1;32mDocker installed successfully.\033[0m"
}

# Function to pull the Docker image
pull_docker_image() {
    echo -e "\033[1;34mPulling the Docker image...\033[0m"
    sudo docker pull privasea/acceleration-node-beta:latest
    echo -e "\033[1;32mDocker image pulled successfully.\033[0m"
}

# Function to create and configure the wallet keystore
create_keystore() {
    echo -e "\033[1;34mCreating a new keystore file...\033[0m"
    sudo docker run -it \
        -v "/privasea/config:/app/config"  \
        privasea/acceleration-node-beta:latest ./node-calc new_keystore
    echo -e "\033[1;34mEnter password for a new key:\033[0m"
    read -s -p "Password: " KEYSTORE_PASSWORD
    echo
    echo -e "\033[1;34mRe-enter the password to verify:\033[0m"
    read -s -p "Verify Password: " VERIFY_PASSWORD
    echo
    if [ "$KEYSTORE_PASSWORD" != "$VERIFY_PASSWORD" ]; then
        echo -e "\033[1;31mPasswords do not match. Exiting...\033[0m"
        exit 1
    fi
    echo -e "\033[1;32mKeystore created successfully.\033[0m"
}

# Function to rename the keystore
rename_keystore() {
    echo -e "\033[1;34mRenaming the keystore...\033[0m"
    mv /privasea/config/UTC--* /privasea/config/wallet_keystore
    echo -e "\033[1;32mKeystore renamed successfully.\033[0m"
}

# Function to start the node
start_node() {
    echo -e "\033[1;34mStarting the node...\033[0m"
    sudo docker run -d \
        -v "/privasea/config:/app/config" \
        -e KEYSTORE_PASSWORD=$KEYSTORE_PASSWORD \
        privasea/acceleration-node-beta:latest
    echo -e "\033[1;32mNode started successfully, please copy Container ID above.\033[0m"
}

# Main script execution
if ! is_docker_installed; then
    install_docker
else
    pull_docker_image
    create_keystore
    rename_keystore
    start_node
fi
