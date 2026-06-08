/*
Copyright 2026 British Geological Survey
Licensed under GPLv3 licence
SPDX-License-Identifier: GPL-3.0-or-later
*/
BEGIN TRANSACTION;
INSERT INTO "field_project" VALUES (1,'{3a68b7c7-e3a9-4a35-8dd2-00d31c515244}','dest_crag_project','Destination Test Project','A project to be used in tests for merging 2 projects','test_user','2024-06-11','2024-06-12',27700,'These are some empty notes honk',50000,'user_a','2024-06-11T11:29:57.099','local_development',X'47500003e6100000b79e0eba8bf2f2bf74409b25669bf1bf2ceb304a18774a4077287a34237b4a4001030000000100000007000000c3440d41856ef2bf77287a34237b4a40b79e0eba8bf2f2bfe3b8bbdb7b784a40cc0a53cf9ca7f2bf2ceb304a18774a405a50285c45c0f1bf28728a4385774a4074409b25669bf1bf24e4f4bb017a4a40e0a4dc0617ebf1bfd53002250f7b4a40c3440d41856ef2bf77287a34237b4a40');
INSERT INTO "locality_point" VALUES (1,'{b41f8f98-6cc8-40f1-acfe-d5102714db18}','{3a68b7c7-e3a9-4a35-8dd2-00d31c515244}','user_a_001','other','Some ducks','ducks','They quack','user_a','2024-06-11T11:31:38.730',X'47500001e610000001e90300007a1385b1395ff2bfe2e2e64756794a400000000000000000');
INSERT INTO "locality_point" VALUES (2,'{5967418c-ca0e-466e-b21a-2d826500e5cf}','{3a68b7c7-e3a9-4a35-8dd2-00d31c515244}','user_a_002','other','Some geese','geese','They honk','user_a','2024-06-11T11:32:03.196',X'47500001e610000001e903000090d8becd2063f2bf40b46c8851794a400000000000000000');
INSERT INTO "lithology" VALUES (1,'{1fe7ea1e-f57c-4a52-9818-e531664c0728}','{b41f8f98-6cc8-40f1-acfe-d5102714db18}','RY',NULL,'user_a','2024-06-11T11:32:28.706');
INSERT INTO "lithology" VALUES (2,'{f9adb006-edb7-402b-b1ff-03128dbacc38}','{5967418c-ca0e-466e-b21a-2d826500e5cf}','BA',NULL,'user_a','2024-06-11T11:32:53.647');
INSERT INTO "photo" VALUES (1,'{70d7ed67-97ab-41ca-867d-a3865fcd94bc}','{5967418c-ca0e-466e-b21a-2d826500e5cf}','exif_data.jpg','This is not a goose (caption)','This is not a goose (description)','user_a','2024-06-11T11:34:39.776');
INSERT INTO "photo" VALUES (2,'{1ad55965-8412-4140-92d2-e8bc8f514e6f}','{b41f8f98-6cc8-40f1-acfe-d5102714db18}','no_exif_data.jpg','This is not a duck (caption)','This is not a duck (description)','user_a','2024-06-11T11:34:39.807');
INSERT INTO "artificial_line" VALUES (1,'{704a49e7-5542-46a7-ba11-47262b612abf}','{3a68b7c7-e3a9-4a35-8dd2-00d31c515244}','limit_subsurface_mining','canal','This is a canal with ducks and geese',50000,'user_a','2024-06-11T11:33:11.831',X'47500003e6100000a846f88a8665f2bfad198e1b335df2bf9bbe387550794a40884e921258794a40010200000005000000a846f88a8665f2bf4dbd05ba50794a401c81db711364f2bf9bbe387550794a409da426a4ea60f2bf29915cf752794a40c74dc7ee975ef2bfcf1e916255794a40ad198e1b335df2bf884e921258794a40');
COMMIT;
