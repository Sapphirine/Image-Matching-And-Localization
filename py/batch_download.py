#------------------------------------------------------------------------------
# FILE: batch_download.py
# AUTHOR: Chris Stathis
# DESCRIPTION: CURL-based file downloader. Designed to download all images 
#              from a list of URLs corresponding to Google StreetView API calls
#
# Copyright 2014, Chris Stathis
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#------------------------------------------------------------------------------ 
import pycurl   # for invoking CURL
import csv      # for reading the CSV file of URLs
import time     # for throttling, to avoid API overruns

with open('pts.txt') as csvfile:
    data = list(csv.reader(csvfile, delimiter=' '))

count = 0;

# for each URL in the file...
for row in data:
    count = count+1
    # construct an appropriate file name for the image
    fname = str(str(count) + ".jpg")

    with open(fname, 'wb') as f:
        # initialize PyCURL
        c = pycurl.Curl();
    
        # set the URL to the field in this row
        c.setopt(c.URL, row[4])

        # write the result out to f
        c.setopt(c.WRITEDATA, f)

        # execute the API call
        c.perform()

        # close PyCURL descriptor and image file 
        c.close()
        f.close()
    
    print str(str(count) + "...\n")

    # sleep for 5 seconds
    time.sleep(5);

csvfile.close()
