import Foundation

public class TNode<T>
{
    var data: T
    var left: TNode?
    var right: TNode?
    
    public init(_ data: T)
    {
        self.data = data
    }
}

public enum TreeTraversal: String
{
    case preOrder
    case inOrder
    case postOrder
    case levelOrder
}

public class Tree<T>
{
    public var root: TNode<T>?
    
    public init() {}
    
    //Traversal
    public func traverse(_ type: TreeTraversal) -> [T]
    {
        var arr = [T]()
        switch type
        {
        case .preOrder:
            self.preorderTraversal(root, &arr)
            
        case .postOrder:
            self.postorderTraversal(root, &arr)
            
        case .inOrder:
            self.inorderTraversal(root, &arr)
            
        case .levelOrder:
            self.levelorderTraversal(root, &arr)
        }
        
        return arr
    }
    
    //Insertion
    public func insert(_ data: T)
    {
        let node = TNode<T>(data)
        if root == nil
        {
            root = node
        }
        else
        {
            let queue = Queue<TNode<T>>()
            queue.enqueue(root)
            while(!queue.isEmptyQueue)
            {
                let temp = queue.dequeue()
                if temp?.left == nil
                {
                    temp?.left = node
                    return
                }
                else
                {
                    queue.enqueue(temp?.left)
                }
                if temp?.right == nil
                {
                    temp?.right = node
                    return
                }
                else
                {
                    queue.enqueue(temp?.right)
                }
            }
        }
    }
    
//    public func delete(_ x: T)
//    {
//        if root == nil
//        {
//            return
//        }
//        else
//        {
//            var foundNode: TNode<T>?
//            var lastNode: TNode<T>?
//
//            let queue = Queue<TNode<T>>()
//            queue.enqueue(root)
//            while !queue.isEmptyQueue
//            {
//                let temp = queue.dequeue()
//                if temp?.data == x
//                {
//                    foundNode = temp
//                }
//                queue.enqueue(temp?.left)
//                queue.enqueue(temp?.right)
//                lastNode = temp
//            }
//            if foundNode != nil
//            {
//                if let data = lastNode?.data
//                {
//                    foundNode?.data = data
//                    lastNode = nil
//                }
//            }
//        }
//    }
}

extension Tree
{
    func preorderTraversal(_ root: TNode<T>?, _ arr: inout [T])
    {
        if let root = root
        {
            arr.append(root.data)
            preorderTraversal(root.left, &arr)
            preorderTraversal(root.right, &arr)
        }
        return
    }
    
    func inorderTraversal(_ root: TNode<T>?, _ arr: inout [T])
    {
        if let root = root
        {
            inorderTraversal(root.left, &arr)
            arr.append(root.data)
            inorderTraversal(root.right, &arr)
        }
        return
    }
    
    func postorderTraversal(_ root: TNode<T>?, _ arr: inout [T])
    {
        if let root = root
        {
            postorderTraversal(root.left, &arr)
            postorderTraversal(root.right, &arr)
            arr.append(root.data)
        }
        return
    }
    
    func levelorderTraversal(_ root: TNode<T>?, _ arr: inout [T])
    {
        if let root = root
        {
            let queue = Queue<TNode<T>>()
            queue.enqueue(root)
            while !queue.isEmptyQueue
            {
                if let temp = queue.dequeue()
                {
                    arr.append(temp.data)
                    queue.enqueue(temp.left)
                    queue.enqueue(temp.right)
                }
            }
        }
    }
}

extension Tree
{
    public func childrenSum(_ root: TNode<Int>?) -> Bool
    {
        if root != nil
        {
            if root?.left == nil && root?.right == nil
            {
                return true
            }
            else
            {
                let isLeftChildrenSum = childrenSum(root?.left)
                let isRightChildrenSum = childrenSum(root?.right)
                
                let leftData = root?.left?.data ?? 0
                let rightData = root?.right?.data ?? 0
                return (root?.data == (leftData + rightData)) && isLeftChildrenSum && isRightChildrenSum
            }
        }
        return true
    }
    
    public func sumAllNodes(_ root: TNode<Int>?) -> Int
    {
        if let root = root
        {
            return root.data + sumAllNodes(root.left) + sumAllNodes(root.right)
        }
        return 0
    }
    
    public func sumAllParentNodes(of root: TNode<Int>?, with childData: Int?) -> Int
    {
        if let root = root
        {
            var data = 0
            if root.left?.data == childData || root.right?.data == childData
            {
                data = root.data
            }
            return data + sumAllParentNodes(of: root.left, with: childData) + sumAllParentNodes(of: root.right, with: childData)
        }
        return 0
    }

