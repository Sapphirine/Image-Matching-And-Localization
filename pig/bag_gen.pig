/*
* FILE: bag_gen.pig 
* AUTHOR: Chris Stathis
* DESCRIPTION: Given a database of features represented as:
*
* FeatureID, ImageID, Hash1, Hash2, Hash3, ...
*
* generates a table for each Hash column of the form:
*
* (hash: int, features: {(FeatureID, ImageID, Hash), (FeatureID, ... )})
*
* Copyright 2014 Chris Stathis
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
-- Load the database
master = LOAD './database.csv' USING PigStorage(',') as (FeatureID:int, ImageID:int, T1:int, T2:int, T3:int, T4:int, T5:int, T6:int, T7:int, T8:int, T9:int, T10:int, T11:int, T12:int, T13:int, T14:int, T15:int, T16:int, T17:int, T18:int, T19:int, T20:int);

-- Make individual hash tables
t1 = foreach master generate FeatureID,ImageID,T1;
t2 = foreach master generate FeatureID,ImageID,T2;
t3 = foreach master generate FeatureID,ImageID,T3;
t4 = foreach master generate FeatureID,ImageID,T4;
t5 = foreach master generate FeatureID,ImageID,T5;
t6 = foreach master generate FeatureID,ImageID,T6;
t7 = foreach master generate FeatureID,ImageID,T7;
t8 = foreach master generate FeatureID,ImageID,T8;
t9 = foreach master generate FeatureID,ImageID,T9;
t10 = foreach master generate FeatureID,ImageID,T10;
t11 = foreach master generate FeatureID,ImageID,T11;
t12 = foreach master generate FeatureID,ImageID,T12;
t13 = foreach master generate FeatureID,ImageID,T13;
t14 = foreach master generate FeatureID,ImageID,T14;
t15 = foreach master generate FeatureID,ImageID,T15;
t16 = foreach master generate FeatureID,ImageID,T16;
t17 = foreach master generate FeatureID,ImageID,T17;
t18 = foreach master generate FeatureID,ImageID,T18;
t19 = foreach master generate FeatureID,ImageID,T19;
t20 = foreach master generate FeatureID,ImageID,T20;

-- Group by hashes
gt1 = group t1 by T1;
gt2 = group t2 by T2;
gt3 = group t3 by T3;
gt4 = group t4 by T4;
gt5 = group t5 by T5;
gt6 = group t6 by T6;
gt7 = group t7 by T7;
gt8 = group t8 by T8;
gt9 = group t9 by T9;
gt10 = group t10 by T10;
gt11 = group t11 by T11;
gt12 = group t12 by T12;
gt13 = group t13 by T13;
gt14 = group t14 by T14;
gt15 = group t15 by T15;
gt16 = group t16 by T16;
gt17 = group t17 by T17;
gt18 = group t18 by T18;
gt19 = group t19 by T19;
gt20 = group t20 by T20;

store gt1 into 'gt1.out';
store gt2 into 'gt2.out';
store gt3 into 'gt3.out';
store gt4 into 'gt4.out';
store gt5 into 'gt5.out';
store gt6 into 'gt6.out';
store gt7 into 'gt7.out';
store gt8 into 'gt8.out';
store gt9 into 'gt9.out';
store gt10 into 'gt10.out';
store gt11 into 'gt11.out';
store gt12 into 'gt12.out';
store gt13 into 'gt13.out';
store gt14 into 'gt14.out';
store gt15 into 'gt15.out';
store gt16 into 'gt16.out';
store gt17 into 'gt17.out';
store gt18 into 'gt18.out';
store gt19 into 'gt19.out';
store gt20 into 'gt20.out';

