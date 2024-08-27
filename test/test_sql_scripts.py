"""
Tests to ensure the formatting and style of SQL scripts is correct.
"""
from pathlib import Path
import re

SQL_DIR = Path(__file__).parent.parent / 'plugin' / 'sql'


def test_no_tabs_are_present():
    # Arrange, act and assert
    for sql_file in SQL_DIR.rglob('*.sql'):
        if '\t' in sql_file.read_text():
            raise AssertionError(f"Tab character in {sql_file.name}")


def test_date_format():
    """
    This test fails if files contain dates in 01/02/2024 format.
    """
    # Arrange, act and assert
    for sql_file in SQL_DIR.rglob('*.sql'):
        if match := re.search(r'\d{2}\/\d{2}\/\d{4}', sql_file.read_text()):
            raise AssertionError(f'Bad date format in {sql_file.name}: {match.group()}')
