package model.utilities.ADTs;

public interface ILatchTable<K,V> extends IDictionary<K,V>{
    public int getFreeLocation();
}
