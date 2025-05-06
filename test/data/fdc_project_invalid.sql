/*
This script inserts test data that are deliberately broken.  This includes foreign key
violations.  This is possible because you need to set PRAGMA FOREIGN_KEYS = ON to
enforce them.
*/
BEGIN TRANSACTION;
INSERT INTO "field_project" VALUES (1,'{3a68b7c7-e3a9-4a35-8dd2-00d31c515244}','leos_test_project','Leo''s Test Project','A project to be used in tests for project validation','Leo','2024-07-30','2024-08-01',27700,'These are some empty notes honk',50000,'leorud','2024-07-30T13:29:57.099',NULL,X'47500003e6100000b79e0eba8bf2f2bf74409b25669bf1bf2ceb304a18774a4077287a34237b4a4001030000000100000007000000c3440d41856ef2bf77287a34237b4a40b79e0eba8bf2f2bfe3b8bbdb7b784a40cc0a53cf9ca7f2bf2ceb304a18774a405a50285c45c0f1bf28728a4385774a4074409b25669bf1bf24e4f4bb017a4a40e0a4dc0617ebf1bfd53002250f7b4a40c3440d41856ef2bf77287a34237b4a40');
INSERT INTO "locality_point" VALUES (1,'{b41f8f98-6cc8-40f1-acfe-d5102714db18}','{3a68b7c7-e3a9-4a35-8dd2-00d31c515244}','leorudczenko_001','other','Some ducks','ducks','They quack','leorud','2024-07-30T13:31:38.730',X'47500001e610000001e90300007a1385b1395ff2bfe2e2e64756794a400000000000000000');
INSERT INTO "locality_point" VALUES (2,'{5967418c-ca0e-466e-b21a-2d826500e5cf}','{not-a-valid-field_project_fuid}','leorudczenko_002','other','Some geese','geese','They honk','leorud','2024-07-30T13:32:03.196',X'47500001e610000001e903000090d8becd2063f2bf40b46c8851794a400000000000000000');
INSERT INTO "lithology" VALUES (1,'{1fe7ea1e-f57c-4a52-9818-e531664c0728}','{b41f8f98-6cc8-40f1-acfe-d5102714db18}','RY',NULL,'leorud','2024-07-30T13:32:28.706');
INSERT INTO "lithology" VALUES (2,'{f9adb006-edb7-402b-b1ff-03128dbacc38}','{5967418c-ca0e-466e-b21a-2d826500e5cf}','BA',NULL,'leorud','2024-07-30T13:32:53.647');
INSERT INTO "media" VALUES(1,'{ac267d95-db70-4299-b019-c52599ca1e5f}','{not-a-valid-locality_point_fuid}','video','file_does_no_exist.mov','Media with invalid locality_point parent','leorud','2024-07-30T13:34:39.807');
INSERT INTO "photo" VALUES (1,'{70d7ed67-97ab-41ca-867d-a3865fcd94bc}','{5967418c-ca0e-466e-b21a-2d826500e5cf}','sub_dir/exif_data.jpg','This is not a goose','leorud','2024-07-30T13:34:39.776');
INSERT INTO "photo" VALUES (2,'{1ad55965-8412-4140-92d2-e8bc8f514e6f}','{b41f8f98-6cc8-40f1-acfe-d5102714db18}','file_does_no_exist.jpg','This is not a duck','leorud','2024-07-30T13:34:39.807');
INSERT INTO "photo" VALUES (3,'{3ad55965-8412-4140-92d2-e8bc8f514e6f}','{b41f8f98-6cc8-40f1-acfe-d5102714db18}',NULL,'This is not a goose or a duck','leorud','2024-07-30T13:34:39.807');
INSERT INTO "sample" VALUES(1,'{257275a9-c2f3-4ef8-9272-bde172a828d8}','{not-a-valid-locality_point_fuid}','sample_001','tephra','Sample with invalid locality_point parent','leorud','2024-07-30T13:34:39.807');
INSERT INTO "artificial_line" VALUES (1,'{704a49e7-5542-46a7-ba11-47262b612abf}','{3a68b7c7-e3a9-4a35-8dd2-00d31c515244}','limit_subsurface_mining','canal','This is a canal with ducks and geese',50000,'leorud','2024-07-30T13:33:11.831',X'47500003e6100000a846f88a8665f2bfad198e1b335df2bf9bbe387550794a40884e921258794a40010200000005000000a846f88a8665f2bf4dbd05ba50794a401c81db711364f2bf9bbe387550794a409da426a4ea60f2bf29915cf752794a40c74dc7ee975ef2bfcf1e916255794a40ad198e1b335df2bf884e921258794a40');
INSERT INTO "bedrock_line" VALUES (1,'{704a49e7-5542-46a7-ba11-47262b612abf}','{not-a-valid-field_project_fuid}','algal_band','canal','This is another canal with ducks and geese',50000,'leorud','2024-07-30T13:33:11.831',X'47500003e6100000f4d3e84bec45f1bfb21eccaf9f42f1bf4e4170a379704a40c76ae39e7d704a40010200000005000000f4d3e84bec45f1bfc76ae39e7d704a40693cb3fb1c45f1bf34eeae287b704a40dda47dab4d44f1bf4e4170a379704a40b425033b9943f1bf5856f9b579704a40b21eccaf9f42f1bf9bb213f17a704a40');
COMMIT;
