"""
Recursion Funcions

1) privet
2) privet n times
3) Sum 0+1+2+3+4+5
4) Factorial    5! = 1*2*3*4*5 = 120
5) Fibonacci    0,1,1,2,3,5,8,13,21,34,55
"""


def privet(x):
    if x == 0:
        return
    else:
        print("Hello World")
        privet(x-1)

# privet(0)

def sum(x):
    if x == 0:
        return 0
    elif x == 1:
        return 1
    else:
        return x + sum(x-1)
 
z = sum(5)
# print(z)

def fact(x):
    if x == 0:
        return 1
    else:
        return x * fact(x-1)

# print(fact(4))

def fibo(x):
    if x == 0:
        return 0
    elif x == 1:
        return 1
    else:
        return fibo(x-1) + fibo(x-2)

print(fibo(10))