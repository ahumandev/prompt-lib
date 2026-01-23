---
description: Run windows commands 
---

To run Windows commands on the Windows host: use Windows host execution script `windows`

### Usage Examples:
- `windows npm install` - Install npm dependencies on Windows host
- `windows npm run build` - Run npm build script on Windows host
- `windows mvn clean compile` - Run Maven commands using IntelliJ's Maven installation
- `windows node app.js` - Run Node.js applications on Windows host

### Important Notes:
- The script automatically handles path conversion between WSL2 and Windows

### Windows file system

The windows NTFS file system is accessible in /mnt/c/...

**VERY IMPORTANT**: **ALWAYS** ask the user's permission before executing any windows commands or modifying anything file on the Windows system.
