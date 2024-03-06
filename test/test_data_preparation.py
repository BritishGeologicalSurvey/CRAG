import pytest

from data_preparation_scripts.prepare_dic_rock_etc import transform_inspire_to_cgi


@pytest.mark.parametrize(
    ["row", "expected_row"],
    [
        (
            {"inspire_lithology_uri": "http://inspire.ec.europa.eu/codelist/LithologyValue/dolomite"},
            {"cgi_lithology_uri": "http://resource.geosciml.org/classifier/cgi/lithology/dolostone"},
        ),
        (
            {"inspire_lithology_uri": "http://inspire.ec.europa.eu/codelist/LithologyValue/gypsumOrAnhydrite"},
            {"cgi_lithology_uri": "http://resource.geosciml.org/classifier/cgi/lithology/rock_gypsum_or_anhydrite"},
        ),
        (
            {"inspire_lithology_uri": "http://inspire.ec.europa.eu/codelist/LithologyValue/phonolilte"},
            {"cgi_lithology_uri": "http://resource.geosciml.org/classifier/cgi/lithology/phonolite"},
        ),
        (
            {"inspire_lithology_uri": "http://inspire.ec.europa.eu/codelist/LithologyValue/conglomerate"},
            {"cgi_lithology_uri": "http://resource.geosciml.org/classifier/cgi/lithology/clastic_conglomerate"},
        ),
        (
            {"inspire_lithology_uri": "http://inspire.ec.europa.eu/codelist/LithologyValue/ashTuffLapillistoneAndLapilliTuff"},  # noqa
            {"cgi_lithology_uri": "http://resource.geosciml.org/classifier/cgi/lithology/ash_tuff_lapillistone_and_lapilli_tuff"},  # noqa
        ),
    ]
)
def test_transform_inspire_to_cgi(
    row: dict[str, str],
    expected_row: dict[str, str],
):
    # Arrange
    # Put the given row into a list so it acts like a chunk
    chunk = [row]

    # Act
    transformed_row = next(transform_inspire_to_cgi(chunk))

    # Assert
    assert expected_row == transformed_row
