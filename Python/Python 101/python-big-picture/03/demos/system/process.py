import subprocess
pl = subprocess.Popen(['ps', '-U', '0'], stdout=subprocess.PIPE).communicate()[0]
print(pl.decode('utf-8'))
