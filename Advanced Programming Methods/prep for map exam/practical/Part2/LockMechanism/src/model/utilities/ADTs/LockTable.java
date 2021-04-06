package model.utilities.ADTs;

public class LockTable<K,V> extends MyDictionary<K,V> implements ILockTable<K,V>{

    private Integer freeLocation;

    public LockTable() {
        super();
        this.freeLocation = 1;
    }

    @Override
    public int getFreeLocation() {
        return freeLocation;
    }

    @Override
    public void put(K key, V value) {
        super.put(key, value);
        freeLocation++;
    }
}
