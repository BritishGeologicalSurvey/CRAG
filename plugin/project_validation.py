import dataclasses
from enum import Enum
from pathlib import Path

from .utils import (  # noqa
    FieldDataCaptureProject,
    ipdb_breakpoint,
)


class ValidationStatus(Enum):
    """
    Class to store validation statuses as enums.
    Includes some methods for comparing values according to this discussion:
    https://stackoverflow.com/questions/39268052/how-to-compare-enums-in-python
    """
    FAIL = 0
    WARNING = 10
    PASS = 20

    def __lt__(self, other) -> bool:
        """
        Less than implementation.
        """
        if self.__class__ is other.__class__:
            # We have to get the actual integer value from the object
            return self.value < other.value
        return NotImplemented

    def __gt__(self, other) -> bool:
        """
        Greater than implementation.
        """
        if self.__class__ is other.__class__:
            # We have to get the actual integer value from the object
            return self.value > other.value
        return NotImplemented


@dataclasses.dataclass
class ValidationResult:
    validation_function: str
    # Set the status to PASS initially and change it later if required
    status: ValidationStatus = dataclasses.field(default_factory=lambda: ValidationStatus.PASS)
    # Make the list of messages default to an empty list
    messages: list[str] = dataclasses.field(default_factory=list)


def validate_project(project_dir: Path) -> list[ValidationResult]:
    """
    Run all checks against the given project directory.
    """
    checks = [
        check_no_conflict_gpkg_exists,
    ]

    results = [
        check_func(FieldDataCaptureProject(project_dir))
        for check_func in checks
    ]

    return results


def check_no_conflict_gpkg_exists(project: FieldDataCaptureProject) -> ValidationResult:
    """
    Check that no conflict GeoPackage files exist in the given project.
    These are determined by finding GeoPackage files with 'conflicted copy' in their name.
    """
    result = ValidationResult(validation_function=check_no_conflict_gpkg_exists.__name__)

    # Perform check
    conflict_files = list(project.project_dir.glob("*conflicted copy*.gpkg"))

    # Prepare results
    # If pass
    if len(conflict_files) > 0:
        result.status = ValidationStatus.FAIL
        for conflict_file in conflict_files:
            result.messages.append(f"Conflict GeoPackge file found: {conflict_file.name}")

    return result
