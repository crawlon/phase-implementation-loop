#!/usr/bin/env python3
"""Validate stable role packaging and reference isolation; not behavioral correctness."""
import json
import re
from pathlib import Path
from urllib.parse import unquote, urlsplit

import yaml


ROOT = Path(__file__).resolve().parents[1]
NAMES = {"delivery-owner", "roadmap-planner", "implementation-orchestrator"}
LEGACY = {"phase-implementation-loop", "phase-implementation-autopilot",
          "managed-implementation-loop", "managed-implementation-autopilot"}
LEGACY |= {name + "-trial" for name in LEGACY | {"delivery-owner", "roadmap-planner"}}


def require(condition, message):
    if not condition:
        raise ValueError(message)


def anchors(path):
    found, counts = set(), {}
    fenced = False
    for line in path.read_text().splitlines():
        if line.lstrip().startswith(("```", "~~~")):
            fenced = not fenced
        if fenced:
            continue
        heading = re.match(r"^#{1,6}\s+(.+?)\s*#*$", line)
        if heading:
            slug = re.sub(r"[^\w -]", "", heading[1].lower()).replace(" ", "-")
            count = counts.get(slug, 0)
            found.add(f"{slug}-{count}" if count else slug)
            counts[slug] = count + 1
    return found


def main():
    manifest = json.loads((ROOT / ".codex-plugin/plugin.json").read_text())
    require(manifest["name"] == "delivery-workflow", "Unexpected plugin identity")
    require(manifest["version"] == "1.3.0", "Unexpected stable version")
    require(manifest["skills"] == "./skills/", "Unexpected skills root")
    dirs = {path.name for path in (ROOT / "skills").iterdir() if path.is_dir()}
    require(dirs == NAMES, f"Unexpected skill directories: {dirs ^ NAMES}")
    for name in sorted(NAMES):
        folder = ROOT / "skills" / name
        entry = (folder / "SKILL.md").read_text()
        front = re.match(r"\A---\n(.*?)\n---\n", entry, re.S)
        require(front is not None, f"Missing frontmatter: {name}")
        fields = yaml.safe_load(front[1])
        require(fields["name"] == name, f"Name mismatch: {name}")
        require(fields.get("description"), f"Missing description: {name}")
        ui = yaml.safe_load((folder / "agents/openai.yaml").read_text())
        require(ui["policy"]["allow_implicit_invocation"] is False,
                f"Role is not explicitly selectable: {name}")
        require(f"${name}" in ui["interface"]["default_prompt"],
                f"Default prompt missing role name: {name}")
        size = len(ui["interface"]["short_description"])
        require(25 <= size <= 64, f"UI short description length: {name}")

    entrypoints = {p.parent.name for p in (ROOT / "skills").rglob("SKILL.md")}
    require(entrypoints == NAMES, "Unexpected nested skill entrypoint")
    marketplace = json.loads((ROOT.parents[1] / ".agents/plugins/marketplace.json").read_text())
    require(len(marketplace["plugins"]) == 1, "Legacy plugin still advertised")
    plugin = marketplace["plugins"][0]
    require(plugin["name"] == manifest["name"], "Marketplace identity mismatch")
    require(plugin["source"]["path"] == "./plugins/delivery-workflow", "Marketplace source mismatch")
    links = 0
    for path in ROOT.rglob("*.md"):
        contents = path.read_text()
        for invoked in re.findall(r"\$([a-z][a-z0-9-]*)", contents):
            require(invoked not in LEGACY, f"Retired skill invocation in {path}: {invoked}")
        for target in re.findall(r"(?<!!)\[[^\]\n]*\]\(([^)\n]+)\)", contents):
            parts = urlsplit(target.strip("<>"))
            if parts.scheme or parts.netloc:
                continue
            resolved = (path.parent / unquote(parts.path)).resolve() if parts.path else path
            require(resolved.is_relative_to(ROOT), f"Reference leaves active bundle: {path}: {target}")
            require(resolved.is_file(), f"Missing target: {path}: {target}")
            if parts.fragment:
                require(unquote(parts.fragment) in anchors(resolved),
                        f"Missing anchor: {path}: {target}")
            links += 1
    print(f"PASS: {len(NAMES)} explicit role skills; {links} local links/anchors; isolated protocols")


if __name__ == "__main__":
    main()
