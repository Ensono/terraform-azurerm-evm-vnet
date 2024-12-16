# Contributing

When contributing to this repository, please first discuss the change you wish to make via an issue,
an email, or any other method with the owners of this repository before making a change.

Please note we have a code of conduct, please follow it in all your interactions with the project.

## Pull Request Process

1. Ensure any installed or built dependencies are removed before the end of the layer when doing a
   Pull Request. Ensure also that your code is clean and production ready.
2. Update the [README.md](./README.md) with details of changes to the module, including variables, outputs
   or changes to [examples](./examples).
3. Update the [CHANGELOG.md](./CHANGELOG.md) with a new entry block starting with `# Unreleased`
   followed by a description of your new feature, bug fix or change.
4. The CI must pass. It ensures that our Terraform module codestyle rules are followed.
5. Please wait for maintainers to review your code, they will merge and release your changes once every
   discussions or implementation details are satisfied.

### Pre-commit usage
This repository uses the [pre-commit](https://pre-commit.com/) git hook framework which can update and format some files enforcing our Terraform code module best-practices. This repository has been tested with the following software versions:
- **Python**: [3.12.8](https://www.python.org/downloads/release/python-3128/)
- **Pre-commit**: `4.0.1`
- **Terraform**: [1.9.3](https://releases.hashicorp.com/terraform/1.9.3/)

Installation is simple and works cross platform. Use an elevated terminal when installing pre-commit. The framework can be installed and configured with a few steps:

One off actions to install Pre-commit
1. Install Python `3.12.8` ensuring you enable Add to PATH option on the Windows installer
2. Install the Pre-commit framework:  `pip3 install pre-commit==4.0.1`
3. Ensure `bash.exe` can be executed from a PowerShell terminal. If not, try adding `C:\Program Files\Git\bin` to your `Path` environment variable

Only required on new cloned repositories
1. Within the repo directory, run `pre-commit install` to set up the `pre-commit` git hook
2. Within the repo directory, run `pre-commit install --hook-type commit-msg` to set up the `commit-msg` git hook

To have all `pre-commit` hooks working you will have to setup these dependencies locally. Place these files within a folder that has been added to your `Path` environment variable:
- [terraform](https://releases.hashicorp.com/terraform/1.9.3/)
- [tfdocs](https://github.com/terraform-docs/terraform-docs)
- [tflint](https://github.com/terraform-linters/tflint)

---
Note:
<br/>
To run the `pre-commit` hook against all files run `pre-commit run -a`.

---

<br/>

Make code changes as usual, the Git hooks will be triggered by `pre-commit` every time you use the `git commit` command.

A typical workflow would be:

1. `git pull`: the most recent changes into main from remote
2. `git checkout -b [branch name]`: create a new branch to make code changes
3. `git add .`: to stage all changed files
4. `git commit -m '[commit message]'`: commit code changes
5. `git push`: push commited changes to remote

## Conventional Commit
This repo will use [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/). There is a Pre-commit hook that will enforce the commit message format.

## Code of Conduct

### Our Pledge

In the interest of fostering an open and welcoming environment, we as
contributors and maintainers pledge to making participation in our project and
our community a harassment-free experience for everyone, regardless of age, body
size, disability, ethnicity, gender identity and expression, level of experience,
nationality, personal appearance, race, religion, or sexual identity and
orientation.

### Our Standards

Examples of behavior that contribute to creating a positive environment
include:

* Using a welcoming and inclusive language
* Being respectful of differing viewpoints and experiences
* Gracefully accepting constructive criticism
* Focusing on what is best for the community
* Showing empathy towards other community members

Examples of unacceptable behavior by participants include:

* The use of sexualized language or imagery and unwelcome sexual attentions or
advances
* Trolling, insulting/derogatory comments, and personal or political attacks
* Public or private harassment
* Publishing others' private information, such as a physical or electronic
  address, without explicit permission
* Other conduct which could reasonably be considered inappropriate in a
  professional setting

### Our Responsibilities

Project maintainers are responsible for clarifying the standards of acceptable
behavior and are expected to take appropriate and fair corrective actions in
response to any instance of unacceptable behavior.

Project maintainers have the right and responsibility to remove, edit, or
reject comments, commits, code, wiki edits, issues, and other contributions
that are not aligned to this Code of Conduct, to temporarily or permanently
ban any contributor for other behaviors that they deem inappropriate,
threatening, offensive, or harmful.

### Scope

This Code of Conduct applies both within project spaces and in public spaces
when an individual is representing the project or its community. Examples of
representing a project or community include using an official project e-mail
address, posting via an official social media account, or acting as an appointed
representative at an online or offline event. Representation of a project may be
further defined and clarified by project maintainers.

### Attribution

This Code of Conduct is adapted from the [Contributor Covenant][homepage], version 1.4,
available at [http://contributor-covenant.org/version/1/4][version]

[homepage]: http://contributor-covenant.org
[version]: http://contributor-covenant.org/version/1/4/
