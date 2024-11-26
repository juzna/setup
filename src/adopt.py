# Adopt a dotfile from the system.
#
# Usage:
#  python3 -m adopt [--sensitive] [--private] [--company] <path>
#
# This will move the file from the system into the dotfiles directory.
import argparse
import os
import pathlib
import shutil

try:
    repo_dir = pathlib.Path(__file__).parent.parent
except NameError:  # __file__ not set in interactive mode
    repo_dir = pathlib.Path("~/projects/juzna/setup").expanduser()


parser = argparse.ArgumentParser(description="Adopt a dotfile from the system.")
parser.add_argument("--sensitive", action="store_true", help="Mark the file as sensitive.")
parser.add_argument("--private", action="store_true", help="Mark the file as private.")
parser.add_argument("--company", action="store_true", help="Mark the file as company-specific.")
parser.add_argument("path", help="Path to the file to adopt.")
args = parser.parse_args()

# Find relative path of the file.
full_path = pathlib.Path(args.path).expanduser()
rel_path = full_path.relative_to(pathlib.Path.home())

# Find the target dotfiles directory.
if args.sensitive:
    repo_path = repo_dir / "secrets" / "dotfiles" / rel_path
elif args.private:
    repo_path = repo_dir / "private" / "dotfiles" / rel_path
elif args.company:
    repo_path = repo_dir / "company" / "dotfiles" / rel_path
else:
    repo_path = repo_dir / "dotfiles" / rel_path

# Create the parent directories if they don't exist.
repo_path.parent.mkdir(parents=True, exist_ok=True)

# Move the file to the dotfiles directory.
shutil.move(full_path, repo_path)

# Create a symlink to the new location.
os.symlink(repo_path, full_path)

print(f"Adopted {full_path} into {repo_path}")
