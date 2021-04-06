package model.utilities.DTOs;

import javafx.beans.property.SimpleStringProperty;
import model.values.Value;

public class LatchTableEntry {

    private SimpleStringProperty location;
    private SimpleStringProperty value;
    private String originalLocation;
    private String originalValue;

    public LatchTableEntry(String originalLocation, String originalValue) {
        this.originalLocation = originalLocation;
        this.originalValue = originalValue;
        this.location = new SimpleStringProperty(originalLocation);
        this.value = new SimpleStringProperty(originalValue);
    }

    public String getLocation() {
        return location.get();
    }

    public String getValue() {
        return value.get();
    }

}
