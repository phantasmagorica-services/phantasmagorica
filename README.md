# An Unnamed Roleplay Project

## Purpose

Phantasmagorica will provide a generic backend-content structured project for developing TTRPG-likes in BYOND.

The actual game in this codebase is a Pathfinder-like system.

## Why

It's tiring to have Space Station 13 be the only game with reasonable code structure. TT/RPGs are fun but the codebase secrecy going around is utterly senseless from the perspective of someone used to open-source codebases. The code quality of these codebases, despite their wide plethora of features, tends to be tolerable at best, and utterly unmaintainable at worst.

## High Level Design Spec

- All intrusive modules like languages, identification, etc, should be configurable
- The codebase should be highly modular, with an emphasis on signals, and proc overrides. It is somewhat difficult to have true modularity in BYOND due to the limited language set, but we want to make this codebase, at the very least, easy to modify.
- Modularity goes above ease of developing a new feature, on this codebase, when touching the 'backend' files. This codebase must be game-generic.

## License

This codebase is explicitly licensed under the MIT license. This is to enable game owners to fork a closed source variant of this codebase. While it would be nice to use GPL/similar, we are not naive in how optimistic we are in terms of being able to use this 'engine' without modifications to the core files.

## Organization

### Root

- /backend: All global systems should reside in here.
- /content: All game-specific overrides should reside in here, unless otherwise impossible.

## Building / Running / Hosting

### Prerequisites

- [tgstation-server (https://github.com/tgstation/tgstation-server)](https://github.com/tgstation/tgstation-server) (Only if hosting)
- [MariaDB (https://mariadb.org/download)](https://mariadb.org/download)

`-- TODO --`

### Building

`-- TODO --`

### Hosting

`-- TODO --`

## Attributions

- Code style / general design is very obviously inspired by Space Station 13
