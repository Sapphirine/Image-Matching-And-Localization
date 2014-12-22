/*
* FILE: lshmodule.cpp 
* AUTHOR: Chris Stathis
* DESCRIPTION: Implementation of Locality-Sensitive Hashing for the Hamming
*              distance as a Python module. The Python-available function
*              hash() operates on a matrix whose rows represent image descriptors.
*              This function produces a row of N hash values for N LSH tables.
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

#include <Python.h>
#include <numpy/arrayobject.h>
#include <numpy/ndarraytypes.h>
#include <vector>
#include <iostream>
#include <stdint.h>
#include <cstddef>
#include <random>
#include <algorithm>

#define NUMBER_OF_TABLES     20
#define SIG_WIDTH            20 // bits
#define FEATURE_SIZE         32 // bytes

// LSH table definition
typedef struct {
    unsigned int feature_size;
    unsigned int subsignature_size;
    std::vector<size_t> indices;
    std::vector<size_t> mask;
} table_desc_t;

// Internal data
static std::vector<table_desc_t> tables;

// API function prototypes
static PyObject * hash(PyObject * self, PyObject * args);

// Python bindings
static PyObject * lsh_error;
static PyMethodDef lsh_methods[] = {
    {"hash", hash, METH_VARARGS, "Hasher"},
    {NULL, NULL, 0, NULL}
    };

// Private function prototypes
size_t get_key(unsigned int table_num, const unsigned char * feature);

PyMODINIT_FUNC initlsh(void)
{
    // Initialize python bindings
	PyObject * m = Py_InitModule("lsh", lsh_methods);
    if(m == NULL) return;

    import_array();

    // initialize tables
    tables = std::vector<table_desc_t>(NUMBER_OF_TABLES);
    unsigned int feature_size = FEATURE_SIZE;
    unsigned int subsignature_size = SIG_WIDTH;
   
    // for each table... 
    for(unsigned int i = 0; i < NUMBER_OF_TABLES; ++i)
    {
        // initialize properties
        tables[i].feature_size = feature_size;
        tables[i].subsignature_size = subsignature_size;
        tables[i].indices.resize(feature_size * CHAR_BIT);
        
        // generate a random array whose size is equal to the number of bits
        // in a feature
        for(size_t j = 0; j < feature_size * CHAR_BIT; ++j)
        {
            tables[i].indices[j] = j;
        }
        std::random_shuffle(tables[i].indices.begin(), tables[i].indices.end()); 
        
        // initialize mask
        tables[i].mask = std::vector<size_t>( (size_t) ceil((float)(feature_size) / (float)sizeof(size_t)), 0);
        
        // for each element in this bitmask...
        for(unsigned int j = 0; j < subsignature_size; ++j)
        {
            // pop off the front of our random list of bit positions
            size_t index = tables[i].indices[0];
            tables[i].indices.erase(tables[i].indices.begin());

            // mask that bit in the mask
            size_t divisor = CHAR_BIT * sizeof(size_t);
            size_t idx = index / divisor;
            tables[i].mask[idx] |= size_t(1) << (index % divisor);
        }
    }

    // Python Exceptions
    lsh_error = PyErr_NewException("lsh.error", NULL, NULL);
    Py_INCREF(lsh_error);
    PyModule_AddObject(m, "error", lsh_error);
}

static PyObject * hash(PyObject * self, PyObject * args)
{
    PyArrayObject * desc;
    PyObject * out_list;     
    int cnt = 0;   
 
    // get reference to the numpy.ndarray that OpenCV stores the descriptor matrix in
    if(!PyArg_ParseTuple(args, "O!", &PyArray_Type, &desc)) 
    {
        PyErr_SetString(lsh_error, "Invalid arguments.");
        return NULL;
    }
    
    // get a pointer to the input matrix (must be contiguous!!!!!)
    unsigned char * arr = (unsigned char *)PyArray_DATA(desc);

    // get the dimensions of the input matrix
    npy_intp * dims = PyArray_DIMS(desc);
    
    // allocate output
    out_list = PyList_New(dims[0] * NUMBER_OF_TABLES);
    if(!out_list)
    {
        PyErr_SetString(lsh_error, "Failed to allocate list.");
        return NULL;
    }

    // for each feature...
    for(int i = 0; i < dims[0]; i++)
    {
        // for each table...
        for(int tb = 0; tb < NUMBER_OF_TABLES; tb++)
        {
            // hash the feature
            size_t key_raw = get_key(tb, arr);
            
            // store in the output
            PyObject * key = PyInt_FromSize_t(key_raw);
            PyList_SET_ITEM(out_list, cnt, key);
            cnt++;
        }    
        // move to the next feature
        arr += FEATURE_SIZE;
    }
    return out_list;
}
    
// Hashing implementation
size_t get_key(unsigned int table_num, const unsigned char * feature)
{
    const size_t * feature_block_ptr = reinterpret_cast<const size_t *> ((const void *) feature);
    size_t subsignature = 0;
    size_t bit_index = 1;

    // for each element in this table's mask
    for(auto el : tables[table_num].mask)
    {
        // get next byte in the descriptor array
        size_t feature_block = *feature_block_ptr;

        // get next byte set in the mask
        size_t mask_block = el;
    
        while(mask_block)
        {
            // get the lowest bit set in the mask block
            size_t lowest_bit = mask_block & (-(ptrdiff_t)mask_block);
            
            // add it to the subsignature if necessary
            subsignature += (feature_block & lowest_bit) ? bit_index : 0;

            // unset that bit in the mask and move on to the next
            mask_block ^= lowest_bit;
            bit_index <<= 1;
        }
        ++feature_block_ptr;
    }
    return subsignature;
}

            
        
