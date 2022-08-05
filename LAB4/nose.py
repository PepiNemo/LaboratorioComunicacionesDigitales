import numpy
f = numpy.fromfile(open("salida1"), dtype=numpy.float32)
import matplotlib.pyplot as plt
plt.plot(f)
plt.show()
