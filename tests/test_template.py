import pytest

from template import hello


class TestHello:
    """Test cases for the hello function."""

    def test_hello_without_name(self) -> None:
        """Test hello function without providing a name."""
        result = hello()
        assert result == "Hello from template!"

    def test_hello_with_name(self) -> None:
        """Test hello function with a name parameter."""
        result = hello("Alice")
        assert result == "Hello, Alice! Welcome to the template project."

    def test_hello_with_empty_name(self) -> None:
        """Test hello function with an empty string name."""
        result = hello("")
        assert result == "Hello from template!"

    @pytest.mark.parametrize(
        "name,expected",
        [
            ("Bob", "Hello, Bob! Welcome to the template project."),
            ("Charlie", "Hello, Charlie! Welcome to the template project."),
            ("Diana", "Hello, Diana! Welcome to the template project."),
        ],
    )
    def test_hello_parametrized(self, name: str, expected: str) -> None:
        """Test hello function with multiple names using parametrization."""
        result = hello(name)
        assert result == expected
