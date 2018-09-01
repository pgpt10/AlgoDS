import Foundation

public class Node
{
    public let data: Int
    public var next: Node?
    
    init(_ data: Int)
    {
        self.data = data
    }
}

public enum Position
{
    case start
    case end
    case atPos(Int)
    case afterData(Int)
    case beforeData(Int)
    case data(Int) //for delete
}

public class LinkedList
{
    private var head: Node?
    
    public var length: Int{
        var start = head
        var count = 0
        while start != nil
        {
            count += 1
            start = start?.next
        }
        return count
    }
    
    public init() {}
    
    public func add(_ data: Int, at position: Position = .start)
    {
        self.add(Node(data), at: position)
    }
    
    public func delete(at position: Position = .end)
    {
        if head == nil
        {
            return
        }
        else if head?.next == nil
        {
            head = nil
        }
        else
        {
            switch position
            {
            case .start:
                var node = head
                head = head?.next
                node = nil
                
            case .end:
                var p = head
                var q: Node?
                
                while p?.next != nil
                {
                    q = p
                    p = p?.next
                }
                q?.next = nil
                p = nil
                
            case .data(let value):
                if head?.data == value
                {
                    var p = head
                    head = head?.next
                    p = nil
                }
                else
                {
                    var p = head
                    var q: Node?
                    while p != nil && p?.data != value
                    {
                        q = p
                        p = p?.next
                    }
                    if p?.data == value
                    {
                        q?.next = p?.next
                        p = nil
                    }
                }
                
            default:
                break
            }
        }
    }
    
    public func deleteAll()
    {
        while head != nil
        {
            var p = head
            head = head?.next
            p = nil
        }
    }
    
    public func displayAll()
    {
        var start = head
        var arr = [String]()
        
        while start != nil
        {
            arr.append("\(String(describing: start?.data ?? -1))")
            start = start?.next
        }
        print(arr.joined(separator: ", "))
    }
}

private extension LinkedList
{
    func add(_ node: Node, at position: Position)
    {
        if head == nil
        {
            head = node
        }
        else
        {
            switch position
            {
            case .start:
                node.next = head
                head = node
                
            case .end:
                var start = head
                while(start?.next != nil)
                {
                    start = start?.next
                }
                start?.next = node
                
            case .atPos(let index):
                if index == 0
                {
                    node.next = head
                    head = node
                }
                else
                {
                    var count = 0
                    var start = head
                    while count < (index-1)
                    {
                        count += 1
                        start = start?.next
                    }
                    node.next = start?.next
                    start?.next = node
                }
                
            case .afterData(let data):
                var start = head
                while start?.data != data && start != nil
                {
                    start = start?.next
                }
                if start?.data == data
                {
                    node.next = start?.next
                    start?.next = node
                }
                
            case .beforeData(let data):
                var start = head
                if start?.data == data
                {
                    node.next = head
                    head = node
                }
                else
                {
                    while start != nil && start?.next != nil && start?.next?.data != data
                    {
                        start = start?.next
                    }
                    if start?.next?.data == data
                    {
                        node.next = start?.next
                        start?.next = node
                    }
                }
                
            default:
                break
            }
        }
    }
}
