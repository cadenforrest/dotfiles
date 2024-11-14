#! /bin/bash

# Notice
echo "This script will install the following tools and configurations:"
echo "- Oh My Zsh"
echo "- Homebrew"
echo "- Essential build tools and libraries"
echo "- zellij"
echo "- ripgrep"
echo "- fzf"
echo "- zsh-autosuggestions"
echo "- asdf version manager"
echo "- Latest versions of Ruby, Python, and Node.js"
echo
read -p "Do you want to continue? (y/n): " confirm

if [[ $confirm != [yY] ]]; then
    echo "Installation aborted."
    exit 1
fi

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

# Install ripgrep
brew install ripgrep

#  Install fzf
brew install fzf

# Install zsh-autosuggestions
if ! grep -q 'zsh-autosuggestions.zsh' ~/.zshrc; then
    brew install zsh-autosuggestions
    echo 'source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc
else 
    echo "zsh-autosuggestions already installed"
fi

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

# Install rails
gem install rails

echo 'tools installed - you may have to restart your terminal and run `source ~/.zshrc`.'