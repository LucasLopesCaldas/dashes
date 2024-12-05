#!/bin/bash

# Check if a directory name is provided as an argument
if [ $1 ]; then
    mkdir $1
    cd $1
fi

sudo echo $'===> Initializing cargo project\n'
cargo init


echo $'===> Initializing Cargo workspace\n'
cat <<EOL >| Cargo.toml
[package]
name = "dlve"
version = "0.1.0"
edition = "2021"

[workspace]
resolver = "2" # Important! wgpu/Bevy needs this!

# Enable a small amount of optimization in debug mode
[profile.dev]
opt-level = 1

# Enable high optimizations for dependencies (incl. Bevy), but not for our code
[profile.dev.package."*"]
opt-level = 3
EOL

cargo add bevy

echo $'===> Installing dependencies\n'
sudo apt-get install -y g++ pkg-config libx11-dev libasound2-dev libudev-dev libxkbcommon-x11-0

echo $'===> Adding simple example code\n'
cat <<EOL >| src/main.rs
use bevy::prelude::*;

fn main() {
    App::new()
        .add_plugins(DefaultPlugins)
        .add_systems(Startup, setup)
        .run();
}

fn setup(mut commands: Commands) {
    commands.spawn(Camera2dBundle::default());
}

EOL

echo $'===> Adding linker and Rust flags configuration\n'
mkdir .cargo
cat <<EOL > ./.cargo/config.toml
[target.x86_64-unknown-linux-gnu]
linker = "clang"
rustflags = ["-C", "link-arg=-fuse-ld=/usr/bin/mold", "-Zshare-generics=y"]

[unstable]
codegen-backend = true

[profile.dev]
codegen-backend = "cranelift"

[profile.dev.package."*"]
codegen-backend = "llvm"
EOL

echo $'===> Installing Cranelift\n'
rustup component add rustc-codegen-cranelift-preview --toolchain nightly

echo $'===> Creating rust-toolchain.toml\n'
cat <<EOL > rust-toolchain.toml
[toolchain]
channel = "nightly"
EOL
