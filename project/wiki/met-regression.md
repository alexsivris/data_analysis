Regression Methods 
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
are optimal has to be determined, usually by [cross-validation](met-clustering).



Previous section: [PCA with SVD](met-pca)<br>
Next section: [Clustering and Validation](met-clustering)