# claude-sandbox

Keep Claude on a leash by keeping it in a container.

This script allows you to run `claude-code` in a restricted environment where it only has access to the project you want it to work on and the configurations you want it to use.

This is achieved by running a Docker image with `claude-code` installed and exposing only two volumes: one for Claude's global configuration and one for the working directory.

This way, you can keep states, conversations, and global configurations separated depending on the project you want the agent to work on.

## Installation

1. Clone this repository.
2. `cd` into the project folder.
3. Run the following commands:

   ```bash
   chmod +x install.sh
   ./install.sh
   ```

The installation script:

1. Copies the `claude-sandbox` script to `/usr/local/bin/`.
2. Copies the `Dockerfile` to `/usr/local/lib/`.
3. Creates the configuration path `~/.config/claude-sandbox/` with a default configuration folder at `~/.config/claude-sandbox/.claude`.
4. Builds the Docker image and names it `claude-sandbox`.

## Uninstall

From the project's folder, run:

```bash
chmod +x uninstall.sh
./uninstall.sh
```

The script removes the `claude-sandbox` script, Dockerfile, and configuration folder.

## How to Use

Navigate to the folder where you want to run Claude and run:

```bash
claude-sandbox
```

On the first run, you will be required to log in. After logging in, you will not be required to log in again when using the same environment.

By default, the global configuration for the agent is saved in:

```text
~/.config/claude-sandbox/.claude
```

### Custom Environments

If you already have global configurations that you want to use for your agent, you can create an environment folder inside `~/.config/claude-sandbox/` and place a `claude-code` folder containing your configurations inside it.

For example, if you have an environment called `test_env`, the structure of `~/.config/claude-sandbox/` should look like this:

```text
./
└── test_env/
    └── claude-code/
        ├── projects/
        ├── rules/
        └── skills/
```

You can then use the `-e` flag to select the environment:

```bash
claude-sandbox -e test_env
```

If you run the above command before creating the `test_env` environment, the `test_env` folder will be created automatically in `~/.config/claude-sandbox/`. After the first login, the `claude-code` folder will be created inside `test_env`.

### Change the Container Name

The default container name is `claude`. You can use the `-n` flag to change it:

```bash
claude-sandbox -n test_project
```
### Customize the Image
Edit the Docker file to add other tool that you might need in the container and then run the `install.sh` script to build the image
