def binarysearch(mylist, number, start, stop):
    if start > stop:
        return False
    else:
        mid = (start + stop // 2)
        if number == mylist[mid]:
            return mid
        elif number < mylist[mid]:
            return binarysearch(mylist, number, start, mid - 1)
        else:
            return binarysearch(mylist, number, mid + 1, stop)


mylist = [10, 12, 13, 15, 20, 24, 27, 33, 42, 51, 57, 68, 70, 77, 79, 81]
number = 20
start = 0
stop = len(mylist)

x = binarysearch(mylist, number, start, stop)

if x == False:
    print("Item ", number , "not found!")
else:
    print("Item ", number , "found as index ", x)