# file: query.py
# author: chris stathis and yongchen jiang
# description: iterates through a directory of query images and invokes opencv and our 
#              custom locality-sensitive hashing implementation to produce
#              a set of image feature descriptors and associated hash values
#              for each image.
#
# copyright 2014 chris stathis and yongchen jiang
#
# licensed under the apache license, version 2.0 (the "license");
# you may not use this file except in compliance with the license.
# you may obtain a copy of the license at
#
#     http://www.apache.org/licenses/license-2.0
#
# unless required by applicable law or agreed to in writing, software
# distributed under the license is distributed on an "as is" basis,
# without warranties or conditions of any kind, either express or implied.
# see the license for the specific language governing permissions and
# limitations under the license.
import os
import lsh
import numpy
import cv2

rootdir = "./query/"
orb = cv2.ORB()

f = open('query.csv', 'w')

featureID = 0
imageID = 0
NUMBER_OF_TABLES = 20
totalDescriptors = 0

for subdir, dirs, files in os.walk(rootdir):
    for file in files:
        filename = os.path.join(subdir, file)
        print filename
        img = cv2.imread(filename, 0)
        kp = orb.detect(img, None)
        kp, des = orb.compute(img, kp)
        
        numDescriptors = des.shape[0]
        totalDescriptors = totalDescriptors + numDescriptors
        contig = numpy.ascontiguousarray(des, dtype=numpy.uint8)
        hashes = lsh.hash(contig)

        # for each descriptor, get the 20 hash values
        cnt = 0
        for descriptor in xrange(0, numDescriptors):
            f.write("%u, %u, " % (featureID, imageID)) 
            for hash in xrange(0, NUMBER_OF_TABLES):
                f.write("%u, " % (hashes[cnt]))
                cnt = cnt + 1
            f.write("\n")
            featureID = featureID + 1    
        imageID = imageID + 1

print "Wrote %u descriptor records\n" % (totalDescriptors)

f.close()
