FROM mcr.microsoft.com/powershell:latest

ARG USERNAME
ENV USERNAME=${USERNAME:-snover}

# Create user and set up environment in a single layer
RUN useradd -m -s /bin/bash $USERNAME && \
    mkdir -p /home/$USERNAME/.config/powershell && \
    mkdir -p /home/$USERNAME/.local/share/powershell/Modules

# Switch to root user for setup
USER root
WORKDIR /home/$USERNAME

# Copy the PowerShell profile
COPY Microsoft.PowerShell_profile.ps1 /home/$USERNAME/.config/powershell/Microsoft.PowerShell_profile.ps1

# Combine PowerShell module installations into a single layer
# This reduces the number of layers and improves caching
RUN pwsh -Command " \
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted; \
    Install-Module -Name Terminal-Icons, PSReadLine -Scope AllUsers -Force"

# Set permissions in the same layer as it's related to setup
RUN chown -R $USERNAME:$USERNAME /home/$USERNAME

USER $USERNAME
CMD ["pwsh"]
