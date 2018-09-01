import Foundation

public func isSorted(arr: [Int], index: Int) -> Bool
{
    if index < arr.count
    {
        return (arr[index-1] <= arr[index]) && isSorted(arr: arr, index: index+1)
    }
    return true
}

public func printArrayBackwards(arr: [Int], index: Int)
{
    if index >= 0
    {
        print(arr[index])
        printArrayBackwards(arr: arr, index: index-1)
    }
}

public func binarySearch(arr: [Int], start: Int, end: Int, x: Int) -> Int
{
    let mid = start + (end - start) / 2
    if arr[mid] == x
    {
        return mid
    }
    else if (x > arr[mid])
    {
        return binarySearch(arr: arr, start: (mid + 1), end: end, x: x)
    }
    else
    {
        return binarySearch(arr: arr, start: start, end: (mid - 1), x: x)
    }
}

public func arrange0and1(arr: inout [Int])
{
    var i = 0
    var j = arr.count - 1
    while j > i
    {
        if arr[i] == 1
        {
            i += 1
            continue
        }
        else
        {
            while(arr[j] == 0 && j>i)
            {
                j -= 1
            }
            if arr[j] == 1
            {
                let temp = arr[i]
                arr[i] = arr[j]
                arr[j] = temp
                i += 1
                j -= 1
            }
        }
    }
}

public func merge(arr1: [Int], arr2: [Int]) -> [Int]
{
    var arr3 = [Int]()
    
    var i = 0
    var j = 0
    
    while (i <= arr1.count - 1) && (j <= arr2.count - 1)
    {
        if arr1[i] <= arr2[j]
        {
            arr3.append(arr1[i])
            i += 1
        }
        else
        {
            arr3.append(arr2[j])
            j += 1
        }
    }
    if (i > arr1.count - 1) && (j <= arr2.count - 1)
    {
        while(j <= arr2.count - 1)
        {
            arr3.append(arr2[j])
            j += 1
        }
    }
        
    else if (i <= arr1.count - 1) && (j > arr2.count - 1)
    {
        while(i <= arr1.count - 1)
        {
            arr3.append(arr1[i])
            i += 1
        }
    }
    return arr3
}

public func mergeSort(arr: [Int], start: Int, end: Int) -> [Int]
{
    if start == end
    {
        return [arr[start]]
    }
    else
    {
        let mid = start + (end - start) / 2
        let arr1 = mergeSort(arr: arr, start: start, end: mid)
        let arr2 = mergeSort(arr: arr, start: mid+1, end: end)
        let arr3 = merge(arr1: arr1, arr2: arr2)
        return arr3
    }
}
