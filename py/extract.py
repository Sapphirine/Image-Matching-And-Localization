# FILE: extract.py
# AUTHOR: Chris Stathis and Yongchen Jiang
# DESCRIPTION: Iterates through a directory of images and OpenCV and our 
#              custom Locality-Sensitive Hashing implementation to produce
#              a set of image feature descriptors and associated hash values
#              for each image. The results are written to a database file.
#              Another CSV file is also created that maps ImageIDs to filenames.
#
# Copyright 2014 Chris Stathis and Yongchen Jiang
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import os       # for file processing
import lsh      # our custom locality-sensitive hashing module
import numpy    # for dependencies
import cv2      # for image feature extraction

rootdir = "./cropped/"

# initialize OpenCV ORB
orb = cv2.ORB()

f = open('database.csv', 'w')
f2 = open('files.csv', 'w')
featureID = 0
imageID = 0
NUMBER_OF_TABLES = 20
totalDescriptors = 0

# Recursively iterate through the root directory
for subdir, dirs, files in os.walk(rootdir):
    for file in files:
        filename = os.path.join(subdir, file)

        # write out the filename and imageID pair
        f2.write("%u, %s,\n" % (imageID, filename));
        print filename
        
        # load the image file
        img = cv2.imread(filename, 0)

        # extract the keypoints
        kp = orb.detect(img, None)

        # compute the descriptors for the keypoints and store in a matrix
        kp, des = orb.compute(img, kp)
        
        # get the number of descriptors returned (number of rows)
        numDescriptors = des.shape[0]

        # keep track of the total number of descriptors processed
        totalDescriptors = totalDescriptors + numDescriptors

        # LSH requires access to a contiguous array for matrix processing
        contig = numpy.ascontiguousarray(des, dtype=numpy.uint8)

        # generate the hash values for all features in the descriptor matrix
        hashes = lsh.hash(contig)

        cnt = 0
        # for each descriptor
        for descriptor in xrange(0, numDescriptors):
            # write out the FeatureID and ImageID
            f.write("%u, %u, " % (featureID, imageID)) 
            # for each hash table
            for hash in xrange(0, NUMBER_OF_TABLES):
                # write out hash value for this image in this hash tab;e
                f.write("%u, " % (hashes[cnt]))
                cnt = cnt + 1
            f.write("\n")
            featureID = featureID + 1    
        imageID = imageID + 1

print "Wrote %u descriptor records\n" % (totalDescriptors)
f2.close();
f.close()
