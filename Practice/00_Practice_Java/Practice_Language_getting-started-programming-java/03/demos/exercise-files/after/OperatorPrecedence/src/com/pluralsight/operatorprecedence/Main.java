package com.pluralsight.operatorprecedence;

public class Main {

    public static void main(String[] args) {
        int valA = 21;
        int valB = 6;
        int valC = 3;
        int valD = 1;
        final int constVal = 25; // here the value of constVal cannot be changed
        int result1 = valA - valB / valC;

        int result2 = (valA - valB) / valC;

        System.out.println(result1);
        System.out.println(result2);

        int result3 = valA / valC * valD + valB;

        int result4 = valA / (valC * (valD + valB));

        System.out.println(result3);
        System.out.println(result4);

         //constVal = 30; // constVal cannot be changed
        System.out.println(constVal);       
    }
}





