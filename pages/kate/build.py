#!/usr/bin/env python3

from pathlib import Path
import json
import sys
import yaml

SOURCE_DIR = Path("kate/source")
TARGET_DIR = Path("kate/snippets")

TARGET_DIR.mkdir(parents=True, exist_ok=True)

errors = False

for src in sorted(SOURCE_DIR.glob("*.yml")):

    try:
        data = yaml.safe_load(src.read_text(encoding="utf-8"))
    except yaml.YAMLError as e:
        print(f"ERROR: {src}")
        print(e)
        errors = True
        continue

    snippets = sorted(data["snippets"], key=lambda s: s["trigger"])

    seen = set()
    out = {}

    for s in snippets:

        trigger = s["trigger"]

        if trigger in seen:
            print(f"ERROR: duplicate trigger '{trigger}' in {src.name}")
            errors = True
            continue

        seen.add(trigger)

        out[s["description"]] = {
            "prefix": trigger,
            "body": s["body"].splitlines(),
            "description": s["description"],
        }

    target = TARGET_DIR / f"{src.stem}.code-snippets"

    target.write_text(
        json.dumps(out, indent=2, ensure_ascii=False),
        encoding="utf-8",
    )

    print(f"generated {target}")

if errors:
    sys.exit(1)

print("\nDone.")
