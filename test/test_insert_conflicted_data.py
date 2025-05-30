"""
Tests for insert_conflicted_data.py
"""
from pathlib import Path
import sqlite3

import etlhelper as etl
import pytest

from bin.insert_conflicted_data import insert_conflicted_data
from conftest import setup_db_conn


NEW_SRC_DATA_SQL = """
INSERT INTO locality_point VALUES(10,'{159c6095-d9c2-432f-b8d1-ac9bb7700067}','{85d48fd4-e66f-4436-833b-9e37691a7d4f}','kwhi_001','outcrop','Foreshore south of Gourdon',NULL,'Coarse boulder conglomerate, locally minor cross-bedded sandstone lenses. General fracturing marked by fractured boulders and small gullies along trend of 060-070 and 020-030 sub vertical, but no clear fault rock seen. No evidence for significant fault as mapped on 50k.','kwhi','2025-05-19T09:40:47.477Z',X'47500001e610000001e9030000f4bae9c68d5a02c0bfa8c3ed15694c400000000000000000');
INSERT INTO locality_point VALUES(20,'{327daf34-9345-440c-97aa-c5034711575e}','{85d48fd4-e66f-4436-833b-9e37691a7d4f}','kwhi_002','outcrop','Foreshore south of Gourdon',NULL,'Interbedded coarse boulder conglomerate and pebbly coarse sandstone.','kwhi','2025-05-19T11:16:13.138Z',X'47500001e610000001e9030000cd20ccd3655e02c0f69d3c78ad684c400000000000000000');
INSERT INTO bedrock_line VALUES(108,'{5db180d2-e3d1-4d3c-a0de-5eeb52189228}','{85d48fd4-e66f-4436-833b-9e37691a7d4f}','fault_throw_unknown_obs',NULL,'river cut into planar bedrock feature, heavily fractured and veins parallel to fault. offset unknown.',10000,'treevesBGS','2025-05-24T11:16:49.763Z',X'47500003e6100000b64ebc36c8360ac0cde5068943340ac0251e1f6a69514c40bc5c0f7878514c40010200000002000000b64ebc36c8360ac0251e1f6a69514c40cde5068943340ac0bc5c0f7878514c40');
INSERT INTO terrain_line VALUES(13,'{a3338496-8824-4e2a-8621-33b0be771fea}','{85d48fd4-e66f-4436-833b-9e37691a7d4f}','linear_negative_feature',NULL,NULL,10000,'kwhi','2025-05-23T09:17:59.655Z',X'47500003e610000044c5f94007540ac0599688cca84c0ac0f1073c6c4f574c40e8888c1d63574c40010200000006000000599688cca84c0ac0cd5c288a5e574c408f43b49cff4e0ac0e8888c1d63574c4032cf43f4c2500ac0ddafb0d461574c40412eadc506520ac0cb7d1fff5b574c4028537e46bb520ac041e0cbe857574c4044c5f94007540ac0f1073c6c4f574c40');
INSERT INTO sample VALUES(22,'{fa8ffecc-1a01-4c94-b1b6-42d15223ecb2}','{159c6095-d9c2-432f-b8d1-ac9bb7700067}','TR250523_06','rock',NULL,'treevesBGS','2025-05-23T16:25:06.674Z');
INSERT INTO sample VALUES(23,'{f9e9b7cf-e9e4-4e31-b4cf-3d8450cf2c86}','{159c6095-d9c2-432f-b8d1-ac9bb7700067}','TH250524_01','rock','overlying volcanic unit.','treevesBGS','2025-05-24T12:26:07.397Z');
INSERT INTO lithology VALUES(40,'{f7e4dc32-5f89-463f-9fd0-f1e30b489628}','{159c6095-d9c2-432f-b8d1-ac9bb7700067}','FBRC',NULL,'treevesBGS','2025-05-21T12:36:42.797Z');
INSERT INTO structural_measurement VALUES(141,'{2bbd0455-240c-42fa-a604-9853f4ae1242}','{159c6095-d9c2-432f-b8d1-ac9bb7700067}','fault_plane_inclined',72.0,355.0,NULL,NULL,'fault 1m long, bends slightly (convex southward). measured in riverbed','treevesBGS','2025-05-24T12:02:23.970Z');
"""  # noqa
NEW_DEST_DATA_SQL = """
INSERT INTO locality_point VALUES(59,'{26e2ce60-b6b0-4b4a-b3dd-b7954f80fc27}','{85d48fd4-e66f-4436-833b-9e37691a7d4f}','kwhi_019','outcrop',NULL,NULL,'conglomerate, rare sst beds','kwhi','2025-05-19T14:22:30.478Z',X'47500001e610000001e9030000c650f8f6866b02c05468fa4cd1674c400000000000000000');
INSERT INTO locality_point VALUES(60,'{71be5ca3-7c23-4e9b-9393-997482a8d24a}','{85d48fd4-e66f-4436-833b-9e37691a7d4f}','kwhi_020','outcrop',NULL,NULL,'cong + rare sst','kwhi','2025-05-19T14:33:02.520Z',X'47500001e610000001e903000098c15bee3b6d02c05b436797d0674c400000000000000000');
INSERT INTO bedrock_line VALUES(18,'{2d98a7a0-8d76-4c4e-91da-a056872fe1cb}','{85d48fd4-e66f-4436-833b-9e37691a7d4f}','fault_reverse_inf',NULL,'HBF?',10000,'taras@bgs.ac.uk','2025-05-19T15:55:25.438Z',X'47500003e61000005d484dc8926908c0e0678c01546508c02e97233fdd5a4c407d63f06ce95a4c400102000000020000005d484dc8926908c02e97233fdd5a4c40e0678c01546508c07d63f06ce95a4c40');
INSERT INTO structural_measurement VALUES(30,'{5368a568-080b-4a0c-bd1d-97add1546118}','26e2ce60-b6b0-4b4a-b3dd-b7954f80fc27','fault_plane_inclined',72.0,96.0,NULL,NULL,'Edge of resistant ridge of conglomerate','kwhi','2025-05-19T11:47:45.469Z');
"""  # noqa


