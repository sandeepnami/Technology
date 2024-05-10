package com.pluralsight.slidesconstructorsinitializers;

public class Earth {
    private long circumferenceInMiles = 24901;
    private long circumferenceInKms = Math.round(circumferenceInMiles * 1.6d);

    public long getCircumferenceInMiles() {
        return circumferenceInMiles;
    }

    public long getCircumferenceInKms() {
        return circumferenceInKms;
    }
}
