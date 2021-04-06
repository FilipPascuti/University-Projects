package model.utilities.ADTs;

public interface ILockTable<K,V> extends IDictionary<K,V> {
    public int getFreeLocation();
}
