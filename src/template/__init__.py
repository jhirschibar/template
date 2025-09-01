def hello(name: str | None = None) -> str:
    """Return a greeting message.

    Args:
        name: Optional name to include in the greeting. If None, uses generic greeting.

    Returns:
        A greeting string.
    """
    if name:
        return f"Hello, {name}! Welcome to the template project."
    return "Hello from template!"
