#!/usr/bin/env python3

#an exponent
def foo1(x):
    return x ** 0.5



#returns the greatest value out of x and y
def foo2(x,y):
    if x > y:
        return x
    return y

#moves largest variable to the end of vector
def foo3(x, y, z):
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z]


def foo4(x):
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result

def foo5(x):
    if x == 1:
        return 1
    return x * foo5(x - 1)

foo5(10)
