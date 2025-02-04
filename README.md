# windows-dotfiles

## Softwares

### Browser

- [Chrome](https://www.google.com/intl/fr_ca/chrome/next-steps.html?statcb=1&installdataindex=empty&defaultbrowser=0#)

### Chrome extensions

- [Dashlane](https://chromewebstore.google.com/detail/dashlane-%E2%80%94-gestionnaire-d/fdjamakpfbbddfjaooikfcpapjohcfmg?hl=fr&pli=1)
- [UBlock Origin](https://chromewebstore.google.com/detail/ublock-origin-lite/ddkjiahejlhfcafbddmgiahcphecmpfh)
- [Privacy Possum](https://chromewebstore.google.com/detail/privacy-badger/pkehgijcmpdhfbdbbnkijodmdjhbjlgp?hl=fr)

### Mailer

- [Mailbird]()

### Tools

- [Winrar]()
- [Driver Booster]()
- [Experience]()
- [Logitech GHub]()
- [Discord]()

### Multimedia

- [Creative cloud](https://creativecloud.adobe.com/apps/download/creative-cloud?locale=fr#)
- [VLC](https://get.videolan.org/vlc/3.0.21/win64/vlc-3.0.21-win64.exe)

### Development

- [Visual studio code](https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user)
- [Atom](https://github.com/atom/atom/releases/latest)
- [Heynote](https://github.com/heyman/heynote/releases/download/v2.1.1/Heynote_2.1.1.exe)
- [Devtoy](https://github.com/DevToys-app/DevToys/releases/download/v2.0.8.0/devtoys_win_x64.exe)
- [Linear]()
- [Notion]()

## Fonts

Download and install this fonts

- [Jetbrain Mono](https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip)
- [Fira Code](https://github.com/tonsky/FiraCode/releases/download/6.2/Fira_Code_v6.2.zip)

## WSL

### Installation

Install WSL 2 with debian

```shell
# In PowerShell as Administrator

# Enable WSL and VirtualMachinePlatform features
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# Update WSL
wsl --update

# Download and install the Linux kernel update package
wsl --install --distribution debian

# Set WSL default version to 2
wsl --set-default-version 2
```

### Windows Terminal

Open settings JSON file and copy *guid* key for *Debian* profile.

Copy `windows-terminal/settings.json` file from this repository and paste it in your local one, then replace *guid* for *WSL Debian* with one saved previously. Remember to change with this one the *defaultProfile* key.

### Bootstrap

Update packages

```shell
sudo apt update && sudo apt upgrade -y
```

Install commons packages

```shell
sudo apt install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    git \
    make \
    tig \
    tree \
    wget \
    zip unzip \
    zsh \
    -y
```

Install Oh-my-zsh

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Install PowerLevel10K

```shell
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

# Open ~/.zshrc
nano ~/.zshrc

# Replace value in ZSH_THEME with powerlevel10k/powerlevel10k

# Restart zsh shell
exec zsh

# Follow p10k installation process
```

Install ZSH plugins

```shell
# Install fzf
sudo apt install fzf

# Install zsh fzf history
git clone https://github.com/joshskidmore/zsh-fzf-history-search ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search

# Install PNPM plugin
git clone --depth=1 https://github.com/ntnyq/omz-plugin-pnpm.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/pnpm

# Install autoenv
curl -#fLo- 'https://raw.githubusercontent.com/hyperupcall/autoenv/master/scripts/install.sh' | sh

# Install autojump
sudo apt install autojump

# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf aws awscliv2.zip

# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Install Google Cloud CLI
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt update && sudo apt install google-cloud-cli
```

```shell
# Add this to your ~/.zshrc file or copy zsh/.zshrc from this repository your local one
plugins=(
    autoenv
    autojump
    aws
    azure
    bun
    colored-man-pages
    colorize
    command-not-found
    common-aliases
    composer
    copybuffer
    copyfile
    copypath
    debian
    deno
    dircycle
    dirhistory
    docker-compose
    docker
    encode64
    extract
    flutter
    gcloud
    git-flow
    git-commit
    git
    github
    golang
    gpg-agent
    node
    pip
    pnpm
    python
    ssh-agent
    ssh
    stripe
    sudo
    thefuck
    yarn
    zsh-fzf-history-search
)
```

### Node

Install volta, node, npm, yarn, pnpm, bun and deno

```shell
# Install volta cli
curl https://get.volta.sh | bash -s -- --skip-setup
```

Update your .zprofile with this or copy `zsh/.zprofile` from this repository

```shell
# If .zprofile don't exist
nano ~/.zprofile
```

```shell
export VOLTA_HOME=$HOME/.volta

export PATH="$VOLTA_HOME/bin:$PATH"
```

Restart your shell, dont reload zsh process restart your terminal (.zprofile is loaded at shell login)

```shell
# Install node and packages managers
volta install node npm yarn pnpm bun deno
```

### Docker

Install docker and compose

```shell
# Install Docker, you can ignore the warning from Docker about using WSL
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Add your user to the Docker group
sudo usermod -aG docker $USER

# You need to do 1 extra step for iptables
# compatibility, you'll want to choose option (1) to use iptables-legacy from
# the prompt that'll come up when running the command below.
#
# You'll likely need to reboot Windows or at least restart WSL after applying
# this, otherwise networking inside of your containers won't work.
sudo update-alternatives --config iptables

# Clear dir
rm get-docker.sh 
```

Update your .zprofile with this or copy `zsh/.zprofile` from this repository

```shell
# If .zprofile don't exist
nano ~/.zprofile
```

```shell
if grep -q "microsoft" /proc/version > /dev/null 2>&1; then
    if service docker status 2>&1 | grep -q "is not running"; then
        wsl.exe --distribution "${WSL_DISTRO_NAME}" --user root \
            --exec /usr/sbin/service docker start > /dev/null 2>&1
    fi
fi
```

Restart your shell, dont reload zsh process restart your terminal (.zprofile is loaded at shell login)

```shell
# Test if installation is successfull and docker well initialized
docker ps -a
```

### Nginx

Install Nginx

```shell
sudo apt install nginx
```

You can verify that nginx is running via this command:

```shell
sudo systemctl status nginx
```


### Go

Install go engine

You could check last version [here](https://go.dev/dl/). 

```shell
# Replace with desired version 
export GO_VERSION=1.23.5
curl -L "https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz" > /tmp/go${GO_VERSION}.linux-amd64.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf /tmp/go${GO_VERSION}.linux-amd64.tar.gz
rm /tmp/go${GO_VERSION}.linux-amd64.tar.gz
sudo ln -s /usr/local/go/bin/go /usr/local/bin/go
```

### Python

Install Python and Python3 engines

```shell
# Install Python3
sudo apt install python3 python3-pip ipython3 

# Install Python
sudo apt install 
```

install php8 php7 php5 phpbrew composer
install python python-pip python3 python3-pip
install flutter

install script new wordpress
install script new prestashop

install shopify cli
install github cli
install stripe cli
install vercel cli
install supabase cli

configure vscode

```shell

```