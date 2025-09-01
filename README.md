# Python Project Template

A comprehensive Python project template with modern tooling for CI/CD, code quality, and automated releases.

## Features

- **Package Management**: uv for fast, reliable Python package management
- **Linting & Formatting**: ruff for lightning-fast linting and code formatting
- **Type Checking**: ty for static type analysis
- **Pre-commit Hooks**: Automated code quality checks before commits
- **Conventional Commits**: Standardized commit messages for semantic versioning
- **CI/CD**: GitHub Actions workflows for testing and automated releases
- **Semantic Versioning**: Automatic version bumping based on commit types

## Quick Start

### 1. Set up the project

```bash
# Clone this template
git clone <your-repo-url>
cd template

# Install uv (if not already installed)
curl -LsSf https://astral.sh/uv/install.sh | sh

# Install dependencies
uv sync --dev

# Install pre-commit hooks
uv run pre-commit install
```

### 2. Development workflow

```bash
# Format and lint code
uv run ruff check --fix .
uv run ruff format .

# Type check
uv run ty check src/

# Run tests
uv run pytest

# Make commits using conventional format
git add .
uv run cz commit
```

### 3. Docker Development (Optional)

```bash
# Build and run the application in Docker
docker-compose up template

# Run tests in Docker
docker-compose --profile test up template-test

# Start a development container
docker-compose --profile dev up template-dev

# Build Docker image manually
docker build -t template .

# Run the container
docker run --rm template
```

## Tools & Configuration

### uv (Package Management)

This project uses [uv](https://github.com/astral-sh/uv) for fast Python package management.

```bash
# Install dependencies
uv sync

# Install dev dependencies
uv sync --dev

# Add a new dependency
uv add package-name

# Add a dev dependency
uv add --dev package-name

# Run commands in the project environment
uv run python script.py
```

### ruff (Linting & Formatting)

[ruff](https://github.com/astral-sh/ruff) provides fast linting and formatting.

```bash
# Check for linting issues
uv run ruff check .

# Auto-fix linting issues
uv run ruff check --fix .

# Format code
uv run ruff format .

# Check formatting without making changes
uv run ruff format --check .
```

Configuration is in `pyproject.toml` under `[tool.ruff]`.

### ty (Type Checking)

[ty](https://github.com/astral-sh/ty) provides fast type checking.

```bash
# Type check your code
uv run ty check src/
```

Configuration is in `pyproject.toml` under `[tool.ty]`.

### Pre-commit Hooks

Pre-commit hooks ensure code quality before commits.

```bash
# Install hooks
uv run pre-commit install

# Run hooks manually
uv run pre-commit run --all-files

# Update hooks
uv run pre-commit autoupdate
```

### Conventional Commits

This project uses [conventional commits](https://conventionalcommits.org/) for semantic versioning.

```bash
# Interactive commit with conventional format
uv run cz commit

# Or use standard git commit with conventional format
git commit -m "feat: add new feature"
git commit -m "fix: resolve bug in module"
git commit -m "docs: update README"
```

Available commit types:
- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation changes
- `style`: Code style changes
- `refactor`: Code refactoring
- `perf`: Performance improvements
- `test`: Test changes
- `build`: Build system changes
- `ci`: CI/CD changes
- `chore`: Other changes
- `revert`: Revert previous commit

## CI/CD

### GitHub Actions Workflows

- **CI**: Runs on every push and PR
  - Linting with ruff
  - Type checking with ty
  - Tests with pytest
  - Coverage reporting

- **Release**: Runs on push to main branch
  - Automatic semantic versioning
  - Creates GitHub releases
  - Updates changelog

### Automated Releases

When you merge a PR to the `main` branch:

1. The release workflow detects conventional commits
2. Determines version bump (patch/minor/major)
3. Updates version in `pyproject.toml`
4. Creates a git tag
5. Generates a GitHub release
6. Updates `CHANGELOG.md`

### Docker CI/CD

The CI pipeline includes comprehensive Docker testing:

- **Automatic Detection**: Finds Dockerfiles in the repository
- **Build Testing**: Builds Docker images with caching for faster builds
- **Container Testing**: Runs containers and verifies functionality
- **Test Execution**: Executes test suites inside containers
- **Resource Cleanup**: Automatically cleans up Docker resources
- **PR Protection**: Docker tests must pass before PRs can be merged

#### When Docker Tests Run

Docker tests are triggered when:
- A Dockerfile is modified
- Source code changes (`src/` directory)
- Test files change (`tests/` directory)
- Project configuration changes (`pyproject.toml`)
- On all pull requests

#### Docker Test Workflow

1. **Check for Dockerfile**: Scans repository for Dockerfiles
2. **Build Image**: Creates Docker image with build caching
3. **Functionality Test**: Verifies basic application functionality
4. **Run Tests**: Executes test suite inside container
5. **Cleanup**: Removes temporary images and resources

## Project Structure

```
template/
├── .github/
│   └── workflows/
│       ├── ci.yml          # CI/CD pipeline (includes Docker tests)
│       ├── docker.yml      # Dedicated Docker testing workflow
│       └── release.yml     # Automated releases
├── .pre-commit-config.yaml # Pre-commit hooks
├── .dockerignore          # Docker build exclusions
├── cz.toml                # Conventional commits config
├── docker-compose.yml     # Docker development setup
├── Dockerfile             # Container definition
├── pyproject.toml         # Project configuration
├── src/
│   └── template/          # Source code
│       ├── __init__.py
│       └── py.typed       # Type stub marker
├── tests/                 # Test files
├── .python-version       # Python version
└── README.md             # This file
```

## Development Guidelines

### Code Style

- Use type hints for all function parameters and return values
- Add docstrings to all public functions with Args/Returns sections
- Use double quotes for strings
- Follow PEP 8 style guidelines (enforced by ruff)

### Example Function

```python
def example_function(param1: str, param2: int | None = None) -> dict[str, str]:
    """Example function demonstrating proper documentation.

    Args:
        param1: Required string parameter
        param2: Optional integer parameter

    Returns:
        Dictionary with string keys and values
    """
    result = {"param1": param1}
    if param2 is not None:
        result["param2"] = str(param2)
    return result
```

## Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Make your changes following the guidelines above
4. Run tests and linting: `uv run pytest && uv run ruff check .`
5. Commit with conventional format: `uv run cz commit`
6. Push to your branch and create a PR

## License

This template is provided as-is for creating new Python projects.
