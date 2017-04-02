Introduction
------------

This section is intended as detailed explanation of the methods we used
for the project, which are respectively Singular Value Decomposition
(SVD), Principal Component Analysis (PCA), Regression Methods (Principal
Component Regression (PCR), Partial Least Square Regression(PLSR)), and Validation, and Clustering (especially k-Means Clustering).

Singular Value Decomposition (SVD)
----------------------------------

Singular value decomposition takes a rectangular matrix (defined as ,
where **X** is a n x p matrix) in which n is the number
of samples and p is the number of variables. The SVD theorem states:<br>

**X**(n x p) =  **U**(n x n)**S**(n x p)**V^T** (p x n)<br>
<div align="center"><br><img src="http://i.imgur.com/4dP6bXY.png" width="600" /> <br>
<b>Figure 1</b>: General Scheme of <i>SVD</i> <br></div>
Where U and V have orthonormal columns, so that<br>
**U** **U**^T =  **I**  <br>
**V** **V**^T =  **I**  <br>
Where the columns of  **U** are the left singular vectors
; **S**  is a diagonal ; matrix with singular values such that
s_(ixi) >= s_(jxj) where i<j , and  **V**^T
has rows that are the right singular vectors. The SVD represents an
expansion of the original data in a coordinate system where the
covariance matrix, which is the product  **X** **X**^T, is
diagonal.

Singular Value Decomposition (SVD) and Eigenvalue Decomposition
---------------------------------------------------------------

Simply put, the PCA viewpoint requires that one compute the eigenvalues
and eigenvectors of the covariance matrix, which is the product
 **X** **X**^T , where  **X** is the data matrix. Since
the covariance matrix is symmetric, the matrix is diagonalizable, and
the eigenvectors can be normalized such that they are orthonormal:<br>

 **X** **X**^T= **W D W^T**<br>

On the other hand, applying SVD to the data matrix  **X** as
follows:  **X= USV^T** and
construct the covariance matrix from this decomposition gives<br>
 **X X^T =( USV^T )((USV^T )^T )**<br>
 **X X^T =( U S V^T )( V S U^T )**<br>
since  **V** is an orthogonal matrix
**( V^T  V= I)**,<br>
 **X X^T= U S^2  U^T**<br>


Finally, it is easily seen that the square roots of the eigenvalues of
 **X X^T** are the singular values of  **X**.

In fact, using the SVD to perform PCA makes much better sense
numerically than forming the covariance matrix to begin with, since the
formation of  **X X^T** can cause loss of precision and
brings a huge computational cost in case of a large data matrix
 **X**.

Another advantage of using SVD over eigenvalue decomposition is that the
data matrix  **X** does not necessarily have to be square matrix to
make a decomposition analysis and equivalently a PCA analysis. As in
almost all practical cases  **X** is not a square matrix.

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

Regression Methods and Validation
---------------------------------

Multivariate regression methods have been popular in a wide range of
fields, and the most common ones are principal component regression
(PCR) and partial least squares regression (PLSR). The main reason for
this popularity is that they have been designed to face the situation
that there are many, possibly correlated, predictor variables, and
relatively few samples.Because of this, applying least square solution
of regular regression will not be have a solution in case of few
samples.

The general form of multiple linear regression,
 **Y =  X  B +  E** is solved by<br>
** B = (  X^T  X )^-1  X^T  Y**
The main problem of this solution is that  **X^T X** 
can be singular or near to singular. This can be caused by either that
the number of variables (columns) in data matrix  **X** can be more
than the number of samples (rows), or the correlation between variables
(columns). Here comes the contribution of both PCR and PLSR. In both,
 **X** is decomposed into orthogonal scores  **T** and
loadings  **P X =  T P** and then make
the regression on  **Y** not on  **X** itself but on the first
k columns of the scores  **T** .

PCA divides data matrix  **X** into scores  **T** and loadings
 **P**, More clearly, the scores are given by the left singular
vectors of  X multiplied with the corresponding singular values
 **T =  X  V = ( U  S  V^T)  V =  U  S**
since  **( V^T  V =  I)** . Columns of  **T**
are also called principal components (PCs). Moreover, the loadings are
given by the right singular vectors of  **X** , which are columns
of  **V**. Principal component regression (PCR) only takes into
account k principal components  **X**, and use it to predict
 **Y**. However, principal least square regression (PLSR) make a
prediction based on the PCs of both  **X** and  **Y** using
the scores and loadings.

### Mathematical Definition of PCR and PLSR

In PCR, we approximate the  **X** matrix by the first k principal
components (PCs), which are achieved by the singular value decomposition
(SVD):<br>
 **X =  X_k + E = (  U_k  S_k )  V_k^T + E_k =  T_k  P_k^T _ + E_x**,<br> 
where E is error. Next, we fit columns of
  **T_k =  X_k  V_k =  U_k  S_k** on
 **Y**, which has the following sollution:<br>
 **B=  P ( T^T  T )^-1  T^T  Y =  V  D^-1  U^T  Y**

In PLSR, the components, called Latent Variables (LVs), are achieved
iteratively. It starts with the SVD of the crossproduct matrix
 **X^T  Y**  , thereby including information on variation
in both  **X** and  **Y** , and on the correlation between
them. The first left and right singular vectors, w and q, are used as
weight vectors for  **X** and  **Y**, respectively, to obtain
scores t and u:<br>
 t =  **X** w =  **E** w<br>
u =  **Y** q =  **F** q <br>
 where  **E** and  **F are
initialised as  **X** and  **Y** , respectively. The
 **X** scores t are often normalised: t = t / sqrt(t^T t)
The  **Y** scores u are not actually necessary in the regression
but are often saved for interpretation purposes. Next,  **X** and
 **Y** loadings are obtained by regressing against the same vector
t:<br>
 p =  **E**^T t q =  **F**^T t

Finally, the data
matrices are 'deflated': the information related to this latent
variable, in the form of the outer products t p^T  and  t q^T,
is subtracted from the (current) data matrices  **E** and
 **F**.<br>
 **E**_(n+1) =  E_(n) − t p^T<br>
 **F**_(n+1) =  F_(n)− t q^T <br>

The is done for the SVD of
the crossproduct matrix   **E_(n+1)^T  F_(n+1)** . After
each iteration, vectors w, t, p and q are saved as the columns of
matrices  **W**,  **T** ,  **P** and  **Q**,
respectively.Finally the relation of the weights to the original
 **X**  matrix can be formulate as<br>
 **R =  W (  P^T  W )^-1** <br>
As it is done in PCR, instead of regressing  **Y** on  **X**, we use
scores  **T** to calculate the regression coefficients, and then
transform the coefficients back to the original space by multiplying
with matrix  **R** (since  **T =  X  R**):<br>
 **B =  R ( T^T  T )^-1  T^T  Y =  R  Q^T**<br>
Again, here, only the first a components are used. How many components
are optimal has to be determined, usually by cross-validation.

### Cross-Validation

K-Means Clustering
