# AI Development Workspace

A production-ready development workspace configured for AI-assisted development with Claude and Cursor.

## Quick Start

### Prerequisites

- Node.js 18+
- pnpm (recommended) or npm/yarn
- Python 3.10+ (for Python projects)

### Setup

```bash
# Clone and navigate to workspace
cd ~/Development/ai-workspace

# Install dependencies
pnpm install

# Start development server
pnpm dev
```

### Available Scripts

| Command | Description |
|---------|-------------|
| `pnpm dev` | Start development server |
| `pnpm build` | Build for production |
| `pnpm test` | Run tests in watch mode |
| `pnpm test:run` | Run tests once |
| `pnpm test:coverage` | Run tests with coverage report |
| `pnpm lint` | Check for linting errors |
| `pnpm lint:fix` | Fix linting errors |
| `pnpm format` | Format code with Prettier |
| `pnpm typecheck` | Run TypeScript type checking |

## Project Structure

```
ai-workspace/
├── src/                 # Application source code
├── tests/               # Test files
├── docs/                # Documentation
├── .claude/             # Claude AI configuration
│   ├── settings.json    # Permission settings
│   └── agents/          # Custom agent prompts
├── .cursor/             # Cursor IDE configuration
│   └── rules/           # Coding rules and standards
├── CLAUDE.md            # Project context for Claude
├── package.json         # Node.js dependencies
└── README.md            # This file
```

## AI Assistant Configuration

### Claude Code

Configuration in `.claude/` directory:
- `settings.json`: Defines allowed/denied operations
- `agents/`: Custom agent prompts for code review, testing, etc.

### Cursor

Rules in `.cursor/rules/`:
- `typescript.mdc`: TypeScript coding standards
- `react.mdc`: React component patterns
- `security.mdc`: Security best practices

## Coding Standards

- **TypeScript**: Strict types, no `any`, explicit return types
- **React**: Functional components, proper hooks usage
- **Testing**: 80% coverage target with Vitest
- **Security**: Input validation, no hardcoded secrets

See `CLAUDE.md` for complete coding guidelines.

## License

MIT
