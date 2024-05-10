package com.pluralsight.calcengine;

public class Mulitiplier extends CalculateBase {
    @Override
    public void calculate() {
        double value = getLeftVal() * getRightVal();
        setResult(value);
    }
}
