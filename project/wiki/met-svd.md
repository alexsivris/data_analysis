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


Previous section: [Methods Introduction](met-intro)<br>
Next section: [PCA with SVD](met-pca)