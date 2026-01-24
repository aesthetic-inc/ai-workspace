# Post Tool Use Hook

## Description

Automatically format files after Claude writes or edits them to maintain consistent code style.

## Trigger

- After `Write` tool creates a new file
- After `Edit` tool modifies a file
- File type: `.ts`, `.tsx`, `.js`, `.jsx`, `.json`, `.css`, `.md`

## Implementation

### Hook Configuration

When Claude creates or modifies a file, automatically run formatting:

```typescript
// Conceptual hook configuration
{
  "hooks": {
    "post-tool-use": {
      "tools": ["Write", "Edit"],
      "filePatterns": ["*.ts", "*.tsx", "*.js", "*.jsx", "*.json", "*.css", "*.md"],
      "action": "format"
    }
  }
}
```

### Format Action

```bash
# After file write/edit, run:
format_file() {
  local file="$1"
  local ext="${file##*.}"

  case "$ext" in
    ts|tsx|js|jsx)
      # Format with Prettier
      npx prettier --write "$file"
      # Fix ESLint issues
      npx eslint --fix "$file" 2>/dev/null || true
      ;;
    json)
      npx prettier --write "$file"
      ;;
    css|scss)
      npx prettier --write "$file"
      ;;
    md)
      npx prettier --write "$file"
      ;;
    py)
      black "$file" 2>/dev/null || true
      ruff check --fix "$file" 2>/dev/null || true
      ;;
  esac

  echo "✓ Formatted: $file"
}
```

## Behavior

### On File Write

1. Claude creates new file with `Write` tool
2. Hook detects file creation
3. Runs Prettier on the file
4. Runs ESLint fix if applicable
5. File is saved with proper formatting

### On File Edit

1. Claude modifies file with `Edit` tool
2. Hook detects file modification
3. Runs Prettier on the file
4. Runs ESLint fix if applicable
5. Changes are formatted consistently

## Configuration Options

### Enable/Disable

```json
{
  "postToolUse": {
    "enabled": true,
    "formatOnWrite": true,
    "formatOnEdit": true,
    "lintOnWrite": true,
    "lintOnEdit": false
  }
}
```

### File Type Configuration

```json
{
  "postToolUse": {
    "fileTypes": {
      "typescript": {
        "formatter": "prettier",
        "linter": "eslint"
      },
      "python": {
        "formatter": "black",
        "linter": "ruff"
      },
      "json": {
        "formatter": "prettier",
        "linter": null
      }
    }
  }
}
```

## Benefits

1. **Consistency**: All code follows same style
2. **Automation**: No manual formatting needed
3. **Clean Diffs**: Formatting changes don't pollute commits
4. **Best Practices**: ESLint fixes enforce patterns

## Caveats

- May slightly slow down file operations
- Requires Prettier/ESLint to be installed
- Won't run if tools are not available (fails silently)

## Integration with Pre-Commit

Works in conjunction with pre-commit hook:
- Post-tool-use: Immediate formatting during development
- Pre-commit: Final validation before commit

This ensures code is always formatted, even if post-tool-use hook is bypassed.