def test_insert_conflicted_data_happy_path(project_dir: Path,
                                           test_data_gpkg: sqlite3.Connection):
    # Arrange
    src, dest = _prepare_test_databases(project_dir, test_data_gpkg)

    # Act
    insert_conflicted_data(src, dest)

    # Assert
    expected_row_counts = {
        "locality_point": 6,
        "sample": 4,
        "lithology": 4,
        "structural_measurement": 4,
        "bedrock_line": 3,
        "terrain_line": 2,
    }
    with setup_db_conn(dest) as conn:
        for table, expected_row_count in expected_row_counts.items():
            rows = etl.fetchall(f"SELECT fid FROM {table}", conn)
            assert len(rows) == expected_row_count

    # Ensure backup database is cleaned up
    assert len(list(dest.parent.glob("*backup"))) == 0


def test_insert_conflicted_data_duplicate_locality_id(project_dir: Path,
                                                      test_data_gpkg: sqlite3.Connection):
    # Arrange - create two non-empty gpkg files, then add different data to each
    # Alter destination so that locality point name clashes with source
    src, dest = _prepare_test_databases(project_dir, test_data_gpkg)
    with setup_db_conn(dest) as conn:
        etl.execute("UPDATE locality_point SET name = 'kwhi_001' WHERE name = 'kwhi_020'",
                    conn)
    original_dest_data = dest.read_bytes()

    # Act
    with pytest.raises(Exception, match="UNIQUE constraint failed: locality_point.name"):
        insert_conflicted_data(src, dest)

    # Ensure original database is unchanged and backup is removed
    assert dest.read_bytes() == original_dest_data
    assert len(list(dest.parent.glob("*backup"))) == 0


def _prepare_test_databases(project_dir: Path,
                            test_data_gpkg: sqlite3.Connection) -> tuple[Path, Path]:
    # Create two non-empty gpkg files based on test data then add different
    # additional data to each.
    test_data_gpkg.close()  # Close test data connection
    src = project_dir / "test_project.gpkg"  # Hard coded in conftest
    dest = project_dir / "destination_project.gpkg"
    dest.write_bytes(src.read_bytes())
    with setup_db_conn(src) as src_conn:
        src_conn.executescript(NEW_SRC_DATA_SQL)
    with setup_db_conn(dest) as dest_conn:
        dest_conn.executescript(NEW_DEST_DATA_SQL)
    return src, dest
