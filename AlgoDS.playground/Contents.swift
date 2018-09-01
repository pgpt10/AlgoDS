import Foundation

//testLinkedList()
//testTree()

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
    
    graph.traverse()
    print("\nBFS: ", graph.bfs(vertex: 0))
    var visited = [Int](repeating: 0, count: graph.numberOfVertices)
    var arr = [Int]()
    graph.dfs(vertex: 0, visited: &visited, arr: &arr)
    print("\nDFS: ", arr)
}

testGraph()
