#!/usr/bin/python

import os
import re
import shutil
import subprocess
import sys
import filecmp

debug = False
scriptPath = os.path.dirname(__file__)
template = os.path.join(scriptPath, "SDL_revision.h.in")
output = os.path.join(scriptPath, "SDL_revision.h")

def run(command, capture=True, check=True, echo=debug):
    """
    Run a command, optionally capturing the output, checking for a successful
    exit code, and echoing the command before execution.
    """
    environ = os.environ.copy()
    environ["LC_ALL"] = "C"

    # capture types:
    # False - no capture, show output to console
    # True - capture, no output to console
    # None - stream all output to /dev/null
    capture_target = None
    if capture:
        capture_target = subprocess.PIPE
    elif capture is None:
        capture_target = subprocess.DEVNULL

    shell = True
    if isinstance(command, list):
        # We do not do shell expansion for anything already quoted as a list.
        shell = False
        if echo:
            print(f"+ {' '.join(command)}")
    else:
        if echo:
            print(f"+ {command}")

    result = subprocess.run(command, shell=shell, check=check,
                            stdout=capture_target, stderr=capture_target,
                            env=environ, cwd=scriptPath)

    if capture:
        return result.stdout.decode("utf-8")

    return None

sys.stderr.write("Generating {0}...\n".format(os.path.basename(output)))

git_tag_name = ""
build = "0"
version_long = ""
git_hash = ""

if shutil.which("git"):
    result = run('git describe --tags --abbrev=0')
    git_tag_name = result.strip("\n\r\t ")
else:
    sys.stderr.write("git executable missing!\n")
    sys.exit(1)

result = run('git rev-list --count {0}..HEAD'.format(git_tag_name))
build = result.strip("\n\r\t ")

result = run('git rev-parse --short HEAD')
git_hash = result.strip("\n\r\t ")

version_long = "{0}-{1}-g{2}".format(git_tag_name, build, git_hash)

data = None

with open(template, "rt") as file:
    data = file.read()

data = data.replace("@VERSION_LONG@", version_long)

with open(output + ".tmp", "wt") as file:
    file.write(data)

equal = False
try:
    equal = filecmp.cmp(output + ".tmp", output, shallow=False)
except FileNotFoundError:
    pass

if not equal:
    sys.stderr.write("Version: {0}\n".format(version_long))
    os.replace(output + ".tmp", output)
else:
    os.remove(output + ".tmp")
