# Pre-Commit Hook

## Description

Automatically run linting and type checking before allowing commits to ensure code quality.

## Trigger

- Before `git commit` execution
- Validates staged files only

## Implementation

### Husky Setup

```bash
# Install husky
npm install -D husky lint-staged

# Initialize husky
npx husky install

# Add pre-commit hook
npx husky add .husky/pre-commit "npx lint-staged"
```

### Hook Script (`.husky/pre-commit`)

```bash
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

echo "Running pre-commit checks..."

# Run lint-staged for staged files
npx lint-staged

# Run type check on entire project
echo "Running type check..."
npx tsc --noEmit

# Exit with error if any check failed
if [ $? -ne 0 ]; then
  echo "❌ Pre-commit checks failed. Please fix errors before committing."
  exit 1
fi

echo "✅ Pre-commit checks passed!"
```

## Lint-Staged Configuration

### In package.json

```json
{
  "lint-staged": {
    "*.{ts,tsx}": [
      "eslint --fix --max-warnings 0",
      "prettier --write"
    ],
    "*.{js,jsx}": [
      "eslint --fix",
      "prettier --write"
    ],
    "*.{json,css,scss,md}": [
      "prettier --write"
    ],
    "*.py": [
      "black",
      "ruff check --fix"
    ]
  }
}
```

## Checks Performed

### 1. ESLint (TypeScript/JavaScript)

```bash
# Fix auto-fixable issues
eslint --fix --max-warnings 0 <staged-files>

# Fails on:
# - Any errors
# - Any warnings (--max-warnings 0)
```

### 2. Prettier (Formatting)

```bash
# Auto-format staged files
prettier --write <staged-files>
```

### 3. TypeScript (Type Check)

```bash
# Check entire project for type errors
tsc --noEmit

# Fails on:
# - Type errors
# - Missing types
# - Invalid configurations
```

## Bypass (Emergency Only)

```bash
# Skip pre-commit hooks (use sparingly!)
git commit --no-verify -m "Emergency fix"
```

**Warning**: Only bypass for true emergencies. Document why in commit message.

## Troubleshooting

### Hook Not Running

```bash
# Ensure husky is installed
npx husky install

# Check hook permissions
chmod +x .husky/pre-commit
```

### Slow Hooks

```bash
# Only check staged files, not entire project
# Use lint-staged for file-specific checks
# Run tsc with incremental mode
```

### ESLint Errors on Generated Files

```bash
# Add to .eslintignore
dist/
build/
*.generated.ts
```

## Best Practices

1. Keep hooks fast (< 10 seconds)
2. Only check staged files when possible
3. Auto-fix what can be auto-fixed
4. Provide clear error messages
5. Allow emergency bypass with documentation
