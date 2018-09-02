import Foundation

public class Graph
{
    private let V: Int
    public var edges: [(Int, Int)]
    private let isBiDirectional: Bool
    private var adjList: [Node]?
    private var adjArray: [[Int]]?
    
    public var numberOfVertices: Int{
        return self.V
    }
    
    public init(_ V: Int, isBiDirectional: Bool = false)
    {
        self.V = V
        self.isBiDirectional = isBiDirectional
        self.edges = []
        self.adjList = [Node]()
        for v in 0..<V
        {
            self.adjList?.append(Node(v))
        }
        self.adjArray = [[Int]].init(repeating: [Int](repeating: 0, count: V), count: V)
    }
    
    public func add(_ edge: (Int, Int))
    {
        self.adjArray?[edge.0][edge.1] = 1
        let node1 = Node(edge.1)
        self.add(node1, to: self.adjList?[edge.0])
        self.edges.append((edge.0, edge.1))
        
        if self.isBiDirectional
        {
            self.adjArray?[edge.1][edge.0] = 1
            let node2 = Node(edge.0)
            self.add(node2, to: self.adjList?[edge.1])
            self.edges.append((edge.1, edge.0))
        }
    }
}

public extension Graph
{
    func traverse()
    {
        if let adjList = self.adjList
        {
            for v in adjList
            {
                var temp: Node? = v
                var tempArr = [Int]()
                while temp != nil
                {
                    tempArr.append(temp!.data)
                    temp = temp?.next
                }
                print(tempArr.map({ String($0) }).joined(separator: "->"))
            }
        }
    }
    
    func bfs(vertex: Int) -> [Int]
    {
        var visited = [Int](repeating: 0, count: self.V)
        var bfsArr = [Int]()
        
        let queue = Queue<Int>()
        visited[vertex] = 1
        queue.enqueue(vertex)
        
        while !queue.isEmptyQueue
        {
            if let temp = queue.dequeue()
            {
                bfsArr.append(temp)
                for v in self.verticesAdjacent(to: temp)
                {
                    if visited[v] != 1
                    {
                        visited[v] = 1
                        queue.enqueue(v)
                    }
                }
            }
        }
        
        return bfsArr
    }
    
    func dfs(vertex: Int, visited: inout [Int], arr: inout [Int])
    {
        visited[vertex] = 1
        arr.append(vertex)
        for v in self.verticesAdjacent(to: vertex)
        {
            if visited[v] != 1
            {
                dfs(vertex: v, visited: &visited, arr: &arr)
            }
        }
    }
}

extension Graph
{
    private func add(_ node: Node?, to head: Node?)
    {
        var head = head
        if head == nil
        {
            head = node
        }
        else
        {
            var temp = head
            while temp?.next != nil
            {
                temp = temp?.next
            }
            temp?.next = node
        }
    }
    
    public func verticesAdjacent(to vertex: Int) -> [Int]
    {
        var arr = [Int]()
        var node = self.adjList?[vertex].next
        while node != nil
        {
            arr.append(node!.data)
            node = node?.next
        }
        return arr
    }
}
