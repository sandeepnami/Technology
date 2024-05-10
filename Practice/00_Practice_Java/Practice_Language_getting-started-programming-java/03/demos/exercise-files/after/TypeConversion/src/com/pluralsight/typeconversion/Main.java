package com.pluralsight.typeconversion;

public class Main {

    public static void main(String[] args) {
        float floatVal = 1.0f;
        double doubleVal = 4.0d;
        byte byteVal = 7;
        short shortVal = 7;
        long longVal = 5;

//        short result1 = byteVal;
//        short result1 = longVal;
//        short result1 = (short)longVal;
        short result1 = (short)byteVal;

//        short result2 = byteVal - longVal;
        short result2 = (short)(byteVal - longVal);

//        long result3 = longVal - floatVal;
        float result3 = longVal - floatVal;

        // **********************************
        // Below are some additional examples
        // beyond those shown in the video.
        // **********************************

//        float result4 = longVal - doubleVal;
        double result4 = longVal - doubleVal;

//        long result5 = shortVal - longVal + floatVal + doubleVal;
        long result5 = (long)(shortVal - longVal + floatVal + doubleVal);

        System.out.println("Success");
    }
}
