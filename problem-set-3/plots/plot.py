# Generowanie wykresu za pomocą matplotlib w Pythonie
# autor Piotr Szyma

import matplotlib.pyplot as plt
import numpy as np
from numpy import exp

t = np.arange(-3.0, 3.0, 0.2)

def func(x):
    return 3 * x - exp(1)**x

plt.grid(True)
plt.plot(t, func(t), 'r')
plt.savefig('ex5.png');

def ex_6_f_1(x):
    return exp(1) ** (1 - x) - 1

t = np.arange(-2.0, 7.0, 0.1)
plt.clf()
plt.grid(True)
plt.plot(t, ex_6_f_1(t), 'r')
plt.savefig('ex6_f_1.png');

def ex_6_f_2(x):
    return x * exp(1) ** ((-1)* x)

plt.clf()
plt.grid(True) 
plt.plot(t, ex_6_f_2(t), 'r')
plt.savefig('ex6_f_2.png');