import Foundation

//testLinkedList()
//testTree()

extension Graph
{
    public func inDegree(of vertex: Int) -> Int
    {
        return self.edges.filter { $0.1 == vertex }.count
    }
    
    public func topologicalSort() -> [Int]
    {
        var sortedArr = [Int]()
        
        var indegrees = [Int](repeating: 0, count: self.numberOfVertices)
        for e in edges
        {
            indegrees[e.1] += 1
        }
        let queue = Queue<Int>()
        for (v, indegree) in indegrees.enumerated()
        {
            if indegree == 0
            {
                queue.enqueue(v)
            }
        }
        while !queue.isEmptyQueue
        {
            if let vertex = queue.dequeue()
            {
                sortedArr.append(vertex)
                for v in self.verticesAdjacent(to: vertex)
                {
                    indegrees[v] -= 1
                    if indegrees[v] == 0
                    {
                        queue.enqueue(v)
                    }
                }
            }
        }
        return sortedArr
    }
    
    public func checkIfPathExist(from source: Int, to destination: Int, arr: inout [Int]) -> Bool
    {
        arr.append(source)
        if source == destination
        {
            return true
        }
        else
        {
            var isReachable = false
            for v in self.verticesAdjacent(to: source)
            {
                isReachable = isReachable || checkIfPathExist(from: v, to: destination, arr: &arr)
            }
            if !isReachable
            {
                arr.removeLast()
            }
            return isReachable
        }
    }
}

public func testGraph()
{
    print("----- Graph -----")
    
    let graph = Graph(7)
    graph.add((0, 1))
    graph.add((0, 3))
    graph.add((1, 3))
    graph.add((1, 4))
    graph.add((2, 0))
    graph.add((2, 5))
    graph.add((3, 5))
    graph.add((3, 6))
    graph.add((4, 6))
    graph.add((6, 5))
    graph.add((3, 2))

    graph.traverse()
    print("\nBFS: ", graph.bfs(vertex: 0))
    var visited = [Int](repeating: 0, count: graph.numberOfVertices)
    var arr = [Int]()
    graph.dfs(vertex: 5, visited: &visited, arr: &arr)
    print("\nDFS: ", arr)
    print("\nTopoligical Sort: ", graph.topologicalSort())
    
    arr = []
    print("Path exist from 2 to 6? - ", graph.checkIfPathExist(from: 2, to: 6, arr: &arr), " | path: ", arr)
}

testGraph()
