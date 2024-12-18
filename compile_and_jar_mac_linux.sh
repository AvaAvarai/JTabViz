#!/bin/bash

# Requirements to run this script:
# - Java Development Kit (JDK) installed and configured
# - rsync (a command-line utility for synchronizing files and directories) available for file copying and synchronization
#   (rsync can be installed on most Linux and macOS systems using the package manager, e.g., apt-get, Homebrew, etc.)
# - The script should be run from the project root directory

# Create the output directory if it doesn't exist
mkdir -p out

# Compile all Java files in the src directory and its subdirectories
javac -d out $(find src -name "*.java")

# Copy resources to the output directory, excluding unnecessary files
rsync -av --exclude='.DS_Store' resources/ out/

# Copy the README.md file to the output directory
cp README.md out/

# Remove the META-INF directory from the unzipped libraries to avoid duplicate MANIFEST.MF issues
rm -rf out/META-INF

# Create the manifest file
echo "Main-Class: src.Main" > out/MANIFEST.MF

# Package everything into a single JAR file
jar cfm out/JTabViz.jar out/MANIFEST.MF -C out .

# Run the packaged Java application
java -jar out/JTabViz.jar
