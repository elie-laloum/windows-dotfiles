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
    build-essential \
    zlib1g-dev \
    libffi-dev \
    libssl-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    liblzma-dev \
    libncurses-dev \
    tk-dev \
    llvm \
    libncursesw5-dev \
    xz-utils \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    php-fpm \
    php \
    php-common \
    php-cli \
    php-bz2 \
    php-xml \
    php-enchant \
    autoconf \
    automake \
    autotools-dev \
    re2c \
    libxml2 \
    openssl \
    gettext \
    libicu-dev \
    libmcrypt-dev \
    libmcrypt4 \
    libmhash-dev \
    libmhash2 \
    libfreetype6 \
    libfreetype6-dev \
    libgd-dev \
    libgd3 \
    libpng-dev \
    libpng16-16 \
    libjpeg-dev \
    libxpm4 \
    libltdl7 \
    libltdl-dev \
    libxslt1-dev \
    libbz2-dev \
    libcurl4-gnutls-dev \
    libzip-dev \
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
# sudo update-alternatives --config iptables

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

!!!!!!!!!!!!!! PROBLEM WITH openssl !!!!!!!!!!!!!!

```shell
> pyenv install 3.1.0
Downloading Python-3.1.tar.gz...
-> https://www.python.org/ftp/python/3.1/Python-3.1.tgz
Installing Python-3.1...
patching file ./setup.py
patching file ./Lib/ssl.py
patching file ./Modules/_ssl.c
Hunk #3 succeeded at 1701 (offset -5 lines).
Traceback (most recent call last):
  File "<string>", line 1, in <module>
  File "/home/elie/.pyenv/versions/3.1.0/lib/python3.1/ssl.py", line 59, in <module>
    import _ssl             # if we can't import it, let the error propagate
ImportError: No module named _ssl
ERROR: The Python ssl extension was not compiled. Missing the OpenSSL lib?

Please consult to the Wiki page to fix the problem.
https://github.com/pyenv/pyenv/wiki/Common-build-problems
```

---

Install Pyenv

```shell
curl -fsSL https://pyenv.run | bash
```

Update your .zshrc with this or copy `zsh/.zshrc` from this repository

```shell
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
```

You can verify that pyenv is working via this command:

```shell
pyenv version list
```

### PHP

!!!!!!!!!!!!!! PROBLEM WITH enchant !!!!!!!!!!!!!!

```shell
> phpbrew install 7.0.32  +all                                                                      
===> phpbrew will now build 7.0.32
===> Loading and resolving variants...
Checking distribution checksum...
Checksum matched: 56e8d8cf9c08178afa8663589805f83bdb01634efd98131977038e24066492e1
===> Distribution file was successfully extracted, skipping...
Running make clean to ensure everything will be rebuilt.
Makefile not found in path /home/elie/.phpbrew/build/php-7.0.32
===> Checking patches...
Checking patch for replace apache php module name with custom version name
Checking patch for replace freetype-config with pkg-config on php older than 7.4
Checking patch for fix readline detection on PHP 5.3 to PHP 7.1
---> Applying patch...
patching file ext/readline/config.m4
Reversed (or previously applied) patch detected!  Skipping patch.
2 out of 2 hunks ignored -- saving rejects to file ext/readline/config.m4.rej

Patch failed
0 changes patched.
Found existing build.log, renaming it to /home/elie/.phpbrew/build/php-7.0.32/build.log.1738677897
===> Configuring 7.0.32...


Use tail command to see what's going on:
   $ tail -F '/home/elie/.phpbrew/build/php-7.0.32/build.log'


Error: Configure failed:
The last 5 lines in the log file:
checking whether to enable DOM support... yes

checking for xml2-config path... (cached) /usr/bin/xml2-config

checking whether libxml build works... (cached) yes

checking for ENCHANT support... yes

configure: error: Cannot find enchant
```

Install PHPBrew

```shell
curl -L -O https://github.com/phpbrew/phpbrew/releases/latest/download/phpbrew.phar
chmod +x phpbrew.phar

# Move the file to some directory within your $PATH
sudo mv phpbrew.phar /usr/local/bin/phpbrew

# Init phpbrew
phpbrew init
```

Update your .zshrc with this or copy `zsh/.zshrc` from this repository

```shell
[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc
```

Install Composer

```shell
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'.PHP_EOL; } else { echo 'Installer corrupt'.PHP_EOL; unlink('composer-setup.php'); exit(1); }"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer
```

You can verify that composer is running via this command:

```shell
composer -v
```

### Shopify CLI

```shell
npm install -g @shopify/cli@latest
```

### Github CLI

```shell
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
        && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
        && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y
```

### Stripe CLI

```shell
curl -s https://packages.stripe.dev/api/security/keypair/stripe-cli-gpg/public | gpg --dearmor | sudo tee /usr/share/keyrings/stripe.gpg
echo "deb [signed-by=/usr/share/keyrings/stripe.gpg] https://packages.stripe.dev/stripe-cli-debian-local stable main" | sudo tee -a /etc/apt/sources.list.d/stripe.list
sudo apt update
sudo apt install stripe
```

### Vercel CLI

```shell
npm i -g vercel
```

### Supabase CLI

You could check last version [here](https://github.com/supabase/cli/releases). 

```shell
# Replace with desired version 
export SUPABASE_CLI_VERSION=2.10.2

wget "https://github.com/supabase/cli/releases/download/v${SUPABASE_CLI_VERSION}/supabase_${SUPABASE_CLI_VERSION}_linux_amd64.deb"

sudo dpkg -i supabase_${SUPABASE_CLI_VERSION}_linux_amd64.deb

rm supabase_${SUPABASE_CLI_VERSION}_linux_amd64.deb
```

### Dev instances

Copy compose file from `docker/docker-compose.yml` to `/opt/docker-compose.yml` and launch it with:

```shell
cd /opt

docker compose up -d
```

This compose file install a mariadb, postgresql, mongodb, redis, and mailhog services with according UI's.



install script new wordpress
install script new prestashop

configure vscode

```shell

```