    public func sumLeftLeaves(_ root: TNode<Int>?, _ isLeft: Bool) -> Int
    {
        if let root = root
        {
            if root.left == nil && root.right == nil && isLeft
            {
                return root.data
            }
            else
            {
                return sumLeftLeaves(root.left, true) + sumLeftLeaves(root.right, false)
            }
        }
        return 0
    }
    
    public func sumRightLeaves(_ root: TNode<Int>?, _ isLeft: Bool) -> Int
    {
        if let root = root
        {
            if root.left == nil && root.right == nil && !isLeft
            {
                return root.data
            }
            else
            {
                return sumRightLeaves(root.left, true) + sumRightLeaves(root.right, false)
            }
        }
        return 0
    }
    
    public func rootToLeafPaths(_ root: TNode<Int>?, arr: inout [Int], paths: inout [[Int]])
    {
        if let root = root
        {
            arr.append(root.data)
            if root.left == nil && root.right == nil
            {
                paths.append(arr)
            }
            else
            {
                rootToLeafPaths(root.left, arr: &arr, paths: &paths)
                rootToLeafPaths(root.right, arr: &arr, paths: &paths)
            }
            arr.removeLast()
        }
    }
    
    public func sumAllLeaves(_ root: TNode<Int>?) -> Int
    {
        if let root = root
        {
            if root.left == nil && root.right == nil
            {
                return root.data
            }
            else
            {
                return sumAllLeaves(root.left) + sumAllLeaves(root.right)
            }
        }
        return 0
    }
    
    public func sumLeavesAtMinLevel(_ root: TNode<Int>?) -> Int
    {
        var sum = 0
        var minLevel: Int?
        var currLevel = 0
        
        let queue = Queue<TNode<Int>>()
        queue.enqueue(root)
        queue.enqueue(TNode(-1))
        while !queue.isEmptyQueue
        {
            if let temp = queue.dequeue()
            {
                if temp.data == -1
                {
                    queue.enqueue(TNode(-1))
                    currLevel += 1
                }
                else
                {
                    if temp.left == nil && temp.right == nil
                    {
                        if minLevel == nil
                        {
                            minLevel = currLevel
                        }
                        if currLevel == minLevel
                        {
                            sum = sum + temp.data
                        }
                    }
                    else
                    {
                        if temp.left != nil
                        {
                            queue.enqueue(temp.left)
                        }
                        if temp.right != nil
                        {
                            queue.enqueue(temp.right)
                        }
                    }
                }
            }
        }
        return sum
    }

    public func printFullNodes(_ root: TNode<Int>?)
    {
        if let root = root
        {
            if root.left != nil && root.right != nil
            {
                print(root.data)
            }
            printFullNodes(root.left)
            printFullNodes(root.right)
        }
    }
    
    public func printNodesAtOddLevel(_ root: TNode<Int>?, level: Int)
    {
        if let root = root
        {
            if level % 2 != 0
            {
                print(root.data)
            }
            printNodesAtOddLevel(root.left, level: level+1)
            printNodesAtOddLevel(root.right, level: level+1)
        }
    }
    
    public func printRootToLeafPaths(_ root: TNode<Int>?, arr: inout [Int])
    {
        if let root = root
        {
            arr.append(root.data)
            if root.left == nil && root.right == nil
            {
                print(arr.map({ String($0) }).joined(separator: ", "))
            }
            else
            {
                printRootToLeafPaths(root.left, arr: &arr)
                printRootToLeafPaths(root.right, arr: &arr)
            }
            arr.removeLast()
        }
    }
    
    public func printRootToNodePath(_ root: TNode<Int>?, arr: inout [Int], x: Int)
    {
        if let root = root
        {
            arr.append(root.data)
            if root.data == x
            {
                print(arr.map({ String($0) }).joined(separator: ", "))
                return
            }
            printRootToNodePath(root.left, arr: &arr, x: x)
            printRootToNodePath(root.right, arr: &arr, x: x)
            arr.removeLast()
        }
    }
    
    public func printNodesAtGivenLevel(_ root: TNode<Int>?, curLevel: Int, level: Int)
    {
        if let root = root
        {
            if curLevel == level
            {
                print(root.data)
            }
            printNodesAtGivenLevel(root.left, curLevel: curLevel+1, level: level)
            printNodesAtGivenLevel(root.right, curLevel: curLevel+1, level: level)
        }
    }
    
