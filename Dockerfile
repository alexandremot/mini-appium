FROM debian:buster-slim

# Update and install dependencies
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y wget unzip curl gnupg

# Install Android SDK Platform Tools
RUN wget https://dl.google.com/android/repository/platform-tools-latest-linux.zip && \
    unzip platform-tools-latest-linux.zip && \
    mv platform-tools/* /usr/local/share/

# Update PATH
ENV PATH="/usr/local/share:$PATH"

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Create adb users group
RUN groupadd -r adbusers || groupmod -n adbusers adbusers

# Add current user to adb users group
RUN usermod -a -G adbusers $(whoami)

EXPOSE 5037

CMD ["sh"]
