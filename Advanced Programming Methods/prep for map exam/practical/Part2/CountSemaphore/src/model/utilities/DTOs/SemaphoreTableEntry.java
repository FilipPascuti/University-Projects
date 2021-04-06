package model.utilities.DTOs;

import javafx.beans.property.SimpleStringProperty;
import model.values.Value;

public class SemaphoreTableEntry {

    private SimpleStringProperty index;
    private SimpleStringProperty value;
    private SimpleStringProperty list;
    private String originalIndex;
    private String originalValue;
    private String originalList;

    public SemaphoreTableEntry(String originalIndex, String originalValue, String originalList) {
        this.originalIndex = originalIndex;
        this.originalValue = originalValue;
        this.originalList = originalList;
        this.index = new SimpleStringProperty(originalIndex);
        this.value = new SimpleStringProperty(originalValue);
        this.list = new SimpleStringProperty(originalList);
    }

    public String getIndex() {
        return index.get();
    }

    public String getValue() {
        return value.get();
    }

    public String getList() {
        return list.get();
    }
}
