data BT a b= Empty
        | Node (BT a b) (a,b) (BT a b)
        deriving (Eq,Show,Ord)


insert' :: (Integral a) => (BT a b)-> a -> b -> (BT a b)
insert' Empty k v = Node Empty (k,v) Empty
insert' (Node left (key,value) right) k v
    | k < key = (Node (insert' left k v) (key,value) right)
    | k > key = (Node left (key,value) (insert' right k v))
    | otherwise = Node left (k,v) right

tree :: BT a b
tree = Empty


mapTree :: (Integral a) => BT a b ->  (a->a)-> BT a b
mapTree Empty _ = Empty
mapTree (Node left (key,value) right) f = (Node (mapTree left f) (f key, value) (mapTree right f))

testTree' :: BT Integer String
testTree' = Node (Node Empty (3,"3") Empty) (1,"1") (Node Empty (4,"4") Empty)


preorder :: BT a b -> [a]
preorder Empty = []
preorder (Node left (key,value) right) =  (key : preorder left)  ++ preorder right

inorder :: BT a b -> [a]
inorder Empty = []
inorder (Node left (key,value) right) =  inorder left ++ [key]  ++ inorder right

postorder :: BT a b -> [a]
postorder Empty = []
postorder (Node left (key,value) right) =  postorder left  ++ postorder right ++ [key]

testTree :: BT Integer String
testTree = Node (Node Empty (1,"1") Empty) (2,"2") (Node Empty (3,"3") Empty)


testPreorder::IO()
testPreorder=
    if preorder testTree==[2,1,3]
    then putStrLn"Preorder fine!"
    else putStrLn"Bad news bears."

testInorder::IO()
testInorder=
    if inorder testTree==[1,2,3]
    then putStrLn"Inorder fine!"
    else putStrLn"Bad news bears."

testPostorder::IO()
testPostorder=
    if postorder testTree==[1,3,2]
    then putStrLn"Postorder fine!"
    else putStrLn"Bad news bears"

listToTree ::(Ord a,Integral a) => [a] -> BT a a
listToTree [] = Empty
listToTree (x:xs) = insert' (listToTree xs) x x

list = [10,5,31,32,53,231,1,11]


foldTree :: (a->b->b)-> b -> BT a a -> b
foldTree _ y Empty = y
foldTree f y (Node left (key,_) right) = (f key (foldTree f (foldTree f y right) left))


main::IO()
main= do
    testPreorder
    testInorder
    testPostorder
