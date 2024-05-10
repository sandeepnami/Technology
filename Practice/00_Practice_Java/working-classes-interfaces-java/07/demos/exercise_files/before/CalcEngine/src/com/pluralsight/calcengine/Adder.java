package com.pluralsight.calcengine;

public class Adder extends CalculateBase {
    @Override
    public void calculate() {
        double value = getLeftVal() + getRightVal();
        setResult(value);
    }
}
