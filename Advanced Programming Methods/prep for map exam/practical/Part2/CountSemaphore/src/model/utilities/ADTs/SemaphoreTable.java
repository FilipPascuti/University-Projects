package model.utilities.ADTs;

public class SemaphoreTable<K,V> extends MyDictionary<K,V> implements ISemaphoreTable<K,V>{

    private int freeLocation;

    public SemaphoreTable() {
        super();
        this.freeLocation = 1;
    }

    @Override
    public void put(K key, V value) {
        super.put(key, value);
        freeLocation++;
    }

    @Override
    public int getFreeLocation() {
        return freeLocation;
    }
}
