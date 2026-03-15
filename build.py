#!/usr/bin/env python3
"""
Cross-platform CMake build script for C/C++ projects.
Usage: python build.py [target]

Targets (and their bound language):
  HelloWorld : C
  Random     : C
  SizeOfTest : C
  FTXUI      : CXX
  MathUtils  : C      (example, if needed)
  GUIApp     : CXX    (example, if needed)
If no target is given, defaults to HelloWorld.
"""

import os
import sys
import platform
import subprocess
import shutil
import argparse
from pathlib import Path

# ==================== Configuration ====================
TARGET_LANGUAGE_MAP = {
    "HelloWorld": "C",
    "Random": "C",
    "SizeOfTest": "C",
    "FTXUI": "CXX",
}
DEFAULT_TARGET = "HelloWorld"

# ==================== Helper Functions ====================
def check_command_exists(cmd_name: str) -> bool:
    """Check if a command exists in PATH."""
    return shutil.which(cmd_name) is not None

def run_command(cmd, cwd=None, desc="command"):
    """
    Run a command, print output, exit on failure.
    Returns subprocess.CompletedProcess on success.
    """
    print(f"Running: {' '.join(cmd)}")
    try:
        result = subprocess.run(
            cmd,
            cwd=cwd,
            check=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            encoding="utf-8"
        )
        if result.stdout:
            print(result.stdout)
        return result
    except subprocess.CalledProcessError as e:
        print(f"\nError: {desc} failed with exit code {e.returncode}")
        if e.stderr:
            print("STDERR:")
            print(e.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"\nError: {desc} failed - {str(e)}")
        sys.exit(1)

# ==================== Main ====================
def main():
    parser = argparse.ArgumentParser(description="Cross-platform CMake build script")
    parser.add_argument("target", nargs="?", default=DEFAULT_TARGET,
                        help=f"Target executable name (default: {DEFAULT_TARGET})")
    args = parser.parse_args()

    target = args.target
    if target not in TARGET_LANGUAGE_MAP:
        print(f"Error: unknown target '{target}'")
        print("Available targets:")
        for t, lang in TARGET_LANGUAGE_MAP.items():
            print(f"  {t} (language: {lang})")
        sys.exit(1)

    language = TARGET_LANGUAGE_MAP[target]
    source_dir = Path.cwd().resolve()
    build_dir = source_dir / "Build"
    output_dir = source_dir / "Output"
    compile_commands = build_dir / "compile_commands.json"

    # ---------- Platform detection ----------
    system = platform.system()
    # Detect MSYS2 environment (including MINGW64, MINGW32, MSYS, UCRT64, CLANG64, etc.)
    # The presence of 'MSYSTEM' environment variable indicates an MSYS2 shell.
    is_msys = "MSYSTEM" in os.environ

    # In a native Windows Command Prompt or PowerShell, we use MinGW Makefiles.
    # In any MSYS2 shell (even if it says Windows as system), we use Unix Makefiles
    # because the shell provides a Unix-like environment where make/gcc behave as on Unix.
    if system == "Windows" and not is_msys:
        generator = "MinGW Makefiles"
        print("Platform: Windows (native) -> using MinGW Makefiles")
    else:
        generator = "Unix Makefiles"
        env_type = os.environ.get("MSYSTEM", "unknown") if is_msys else ""
        print(f"Platform: {system}{' (MSYS: ' + env_type + ')' if is_msys else ''} -> using Unix Makefiles")

    # ---------- Print configuration ----------
    print("=" * 60)
    print("Build Configuration")
    print(f"  Target        : {target} (language: {language})")
    print(f"  Build directory: {build_dir}")
    print(f"  Output directory: {output_dir}")
    print(f"  CMake generator: {generator}")
    print("=" * 60)

    # ---------- Check required tools ----------
    if not check_command_exists("cmake"):
        print("Error: cmake not found in PATH")
        sys.exit(1)

    # ---------- Prepare build directory ----------
    build_dir.mkdir(parents=True, exist_ok=True)
    os.chdir(build_dir)

    # ---------- CMake configuration ----------
    cmake_cmd = [
        "cmake",
        str(source_dir),
        "-G", generator,
        f"-DTARGET={target}",
        f"-DPROJECT_LANGUAGE={language}"
    ]
    run_command(cmake_cmd, desc="CMake configuration")

    # ---------- Copy compile_commands.json if generated ----------
    if compile_commands.exists():
        try:
            shutil.copy(compile_commands, source_dir)
            print("Copied compile_commands.json to source directory")
        except Exception as e:
            print(f"Warning: could not copy compile_commands.json - {e}")
    else:
        print("Note: compile_commands.json not generated (enable with -DCMAKE_EXPORT_COMPILE_COMMANDS=ON if needed)")

    # ---------- Build ----------
    build_cmd = ["cmake", "--build", ".", "--parallel"]
    run_command(build_cmd, desc="Build")

    # ---------- Return to source directory ----------
    os.chdir(source_dir)

    # ---------- Locate and run executable ----------
    exe_path = output_dir / target
    print(f"Executable file path: {exe_path}")
    # On Windows, executables usually have .exe suffix, even in MSYS environments.
    # Check both possibilities and prefer the .exe if it exists.
    if system == "Windows":
        exe_with_suffix = exe_path.with_suffix(".exe")
        if exe_with_suffix.exists():
            exe_path = exe_with_suffix
        # If original (no suffix) exists, keep it as fallback (though unlikely)

    if not exe_path.exists():
        print(f"Error: executable not found: {exe_path}")
        print("Please ensure CMakeLists.txt sets RUNTIME_OUTPUT_DIRECTORY to 'Output' correctly.")
        sys.exit(1)

    run_command([str(exe_path)], desc=f"Run {target}")

    print(f"\n✅ Successfully built and ran {target} (language: {language})")

if __name__ == "__main__":
    if sys.version_info < (3, 8):
        print("Error: this script requires Python 3.8 or higher")
        sys.exit(1)
    main()