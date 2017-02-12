% This make.m is used under Windows

mex -largeArrayDims -O -c svm.cpp
mex -largeArrayDims -O -c svm_model_matlab.c
mex -largeArrayDims -O svmtrain.c svm.o svm_model_matlab.o
mex -largeArrayDims -O svmpredict.c svm.o svm_model_matlab.o
mex -largeArrayDims -O read_sparse.c
