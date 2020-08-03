import json
import sys
from pathlib import Path

COC_SETTINGS = f"{Path.home()}/.config/nvim/coc-settings.json"


def main():
    with open(COC_SETTINGS) as f:
        settings = json.load(f)
    settings["python.autoComplete.extraPaths"][0] = sys.argv[1]
    settings["python.jediEnabled"] = sys.argv[2] == "True"
    with open(COC_SETTINGS, "w+") as f:
        json.dump(settings, f, ensure_ascii=False, sort_keys=True, indent=2)


if __name__ == "__main__":
    main()
