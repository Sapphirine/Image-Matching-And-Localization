/*
* FILE: query.pig
* AUTHOR: Chris Stathis and Yongchen Jiang
* DESCRIPTION: Performs an image matching query on the descriptors listed
*               in "query.csv" against a database in "database.csv" and the corresponding 
*               bag-of-features database stored in the gt*.out folders. The output is a list
*               of image recommendations for a match and the number of features that were deemed
*               similar in the query.
*
* Copyright 2014 Chris Stathis and Yongchen Jiang
* 
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
* 
*    http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

set io.sort.mb 10;
f1 = LOAD './gt1.out/part-r-00000' using PigStorage('\t') as (group:int, featurebag:{feature:(FeatureID:int, ImageID:int, Hash:int)});
f2 = LOAD './gt2.out/part-r-00000' using PigStorage('\t') as (group:int, featurebag:{feature:(FeatureID:int, ImageID:int, Hash:int)});
f3 = LOAD './gt3.out/part-r-00000' using PigStorage('\t') as (group:int, featurebag:{feature:(FeatureID:int, ImageID:int, Hash:int)});
f4 = LOAD './gt4.out/part-r-00000' using PigStorage('\t') as (group:int, featurebag:{feature:(FeatureID:int, ImageID:int, Hash:int)});
f5 = LOAD './gt5.out/part-r-00000' using PigStorage('\t') as (group:int, featurebag:{feature:(FeatureID:int, ImageID:int, Hash:int)});
f6 = LOAD './gt6.out/part-r-00000' using PigStorage('\t') as (group:int, featurebag:{feature:(FeatureID:int, ImageID:int, Hash:int)});
f7 = LOAD './gt7.out/part-r-00000' using PigStorage('\t') as (group:int, featurebag:{feature:(FeatureID:int, ImageID:int, Hash:int)});
f8 = LOAD './gt8.out/part-r-00000' using PigStorage('\t') as (group:int, featurebag:{feature:(FeatureID:int, ImageID:int, Hash:int)});
f9 = LOAD './gt9.out/part-r-00000' using PigStorage('\t') as (group:int, featurebag:{feature:(FeatureID:int, ImageID:int, Hash:int)});
f10 = LOAD './gt10.out/part-r-00000' using PigStorage('\t') as (group:int, featurebag:{feature:(FeatureID:int, ImageID:int, Hash:int)});
f11 = LOAD './gt11.out/part-r-00000' using PigStorage('\t') as (group:int, featurebag:{feature:(FeatureID:int, ImageID:int, Hash:int)});
f12 = LOAD './gt12.out/part-r-00000' using PigStorage('\t') as (group:int, featurebag:{feature:(FeatureID:int, ImageID:int, Hash:int)});
f13 = LOAD './gt13.out/part-r-00000' using PigStorage('\t') as (group:int, featurebag:{feature:(FeatureID:int, ImageID:int, Hash:int)});
f14 = LOAD './gt14.out/part-r-00000' using PigStorage('\t') as (group:int, featurebag:{feature:(FeatureID:int, ImageID:int, Hash:int)});
f15 = LOAD './gt15.out/part-r-00000' using PigStorage('\t') as (group:int, featurebag:{feature:(FeatureID:int, ImageID:int, Hash:int)});
f16 = LOAD './gt16.out/part-r-00000' using PigStorage('\t') as (group:int, featurebag:{feature:(FeatureID:int, ImageID:int, Hash:int)});
f17 = LOAD './gt17.out/part-r-00000' using PigStorage('\t') as (group:int, featurebag:{feature:(FeatureID:int, ImageID:int, Hash:int)});
f18 = LOAD './gt18.out/part-r-00000' using PigStorage('\t') as (group:int, featurebag:{feature:(FeatureID:int, ImageID:int, Hash:int)});
f19 = LOAD './gt19.out/part-r-00000' using PigStorage('\t') as (group:int, featurebag:{feature:(FeatureID:int, ImageID:int, Hash:int)});
f20 = LOAD './gt20.out/part-r-00000' using PigStorage('\t') as (group:int, featurebag:{feature:(FeatureID:int, ImageID:int, Hash:int)});

master = LOAD './database.csv' USING PigStorage(',') as (FeatureID:int, ImageID:int, T1:int, T2:int, T3:int, T4:int, T5:int, T6:int, T7:int, T8:int, T9:int, T10:int, T11:int, T12:int, T13:int, T14:int, T15:int, T16:int, T17:int, T18:int, T19:int, T20:int);

queryall = LOAD './query.csv' USING PigStorage(',') as (FeatureID:int, ImageID:int, T1:int, T2:int, T3:int, T4:int, T5:int, T6:int, T7:int, T8:int, T9:int, T10:int, T11:int, T12:int, T13:int, T14:int, T15:int, T16:int, T17:int, T18:int, T19:int, T20:int);

q1 = foreach queryall generate FeatureID, ImageID, T1;
q2 = foreach queryall generate FeatureID, ImageID, T2;
q3 = foreach queryall generate FeatureID, ImageID, T3;
q4 = foreach queryall generate FeatureID, ImageID, T4;
q5 = foreach queryall generate FeatureID, ImageID, T5;
q6 = foreach queryall generate FeatureID, ImageID, T6;
q7 = foreach queryall generate FeatureID, ImageID, T7;
q8 = foreach queryall generate FeatureID, ImageID, T8;
q9 = foreach queryall generate FeatureID, ImageID, T9;
q10 = foreach queryall generate FeatureID, ImageID, T10;
q11 = foreach queryall generate FeatureID, ImageID, T11;
q12 = foreach queryall generate FeatureID, ImageID, T12;
q13 = foreach queryall generate FeatureID, ImageID, T13;
q14 = foreach queryall generate FeatureID, ImageID, T14;
q15 = foreach queryall generate FeatureID, ImageID, T15;
q16 = foreach queryall generate FeatureID, ImageID, T16;
q17 = foreach queryall generate FeatureID, ImageID, T17;
q18 = foreach queryall generate FeatureID, ImageID, T18;
q19 = foreach queryall generate FeatureID, ImageID, T19;
q20 = foreach queryall generate FeatureID, ImageID, T20;

t1 =  foreach master generate FeatureID, ImageID, T1;
g1 = join q1 by T1, f1 by group;
g1 = foreach g1 generate flatten(featurebag);
m1 = group g1 by ImageID;
m1 = foreach m1 generate group, COUNT(g1);
m1 = order m1 by $1 DESC;
m1 = LIMIT m1 1;

t2 =  foreach master generate FeatureID, ImageID, T2;
g2 = join q2 by T2, f2 by group;
g2 = foreach g2 generate flatten(featurebag);
m2 = group g2 by ImageID;
m2 = foreach m2 generate group, COUNT(g2);
m2 = order m2 by $1 DESC;
m2 = LIMIT m2 1;

t3 =  foreach master generate FeatureID, ImageID, T3;
g3 = join q3 by T3, f3 by group;
g3 = foreach g3 generate flatten(featurebag);
m3 = group g3 by ImageID;
m3 = foreach m3 generate group, COUNT(g3);
m3 = order m3 by $1 DESC;
m3 = LIMIT m3 1;

t4 =  foreach master generate FeatureID, ImageID, T4;
g4 = join q4 by T4, f4 by group;
g4 = foreach g4 generate flatten(featurebag);
m4 = group g4 by ImageID;
m4 = foreach m4 generate group, COUNT(g4);
m4 = order m4 by $1 DESC;
m4 = LIMIT m4 1;

t5 =  foreach master generate FeatureID, ImageID, T5;
g5 = join q5 by T5, f5 by group;
g5 = foreach g5 generate flatten(featurebag);
m5 = group g5 by ImageID;
m5 = foreach m5 generate group, COUNT(g5);
m5 = order m5 by $1 DESC;
m5 = LIMIT m5 1;

t6 =  foreach master generate FeatureID, ImageID, T6;
g6 = join q6 by T6, f6 by group;
g6 = foreach g6 generate flatten(featurebag);
m6 = group g6 by ImageID;
m6 = foreach m6 generate group, COUNT(g6);
m6 = order m6 by $1 DESC;
m6 = LIMIT m6 1;

t7 =  foreach master generate FeatureID, ImageID, T7;
g7 = join q7 by T7, f7 by group;
g7 = foreach g7 generate flatten(featurebag);
m7 = group g7 by ImageID;
m7 = foreach m7 generate group, COUNT(g7);
m7 = order m7 by $1 DESC;
m7 = LIMIT m7 1;

t8 =  foreach master generate FeatureID, ImageID, T8;
g8 = join q8 by T8, f8 by group;
g8 = foreach g8 generate flatten(featurebag);
m8 = group g8 by ImageID;
m8 = foreach m8 generate group, COUNT(g8);
m8 = order m8 by $1 DESC;
m8 = LIMIT m8 1;

t9 =  foreach master generate FeatureID, ImageID, T9;
g9 = join q9 by T9, f9 by group;
g9 = foreach g9 generate flatten(featurebag);
m9 = group g9 by ImageID;
m9 = foreach m9 generate group, COUNT(g9);
m9 = order m9 by $1 DESC;
m9 = LIMIT m9 1;

t10 =  foreach master generate FeatureID, ImageID, T10;
g10 = join q10 by T10, f10 by group;
g10 = foreach g10 generate flatten(featurebag);
m10 = group g10 by ImageID;
m10 = foreach m10 generate group, COUNT(g10);
m10 = order m10 by $1 DESC;
m10 = LIMIT m10 1;

t11 =  foreach master generate FeatureID, ImageID, T11;
g11 = join q11 by T11, f11 by group;
g11 = foreach g11 generate flatten(featurebag);
m11 = group g11 by ImageID;
m11 = foreach m11 generate group, COUNT(g11);
m11 = order m11 by $1 DESC;
m11 = LIMIT m11 1;

t12 =  foreach master generate FeatureID, ImageID, T12;
g12 = join q12 by T12, f12 by group;
g12 = foreach g12 generate flatten(featurebag);
m12 = group g12 by ImageID;
m12 = foreach m12 generate group, COUNT(g12);
m12 = order m12 by $1 DESC;
m12 = LIMIT m12 1;

t13 =  foreach master generate FeatureID, ImageID, T13;
g13 = join q13 by T13, f13 by group;
g13 = foreach g13 generate flatten(featurebag);
m13 = group g13 by ImageID;
m13 = foreach m13 generate group, COUNT(g13);
m13 = order m13 by $1 DESC;
m13 = LIMIT m13 1;

t14 =  foreach master generate FeatureID, ImageID, T14;
g14 = join q14 by T14, f14 by group;
g14 = foreach g14 generate flatten(featurebag);
m14 = group g14 by ImageID;
m14 = foreach m14 generate group, COUNT(g14);
m14 = order m14 by $1 DESC;
m14 = LIMIT m14 1;

t15 =  foreach master generate FeatureID, ImageID, T15;
g15 = join q15 by T15, f15 by group;
g15 = foreach g15 generate flatten(featurebag);
m15 = group g15 by ImageID;
m15 = foreach m15 generate group, COUNT(g15);
m15 = order m15 by $1 DESC;
m15 = LIMIT m15 1;

t16 =  foreach master generate FeatureID, ImageID, T16;
g16 = join q16 by T16, f16 by group;
g16 = foreach g16 generate flatten(featurebag);
m16 = group g16 by ImageID;
m16 = foreach m16 generate group, COUNT(g16);
m16 = order m16 by $1 DESC;
m16 = LIMIT m16 1;

t17 =  foreach master generate FeatureID, ImageID, T17;
g17 = join q17 by T17, f17 by group;
g17 = foreach g17 generate flatten(featurebag);
m17 = group g17 by ImageID;
m17 = foreach m17 generate group, COUNT(g17);
m17 = order m17 by $1 DESC;
m17 = LIMIT m17 1;

t18 =  foreach master generate FeatureID, ImageID, T18;
g18 = join q18 by T18, f18 by group;
g18 = foreach g18 generate flatten(featurebag);
m18 = group g18 by ImageID;
m18 = foreach m18 generate group, COUNT(g18);
m18 = order m18 by $1 DESC;
m18 = LIMIT m18 1;

t19 =  foreach master generate FeatureID, ImageID, T19;
g19 = join q19 by T19, f19 by group;
g19 = foreach g19 generate flatten(featurebag);
m19 = group g19 by ImageID;
m19 = foreach m19 generate group, COUNT(g19);
m19 = order m19 by $1 DESC;
m19 = LIMIT m19 1;

t20 =  foreach master generate FeatureID, ImageID, T20;
g20 = join q20 by T20, f20 by group;
g20 = foreach g20 generate flatten(featurebag);
m20 = group g20 by ImageID;
m20 = foreach m20 generate group, COUNT(g20);
m20 = order m20 by $1 DESC;
m20 = LIMIT m20 1;

m = UNION m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15, m16, m17, m18, m19, m20;

DUMP m;