    public func printMiddleLevel(_ root: TNode<Int>?)
    {
        if let root = root
        {
            var p: TNode<Int>? = root
            var q: TNode<Int>? = root
            var midLevel = 0
            while q != nil && q?.left != nil
            {
                midLevel += 1
                p = p?.left
                q = q?.left?.left
            }
            
            printNodesAtGivenLevel(root, curLevel: 0, level: midLevel)
        }
    }
    
    public func checkRootToLeafPathPresent(_ root: TNode<Int>?, arr: inout [Int], path: [Int]) -> Bool
    {
        if let root = root
        {
            arr.append(root.data)
            if root.left == nil && root.right == nil
            {
                let arrStr = arr.map({ String($0) }).joined(separator: ", ")
                let pathStr = arr.map({ String($0) }).joined(separator: ", ")
                arr.removeLast()
                return(arrStr.contains(pathStr) ? true : false)
            }
            else
            {
                let left = checkRootToLeafPathPresent(root.left, arr: &arr, path: path)
                let right = checkRootToLeafPathPresent(root.right, arr: &arr, path: path)
                arr.removeLast()
                return left || right
            }
        }
        return true
    }
    
    public func checkIfFullBT(_ root: TNode<Int>?) -> Bool
    {
        if let root = root
        {
            return checkIfFullBT(root.left) && checkIfFullBT(root.right) && ((root.left != nil && root.right != nil) || (root.left == nil && root.right == nil))
        }
        return true
    }
    
    public func checkIfIdentical(_ root1: TNode<Int>?, _ root2: TNode<Int>?) -> Bool
    {
        if let root1 = root1, let root2 = root2
        {
            return checkIfIdentical(root1.left, root2.left) && checkIfIdentical(root1.right, root2.right) && (root1.data == root2.data)
        }
        else if root1 == nil && root2 == nil
        {
            return true
        }
        return false
    }
    
    public func checkIfContainsDuplicates(_ root: TNode<Int>?, arr: inout [Int]) -> Bool
    {
        if let root = root
        {
            let isContains = arr.contains(root.data)
            if !isContains
            {
                arr.append(root.data)
            }
            return checkIfContainsDuplicates(root.left, arr: &arr) && checkIfContainsDuplicates(root.right, arr: &arr) && isContains
        }
        return true
    }

    public func leafNodes(root: TNode<T>?) -> Int
    {
        if root != nil
        {
            if root?.left == nil && root?.right == nil
            {
                print(root?.data ?? "")
                return 1
            }
            else
            {
                return leafNodes(root: root?.left) + leafNodes(root: root?.right)
            }
        }
        return 0
    }
    
    public func nonLeafNodes(root: TNode<T>?) -> Int
    {
        if root != nil
        {
            if root?.left == nil && root?.right == nil
            {
                return 0
            }
            else
            {
                print(root?.data ?? "")
                return 1 + nonLeafNodes(root: root?.left) + nonLeafNodes(root: root?.right)
            }
        }
        return 0
    }
    
    public func totalNodes(root: TNode<T>?) -> Int
    {
        if root != nil
        {
            print(root?.data ?? "")
            return 1 + totalNodes(root: root?.left) + totalNodes(root: root?.right)
        }
        return 0
    }
    
    public func strictOrNot(root: TNode<T>?) -> Bool
    {
        if root != nil
        {
            if (root?.left != nil && root?.right == nil) || (root?.left == nil && root?.right != nil)
            {
                return false
            }
            else
            {
                return strictOrNot(root: root?.left) && strictOrNot(root: root?.right)
            }
        }
        return true
    }
    
    public func heightOfTree(root: TNode<T>?) -> Int
    {
        if root != nil
        {
            if root?.left == nil && root?.right !== nil
            {
                return 1
            }
            else
            {
                return 1 + max(heightOfTree(root: root?.left), heightOfTree(root: root?.right))
            }
        }
        return 0
    }
    
    public func findMinElementInBSP(root: TNode<Int>?)
    {
        if root != nil
        {
            var temp = root
            while (temp?.left != nil)
            {
                temp = temp?.left
            }
            print(temp?.data ?? "")
        }
    }
}

extension Tree: CustomDebugStringConvertible
{
    public var debugDescription: String{
        let elements = self.traverse(.levelOrder).map { (data) -> String in
            if let data = data as? String
            {
                return data
            }
            else if let data = data as? Int
            {
                return String(data)
            }
            return ""
        }
        return elements.joined(separator: ", ")
    }
}

