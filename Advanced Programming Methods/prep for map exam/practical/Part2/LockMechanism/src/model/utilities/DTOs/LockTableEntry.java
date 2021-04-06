package model.utilities.DTOs;

import javafx.beans.property.SimpleStringProperty;

public class LockTableEntry {

    private SimpleStringProperty location;
    private SimpleStringProperty value;
    private String originalLocation;
    private String originalValue;

    public LockTableEntry(String originalLocation, String originalValue) {
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
