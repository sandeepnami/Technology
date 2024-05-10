package com.pluralsight.calcengine;

public class PowerOf implements MathProcessing {
    private String formattedOutput;    @Override
    public String getKeyWord() {
        return "power";
    }

    @Override
    public String getFormattedOutput() {
        return formattedOutput;
    }

    @Override
    public double doCalculation(double leftVal, double rightVal) {
        double product =  Math.pow(leftVal, rightVal);
        formattedOutput = leftVal + " to the power of " + rightVal + " is " + product;
        return product;
    }
}
