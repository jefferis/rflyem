# rflyem

The goal of rflyem is to provide R access to connectomic data shared by the
Janelia FlyEM project at http://emdata.janelia.org

## Example

This is a basic example which shows you how to solve a common problem:

``` r
## basic example code
library(rflyem)
u="http://emdata.janelia.org/api/node/822524777d3048b8bd520043f90c1d28/.files/key/synapse.json"
s=read_synapse(u)

library(nat)
points3d(xyzmatrix(s$tbars))

```

## Installation

``` r
if(!require('devtools')) install.packages('devtools')
devtools::install_github('jefferis/rflyem')
```
