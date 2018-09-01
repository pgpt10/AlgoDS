import Foundation

public func testLinkedList()
{
    print("----- Linked List -----")
    let linkedList = LinkedList()
    linkedList.add(1)
    linkedList.add(2, at: .end)
    linkedList.add(3, at: .atPos(0))
    linkedList.add(4, at: .afterData(1))
    linkedList.add(5, at: .beforeData(1))
    
    print("Length: ", linkedList.length)

    linkedList.delete()
    linkedList.delete(at: .data(5))
    
    print("Elements: ")
    linkedList.displayAll()
    
    linkedList.deleteAll()
}

public func testTree()
{
    print("----- Tree -----")
    
    let tree = Tree<Int>()
    tree.insert(10)
    tree.insert(8)
    tree.insert(3)
    tree.insert(3)
    tree.insert(5)
    tree.insert(20)
    tree.insert(12)
    tree.insert(30)
    
    
    print("\(TreeTraversal.levelOrder.rawValue.capitalized) traversal: ", tree.traverse(.levelOrder))
    print("Satisfy root.data == childeren data sum: ", tree.childrenSum(tree.root))
    print("Sum of all nodes:, ", tree.sumAllNodes(tree.root))
    print("Sum of all parent nodes with value 3: ", tree.sumAllParentNodes(of: tree.root, with: 3))
    print("Sum of left leaves: ", tree.sumLeftLeaves(tree.root, false))
    print("Sum of right leaves: ", tree.sumRightLeaves(tree.root, false))

    var paths = [[Int]]()
    var arr = [Int]()
    tree.rootToLeafPaths(tree.root, arr: &arr, paths: &paths)
    print("Root to Leaf paths: ", paths)

    print("Sum of leaves: ", tree.sumAllLeaves(tree.root))
    print("Sum of leaves at minimum level: ", tree.sumLeavesAtMinLevel(tree.root))
    
//    tree.printFullNodes(tree.root)
//    tree.printNodesAtOddLevel(tree.root, level: 0)
//
//    arr = []
//    tree.printRootToLeafPaths(tree.root, arr: &arr)
//
//    arr = []
//    tree.printRootToNodePath(tree.root, arr: &arr, x: 8)
//    tree.printNodesAtGivenLevel(tree.root, curLevel: 0, level: 1)
//    tree.printMiddleLevel(tree.root)
//
//    arr = []
//    tree.checkRootToLeafPathPresent(tree.root, arr: &arr, path: [2, 4, 8])
//    tree.checkIfFullBT(tree.root)
//
//    tree.checkIfIdentical(root, root1)
//    tree.checkIfSubTree(root, root1)
}

