import bz2
import sys

opener = bz2.open  # this opener is like an alias to actual bz2.open

if __name__ == '__main__':
    f = bz2.open(sys.argv[1],mode='wt') # Here note that argv[0] always contains path of the current module
    f.write(' '.join(sys.argv[2:]))
    f.close()