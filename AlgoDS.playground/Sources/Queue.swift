public class Queue<T>
{
    private var array: [T] = []
    
    public init() {}
    
    public var isEmptyQueue: Bool{
        return array.isEmpty
    }
    
    public var size: Int{
        return array.count
    }
    
    public var front: T?{
        return array.first
    }
    
    public var rear: T?{
        return array.last
    }
    
    public var elements: [T]{
        return self.array
    }
    
    
    public func enqueue(_ element: T?)
    {
        if let element = element
        {
            self.array.append(element)
        }
    }
    
    public func dequeue() -> T?
    {
        if !isEmptyQueue
        {
            return self.array.removeFirst()
        }
        return nil
    }
}
