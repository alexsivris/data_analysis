PCA Analysis with SVD
---------------------

Simply Principal Component Analysis (PCA) is the basis of multivariate
data analysis in different forms.It gives an approximation for data
matrix  **X** be of n x p size, where n is the number of
samples and p is the number of variables. This is done by trying
expressing **X** as product of two arbitrarily small matrices. These
matrices are called score and loading, and they used to catch essential
patterns of  **X** in PCA.

In PCA, the similar patterns of variables are estimated and it
simplifies the data matrix and make data reduction in a way.

### Mathematical Definition of PCA

Let us assume that it is centered, i.e. column means have been
subtracted and are now equal to zero. Then the p x p covariance
matrix  **C** is given by<br>
 **C =  X^T  X/(n-1).**<br>
 It is a symmetric matrixand so it can be diagonalized:<br>
 **C =  V  L  V^T**,<br>
 where **V** is a matrix of eigenvectors (each column is an eigenvector) and  **L**
is a diagonal matrix with eigenvalues lambda_i in the decreasing
order on the diagonal. The eigenvectors are called principal axes or
principal directions of the data. Projections of the data on the
principal axes are called principal components, also known as PC scores;
these can be seen as new, transformed, variables. The j-th principal
component is given by j-th column of  **XV**. The coordinates
of the i-th data point in the new PC space are given by the i-th row
of **XV**. If we now perform singular value decomposition of
 **X**, we obtain a decomposition
 **X =  U  S  V^T**, where  **S** is
the diagonal matrix of singular values s_i. From here one can easily
see that  <br>
**C =  V S U^T  U  S  V^T /(n-1) =  V  (S^2 /(n-1)) V^T**,<br>
meaning that right singular vectors 
**V** are principal directions and that singular values are related to the
eigenvalues of covariance matrix via lambda_i = s_i^2 /(n-1).
Principal components are given by<br>
 **X V =  U S V^T V =  U S** <br>
To summarize:<br>

1. If  **X =  U  S  V^T**, then columns of
 V are principal directions/axes
2. Columns of  **U S** are principal components (“scores”)
3. Singular values are related to the eigenvalues of covariance matrix
via lambda_i = s_i^2/(n-1). Eigenvalues lambda_i show variances of
the respective PCs
4. Standardized scores are given by columns of sqrt{n-1} U and
loadings are given by columns of  **V S**/sqrt(n-1)
5. The above is correct only if  **X** is centered. Only then is
covariance matrix equal to  **X^T X**/(n-1)
6. The above is correct only for  **X** having samples in rows and
variables in columns. If variables are in rows and samples in columns,
then  **U** and  **V** exchange interpretations
7. If one wants to perform PCA on a correlation matrix (instead of a
covariance matrix), then columns of  **X** should not only be
centered, but standardized as well, i.e. divided by their standard
deviations
8. To reduce the dimensionality of the data from p to k<p, select
k first columns of  **U**, and **k x k upper-left part** of
 S. Their product  **U_k  S_k** is the required
n x k matrix containing first k PCs
<div align="center"><br><img src="http://i.imgur.com/SJC2S3a.png" width="600" /> <br>
<b>Figure 2</b>: The approximated **X** for <i>r</i>  first components <i>SVD</i> <br></div>
9. Further multiplying the first k PCs by the corresponding principal
axes  **V_k^T** yields
 **X_k =  U_k  S_k   V_k^T** matrix that
has the original n x p size but is of lower rank (of rank k).
This matrix  **X_k** provides a reconstruction of the original data
from the first k PCs
10. Strictly speaking,  **U** is of nx n size and
 **V** is of p x p size. However, if n>p then the last
n-p columns of  **U** will be zeros; one should therefore use an
“economy size” (or “thin”) SVD that returns  **U** of nx p
size, dropping the zero columns. For large n >> p the matrix
 **U** would otherwise be unnecessarily huge. The same applies for
an opposite situation of n << p.


Previous section: [SVD](met-svd)<br>
Next section: [Regression Methods](met-regression)