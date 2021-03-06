/*
 *  Copyright (C) 2014, Geometric Design and Manufacturing Lab in THE CHINESE UNIVERSITY OF HONG KONG
 *  All rights reserved.
 *   
 *		 http://ldnibasedsolidmodeling.sourceforge.net/
 *  
 *   
 *  Redistribution and use in source and binary forms, with or without modification, 
 *  are permitted provided that the following conditions are met:
 *  
 *  1. Redistributions of source code must retain the above copyright notice, 
 *     this list of conditions and the following disclaimer.
 *  2. Redistributions in binary form must reproduce the above copyright notice, 
 *     this list of conditions and the following disclaimer in the documentation 
 *	   and/or other materials provided with the distribution.
 *
 *   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
 *   AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
 *   WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
 *   IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, 
 *   INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
 *   BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
 *   OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
 *   WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
 *   ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY 
 *   OF SUCH DAMAGE.
 */



// GLKMatrixLib.h: interface for the GLKMatrixLib class.
//
//////////////////////////////////////////////////////////////////////

#ifndef _CW_GLKMATRIXLIB
#define _CW_GLKMATRIXLIB

class GLKMatrixLib  
{
public:
	GLKMatrixLib();
	virtual ~GLKMatrixLib();

	static void CreateMatrix(double** &a, int row, int col);
	static void DeleteMatrix(double** &a, int row, int col);
	static void CreateMatrix(bool** &a, int row, int col);
	static void DeleteMatrix(bool** &a, int row, int col);

	static void Mul(double**a /*m by n*/, double**b  /*n by k*/, int m, int n, int k, 
					double**c /*m by k*/);
	static void Mul(double**a /*m by n*/, double*b  /*n rows*/, int m, int n, 
					double*c /*m rows*/);
	static int Rank(double**a /*m by n*/, int m, int n);
	static bool Inverse(double**a, int n);
	static bool Pseudoinverse(double** inputMatrix, int row, int col, 
								double** outputMatrix /* with (col x row) */);
	static void SwitchCol(double** a, int row, int col, int colIndex1, int colIndex2);
	static void SwitchRow(double** a, int row, int col, int rowIndex1, int rowIndex2);
	static void Transpose(double** inputMatrix, int row, int col, 
							double** outputMatrix /* with (col x row) */);
	static void Transpose(double** inputMatrix, int n);

	static bool GaussSeidelSolver(double** a, double* b, int n, double* x, double eps);
	static void ConjugateGradientSolver(double** a, double* b, int n, double* x, double eps);

	static bool GaussJordanElimination(double** a, int n, double* b);
	static bool GaussJordanElimination(double** a, int n, double** b, int m);
	// Linear equation solution by Gauss-Jordan elimination. a[0...(n-1)][0...(n-1)]
	//	is the input matrix. b[0...(n-1)][0...(m-1)] is input containing the m right-hand side vectors. 
	// On output, a is replaced by its matrix inverse, and b is replaced by the corresponding 
	//	set of solution vectors.

	static bool CholeskyDecompositionSolver(double** a, int n, double* b);
	static bool CholeskyDecompositionSolver(double** a, int n, double** b, int m);
	// Positive-Definite Symmetric Linear Equation solution by Cholesky Decomposition. 
	//	a[0...(n-1)][0...(n-1)]	is the input positive-definite matrix. 
	//	b[0...(n-1)][0...(m-1)] is input containing the m right-hand side vectors. 
	// On output, a is replaced by its matrix inverse, and b is replaced by the corresponding 
	//	set of solution vectors.

	static bool SingularValueDecomposition(double**a /*m by n*/, int m, int n, 
					double**u /*m by m*/, double**v /*n by n*/, double eps=0.000001);
	//  A = U W VT  - where U is stored in **u
	//					    VT is stored in **v
	//						W is stored in a[i][i] by the descending order
	static void SVDSolver(double** a, int n, double* b, double criterion=0.001);

	static bool JacobianEigensystemSolver(double**a /*n by n*/, 
					int n, double **eigenvectors, double *eigenvalues, double eps, int maxIter);
	// Note that: the matrix a[0...(n-1)][0...(n-1)] should be real symmetric
	//		has been modified during this function,
	//		and the eigen vectors are represented in columns.
	// For the returned "eigenvectors", eigenvectors[..][i] represents the eigenVector for the
	//		i-th eigenValue

	static bool HessenbergQREigenvaluesComputing(double**a /*n by n*/, 
					int n, double *eigenvalues_Re, double *eigenvalues_Im, 
					double eps, int maxIter);
	// Note that: the matrix a[0...(n-1)][0...(n-1)] is only required to be real 
	//		(i.e., asymmetric also works)
	static void ComputeEigenvectorByEigenvalue(double**a /*n by n*/, 
					int n, double eigenvalue, double*eigenvector);


	static void ComputeInertiaMatrixOfSegment(const double *p1, const double *p2, double length, double **result);

private:
	static void ppp(double** a,double* e, double* s, double** v, int m, int n);
	static void sss(double fg[], double cs[]);

	static void _HessenbergConversion(double* a, int n);
	static bool _Hessenberg_QR_Eigen(double* a, int n, double *u, double *v, double eps, int jt);
};

#endif
