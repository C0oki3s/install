

#!/bin/bash

install_dependencies() {
    # Function to check if a command is installed
    check_command() {
        command -v "$1" >/dev/null 2>&1
    }

    # List of commands to check and install
    commands=("go" "python3" "node" "npm")

    # Loop through the commands and install if not present
    for cmd in "${commands[@]}"; do
        if ! check_command "$cmd"; then
            echo "Installing $cmd..."
            sudo apt-get update
            sudo apt-get install -y "$cmd"
        else
            echo "$cmd is already installed."
        fi
    done
}
install_dependencies


export_gopath(){
echo "exporting GOPATH"
	export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
echo "DONE exporting"
echo $GOPATH

}

export_gopath

# Call the function


installpkg() {
    # Clone and install massdns
    echo "Installing massdns..."
    git clone https://github.com/blechschmidt/massdns.git
    cd massdns || exit
    sudo make install -y
    make
    cd ..

    # Install DNS-related tools
    echo "Installing DNS-related tools..."
    go get -u github.com/projectdiscovery/dnsx/cmd/dnsx@latest
    go get -u github.com/hakluke/hakoriginfinder@latest
    go install github.com/hakluke/hakrevdns@latest
    go get -u github.com/projectdiscovery/mapcidr/cmd/mapcidr@latest
    go get -u github.com/projectdiscovery/shuffledns/cmd/shuffledns@latest

    # Install HTTP-related tools
    echo "Installing HTTP-related tools..."
    go get -u github.com/projectdiscovery/httpx/cmd/httpx@latest
    go install github.com/ffuf/ffuf/v2@latest
    go get -u github.com/tomnomnom/waybackurls@latest

    # Install subdomain discovery tools
    echo "Installing subdomain discovery tools..."
    go get -u github.com/OWASP/Amass/cmd/amass@latest
    go get -u github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

    # Install other tools
    echo "Installing other tools..."
    go get -u github.com/tomnomnom/gf@latest
    go install github.com/d3mondev/puredns/v2@latest
    go install github.com/projectdiscovery/katana/cmd/katana@latest

    # Install Python tools
    echo "Installing Python tools..."
    pip3 install py-altdns==1.0.2
    pip3 install dirsearch

    echo "Installation complete."
}

# Call the function
installpkg

