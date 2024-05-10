from demo_reader.multireader import MultiReader

r = MultiReader("test.bz2")
print('Contents of the file are below \n',r.read()) # read gets all the contents of the file at one go
r.close()

r = MultiReader("test.gz")
print('Contents of the file are are below \n',r.read())
r.close()
  