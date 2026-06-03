from pathlib import Path
import re

SOURCE_PATH = Path('docs/user_guide/source/')
IMAGE_PATH = SOURCE_PATH / 'images'
INDEX_FILE_NAME = 'index.md'


def test_paths():
    # Assert
    assert SOURCE_PATH.exists() and SOURCE_PATH.is_dir()
    assert IMAGE_PATH.exists() and IMAGE_PATH.is_dir()


def test_for_image_filenames():
    # Arrange
    # Get the image file names in the image folder
    image_filenames = {file.name for file in IMAGE_PATH.glob('*.*')}
    # Get image file names referenced in the markdown files
    filename_regex = re.compile(r"images\/([\w]+\.[\w]+)")
    referenced_image_filenames = set()
    for file in SOURCE_PATH.glob('*.md'):
        with file.open() as f:
            referenced_image_filenames.update({fname for fname in filename_regex.findall(f.read())})

    # Assert
    # Neither set should be empty
    assert referenced_image_filenames
    assert image_filenames
    # For the docs to build all the referenced image files must be present
    assert referenced_image_filenames <= image_filenames, "Missing referenced images"
    # There should not be unreferenced image files
    assert image_filenames <= referenced_image_filenames, "Unreferenced image files present"


def test_for_markdown_files():
    # Arrange
    # Get the markdown file names in the source folder
    md_filenames = {file.name for file in SOURCE_PATH.glob('*.md')}
    # Get markdown file names referenced in the markdown files
    filename_regex = re.compile(r"[\w]+\.md")
    referenced_md_files = set()
    for file in SOURCE_PATH.glob('*.md'):
        with file.open() as f:
            referenced_md_files.update({fname for fname in filename_regex.findall(f.read())})

    # Assert
    # Neither set should be empty
    assert referenced_md_files
    assert md_filenames
    # There should be an index file
    assert INDEX_FILE_NAME in md_filenames
    # ...but it may not be referenced by any other file
    if INDEX_FILE_NAME not in referenced_md_files:
        md_filenames.discard(INDEX_FILE_NAME)
    # For the docs to build all the referenced markdown files must be present
    assert referenced_md_files <= md_filenames, "Missing referenced markdown files"
    # There should not be unreferenced markdown files
    assert md_filenames <= referenced_md_files, "Unreferenced markdown files present"
