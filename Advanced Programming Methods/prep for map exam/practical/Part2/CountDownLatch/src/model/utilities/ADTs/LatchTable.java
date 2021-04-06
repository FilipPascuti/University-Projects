package model.utilities.ADTs;

public class LatchTable<K,V> extends MyDictionary<K,V> implements ILatchTable<K,V>{

    private int freeLocation;

    public LatchTable() {
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
