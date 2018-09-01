class Stack<T>
{
    private var array: [T]  = []
    
    var size: Int{
        return array.count
    }
    var top: T?{
        return array.last
    }
    
    var isEmptyStack: Bool{
        return self.array.isEmpty
    }
    
    func push(_ element: T)
    {
        self.array.append(element)
    }
    
    func pop() -> T?
    {
        if !isEmptyStack
        {
            return self.array.removeLast()
        }
        return nil
    }
}
