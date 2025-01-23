#!/usr/bin/python

import argparse
import os
import re
import shutil
import subprocess
import sys
import filecmp

scriptPath = os.path.dirname(__file__)

def ensure_directories(file_path):
    # Extract the directory part of the path
    directory = os.path.dirname(file_path)
    if directory:  # Only create directories if there's a directory component
        os.makedirs(directory, exist_ok=True)


def run(command, capture=True, check=True, echo=False):
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
        return result.stdout.decode("utf-8").strip("\r\n\t ")

    return None


def discover_version(args):
    version = {}

    if not shutil.which("git"):
        sys.stderr.write("Could not find git!\n")
        sys.exit(1)

    version["LAST_TAG"] = run("git describe --tags --abbrev=0", echo=args.verbose)
    version["REVISIONS_SINCE_TAG"] = run(f"git rev-list --count {version['LAST_TAG']}..HEAD", echo=args.verbose)
    version["HEAD_HASH"] = run("git rev-parse --short HEAD", echo=args.verbose)
    version["VERSION_LONG"] = '{0}-{1}-g{2}'.format(version["LAST_TAG"], version["REVISIONS_SINCE_TAG"], version["HEAD_HASH"])

    return version


def generate_from_template(args, version, template, output):
    data = None
    with open(template, "rt") as file:
        data = file.read()

    for keyname, value in version.items():
        data = data.replace(f"@{keyname}@", value)

    with open(output, "wt") as file:
        file.write(data)


def are_files_equal(file1, file2):
    try:
        return filecmp.cmp(file1, file2, shallow=False)
    except FileNotFoundError:
        pass
    return False


def overwrite_if_not_same(args, source, dest):
    """
    Checks if source and dest files are the same. If not, it replaces dest with
    source. If they are the same, the source file is removed. Returns True if
    the file was replaced, or False if no replacement was done.
    """
    if not are_files_equal(source, dest):
        if args.verbose:
            sys.stderr.write("Contents changed, replacing target file\n")
        os.replace(source, dest)
        return True
    else:
        if args.verbose:
            sys.stderr.write("Same contents, not replacing target file\n")
        os.remove(source)
        return False


def drop_meson_turd(args, file_path):
    if not args.meson_turd:
        return
    turd_name = args.meson_turd
    if args.verbose:
        sys.stderr.write(f"Creating Meson turd: '{turd_name}'\n")
    with open(turd_name, "wt") as fd:
        fd.write("This turd file is just to make Meson happy. See https://github.com/mesonbuild/meson/issues/2320\n")


def generate_revision(args):
    output = args.file_path
    template = os.path.join(scriptPath, "SDL_revision.h.in")

    ensure_directories(output)
    sys.stderr.write("Generating {0}...\n".format(os.path.basename(output)))

    version = discover_version(args)
    generate_from_template(args, version, template, output + '.tmp')

    if overwrite_if_not_same(args, output + '.tmp', output):
        sys.stderr.write("Version: {0}\n".format(version["VERSION_LONG"]))
        drop_meson_turd(args, output)

def main():
    parser = argparse.ArgumentParser(
        description="Generate SDL_revision.h"
    )
    parser.add_argument(
        "--meson-turd",
        action="store",
        type=str,
        help="Drop a turd so Meson is happy with the target."
    )
    parser.add_argument(
        "--verbose",
        action="store_true",
        help="Be more verbose about what we're doing"
    )
    parser.add_argument(
        "file_path",
        type=str,
        help="Path to the output SDL_revision.h file"
    )

    args = parser.parse_args()
    output = args.file_path
    generate_revision(args)


if __name__ == "__main__":
    main()
