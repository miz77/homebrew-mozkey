#!/usr/bin/env python3
"""Update only from a public, versioned release in miz77/mozkey."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import tempfile
import urllib.request
import zipfile

REPOSITORY = "miz77/mozkey"


def read(url):
    request = urllib.request.Request(url, headers={"User-Agent": "mozkey-tap-updater"})
    with urllib.request.urlopen(request, timeout=120) as response:
        return response.read()


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--release-tag", required=True)
    args = p.parse_args()
    if not re.fullmatch(r"macos-v20\d{2}\.\d{2}\.\d{2}\.[1-9]\d*", args.release_tag):
        raise ValueError("Invalid release tag")
    release = json.loads(read(f"https://api.github.com/repos/{REPOSITORY}/releases/tags/{args.release_tag}"))
    if release["draft"] or release["tag_name"] != args.release_tag:
        raise ValueError("Release must be public and match requested tag")
    version = args.release_tag.removeprefix("macos-v")
    name = f"MozKey-macOS-Universal-{version}.zip"
    base = f"https://github.com/{REPOSITORY}/releases/download/{args.release_tag}/"
    names = [a["name"] for a in release["assets"]]
    for needed in (name, "SHA256SUMS.txt", "provenance.json"):
        if names.count(needed) != 1:
            raise ValueError("Missing or ambiguous release asset: " + needed)
    sums = read(base + "SHA256SUMS.txt").decode().splitlines()
    matches = [line.split()[0] for line in sums if len(line.split()) == 2 and line.split()[1] == name]
    if len(matches) != 1 or not re.fullmatch(r"[0-9a-f]{64}", matches[0]):
        raise ValueError("Invalid checksum manifest")
    provenance = json.loads(read(base + "provenance.json"))
    if provenance["build_repository"] != REPOSITORY or provenance["distribution_version"] != version:
        raise ValueError("Unexpected provenance")
    with tempfile.TemporaryFile() as f:
        with urllib.request.urlopen(base + name, timeout=120) as response:
            h = hashlib.sha256()
            for block in iter(lambda: response.read(1024 * 1024), b""):
                h.update(block)
                f.write(block)
        if h.hexdigest() != matches[0]:
            raise ValueError("ZIP hash mismatch")
        f.seek(0)
        with zipfile.ZipFile(f) as z:
            if z.namelist().count(provenance["package_filename"]) != 1:
                raise ValueError("Ambiguous PKG entry")
            if json.loads(z.read("provenance.json")) != provenance:
                raise ValueError("Embedded provenance mismatch")
            package_hash = hashlib.sha256()
            with z.open(provenance["package_filename"]) as pkg:
                for block in iter(lambda: pkg.read(1024 * 1024), b""):
                    package_hash.update(block)
            if package_hash.hexdigest() != provenance["package_sha256"]:
                raise ValueError("PKG hash mismatch")
    cask = Path(__file__).resolve().parents[1] / "Casks/mozkey.rb"
    content = cask.read_text()
    for field, value in (("version", version), ("sha256", matches[0])):
        content, count = re.subn(rf'^  {field} "[^"\n]+"$', f'  {field} "{value}"', content, flags=re.M)
        if count != 1:
            raise ValueError("Unexpected Cask format")
    cask.write_text(content)
    print(f"Updated {cask}: {version} / {matches[0]}")
    print("Review git diff and run brew style Casks/mozkey.rb before pushing.")


if __name__ == "__main__":
    main()
