# -*- coding: utf-8 -*-
# try something like
import request
def request_vars():
    num1=0
    num2=0
    total=0
    if request.post_vars():
        num1=float(request.post_vars.num1)
        num2=float(request.post_vars.num2)
        total=num1+num2
    return locals()


def request_args():
    arg1=float(request.args(0))
    arg2=float(request.args(1))
    total=arg1+arg2
    return locals()


def hello_world():
    msg="Hello World from MVC>Controller!"
    return locals()


def index():
    return dict(message="hello from basics.py")
