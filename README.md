# homebrew-puck

Homebrew tap for [PUCK](https://puck.data-tier.com) network intelligence agent.

## Install

```bash
brew tap data-tier/puck
brew install puck-agent
```

## Usage

```bash
puck-agent login
brew services start puck-agent
```

## Update

```bash
brew update
brew upgrade puck-agent
```

## Uninstall

```bash
brew services stop puck-agent
brew uninstall puck-agent
brew untap data-tier/puck
```
