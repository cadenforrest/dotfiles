#! /bin/bash

# Install Oh My Zsh
if [ -n "$(command -v zsh)" ]; then
    echo "Oh My Zsh already installed"
else
    echo "Installing Oh My Zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install Homebrew
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo >> ~/.zshrc
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.zshrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else 
    echo "Homebrew already installed"
fi
 
# Make sure we have homebrew's dependencies
sudo apt-get install -y build-essential libssl-dev libreadline-dev zlib1g-dev \
                        libbz2-dev libffi-dev libsqlite3-dev liblzma-dev tk-dev

# Install zellij
brew install zellij 

# Install asdf version manager
if ! command -v asdf &> /dev/null; then
    brew install asdf
    echo '. /home/linuxbrew/.linuxbrew/opt/asdf/libexec/asdf.sh' >> ~/.zshrc
else
    echo "asdf already installed"
fi

# Install latest ruby 
asdf plugin-add ruby
asdf install ruby latest
asdf global ruby latest

# Install latest python
asdf plugin-add python
asdf install python latest
asdf global python latest

# Install latest node
asdf plugin-add nodejs
asdf install nodejs latest
asdf global nodejs latest

source ~/.zshrc

echo 'tools installed - you may have to restart your terminal.'