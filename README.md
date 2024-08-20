# tarup

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

## Overview

`tarup.sh` is a versatile Bash script designed to create tarball archives of directories with optional exclusion of certain files and directories. It supports custom exclusion sets and generates tarballs with a default filename format that includes the date, server name, and directory name. The script also ensures that the output file is not included in the archive.

## Features

- **Customizable Exclusions**: Choose between no exclusions, all common exclusions, or provide a custom list of files and directories to exclude.
- **Automatic Exclusion of Output File**: The script automatically excludes the tarball it is generating from the archive.
- **Default Filename Format**: The output file is named using the format `YYYYMMDD_tarup_[servername]_[directory].tar.gz`, where `YYYYMMDD` is the current date, `[servername]` is the hostname, and `[directory]` is the directory being archived.
- **Flexible Output Options**: Specify the output file's path and name if the default format doesn't suit your needs.

## Installation

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/drhdev/tarup.git
   ```
   
2. **Navigate to the Repository Directory:**
   ```bash
   cd tarup
   ```
   
3. **Make the Script Executable:**
   ```bash
   chmod +x tarup.sh
   ```

## Usage

```bash
./tarup.sh [OPTIONS]
```

### Options

- **`-e [none|all|custom]`**: Specify the exclusion set.
  - `none`   - No exclusions.
  - `all`    - Full set of common exclusions (default).
  - `custom` - Provide a custom list of exclusions (comma-separated).

- **`-o [output_file]`**: Specify the output tar.gz file's path and name.

- **`-h`, `-help`**: Display the help message.

### Default Behavior

- If no options are provided, the script uses the `all` exclusion set and creates a tarball named `YYYYMMDD_tarup_[servername]_[directory].tar.gz` in the current directory.

### Example Commands

1. **Run with Default Settings (All Exclusions):**
   ```bash
   ./tarup.sh
   ```

2. **Run with No Exclusions:**
   ```bash
   ./tarup.sh -e none
   ```

3. **Run with Custom Exclusions:**
   ```bash
   ./tarup.sh -e custom -e "*.log,.cache,.env"
   ```

4. **Specify a Custom Output File:**
   ```bash
   ./tarup.sh -o /path/to/output/file.tar.gz
   ```

5. **Display Help:**
   ```bash
   ./tarup.sh -h
   ./tarup.sh -help
   ```

## Example

Suppose you are in the `/home/user/project` directory on a server named `myserver`, and you run the following command:

```bash
./tarup.sh
```

The script will create a tarball named `20240820_tarup_myserver_project.tar.gz` in the `/home/user/project` directory, excluding common system files, cached files, and any files listed in the `all` exclusion set.

## License

This project is licensed under the GPL-3.0 License. See the [LICENSE](LICENSE) file for more details.

## Contributions

Contributions are welcome! Please submit pull requests or open issues to suggest improvements or report bugs.

## Acknowledgments

This script was developed to provide a simple yet powerful way to create backups of directories while allowing for flexible exclusion of unwanted files.
