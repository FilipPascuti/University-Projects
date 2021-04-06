package model.utilities.ADTs;

public interface ISemaphoreTable<K,V> extends IDictionary<K,V>{
    public int getFreeLocation();
}
