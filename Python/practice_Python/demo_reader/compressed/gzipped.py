import gzip
import sys

opener = gzip.open  # this opener is like an alias to actual gzip.open

if __name__ == '__main__':
    f = gzip.open(sys.argv[1],mode='wt') # Here note that argv[0] always contains path of the current module
    f.write(' '.join(sys.argv[2:]))
    f.close()