This repository is meant to demonstrate issues explained in a [stackoverflow question](http://stackoverflow.com/questions/40792073/upgrade-mongoid-2-8-1-to-5-1-4-drops-performance)

You can find 2 branches 5.1.4_performance and 2.8.1_performance with code for each version.

## Install
-----------

install gems with `bundle install --path=.bundle`

## Execution
------------

you can use the `launch_example.rb` script for that.
change SIMPLE_TIMES and CACHED_TIMES variables to manipulate test loads.
You can also change the TOTAL_ACCOUNT and TOTAL_CHANNELS variables to change test complexity.



2.8.1 without indexes

        Rehearsal --------------------------------------------------------------------------------------
        data generation                                      0.390000   0.000000   0.390000 (  0.385506)
        simple example (100000)                            131.510000   9.450000 140.960000 (165.854924)
        cached example (100000)                             56.660000   1.700000  58.360000 ( 58.383640)
        data drop                                           32.060000   3.090000  35.150000 ( 35.280237)
        --------------------------------------------------------------------------- total: 234.860000sec
                                                                 user     system      total        real
        data generation                                      0.040000   0.000000   0.040000 (  0.042422)
        simple example (100000)                            128.970000   9.240000 138.210000 (163.702208)
        cached example (100000)                             56.560000   1.720000  58.280000 ( 58.303140)
        data drop                                           31.750000   3.060000  34.810000 ( 34.890958)


5.1.4 without indexes

        Rehearsal --------------------------------------------------------------------------------------
        data generation                                      0.390000   0.020000   0.410000 (  0.417909)
        simple example (100000)                            239.040000  12.090000 251.130000 (292.856415)
        cached example (100000)                            102.330000   5.890000 108.220000 (126.855670)
        data drop                                           92.180000   8.820000 101.000000 (124.791807)
        --------------------------------------------------------------------------- total: 460.760000sec
                                                                 user     system      total        real
        data generation                                      0.070000   0.010000   0.080000 (  0.092045)
        simple example (100000)                            259.980000  13.000000 272.980000 (314.536532)
        cached example (100000)                            101.580000   5.440000 107.020000 (125.455840)
        data drop                                           91.000000   8.170000  99.170000 (121.737061)


