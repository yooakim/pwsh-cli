# PowerShell CLI Container

My basic PowerShell CLI in a container

## Features

- PowerShell-based command line interface
- Cross-platform compatibility (Windows, Linux, macOS)
- Container support via Docker
- GitHub Actions automated builds

## Quick Start

    docker run -it --name powershell-cli ghcr.io/yooakim/pwsh-cli

### Local Installation

```bash
    git clone https://github.com/yooakim/pwsh-cli
    cd pwsh-cli
```

### Using Docker

    docker pull ghcr.io/yooakim/pwsh-cli:latest
    docker run -it ghcr.io/yooakim/pwsh-cli

### Build locally

    docker build --build-arg USERNAME=mycustomuser -t powershell-cli .
    docker run -it pwsh-cli

## Development
### Prerequisites

* PowerShell 7.0 or higher
* Docker (optional)
* Git

### Setup Development Environment

1. Clone the repository
1. Install dependencies
1. Run the development environment

### Contributing

1. Fork the repository
1. Create your feature branch (git checkout -b feature/amazing-feature)
1. Commit your changes (git commit -m 'Add some amazing feature')
1. Push to the branch (git push origin feature/amazing-feature)
1. Open a Pull Request

### License

This project is licensed under the MIT License - see the LICENSE file for details.

### Contact
Joakim Westin - @yooakim

Project Link: https://github.com/yooakim/pwsh-cli