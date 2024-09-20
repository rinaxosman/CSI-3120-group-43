# Q1 Tests (map2)

Test 1 - fun x y -> x + y
    Input: [1; 2; 3], [4; 5; 6]
    Output: [5; 7; 9]

Test 2 - fun x y -> x * y
    Input: [2; 4; 6], [1; 3; 5]
    Output: [2; 12; 30]

Test 3 - fun x y -> x - y
    Input: [10; 20; 30], [5; 10; 15]
    Output: [5; 10; 15]

# Q2 Tests (filter_even)

Test 1
    Input: [1; 2; 3; 4; 5; 6]
    Output: [2; 4; 6]

Test 2
    Input: [10; 15; 20; 25; 30]
    Output: [10; 20; 30]

Test 3
    Input: [7; 14; 21; 28; 35; 42]
    Output: [14; 28; 42]

# Q3 Tests (compose_functions)

Test 1 - fun x -> x * 2, fun y -> y + 3
    Input: 5
    Output: 16

Test 2 - fun x -> x - 1, fun y -> y * 3
    Input: 4
    Output: 11

Test 3 - fun x -> x / 2, fun y -> y + 10
    Input: 8
    Output: 9

# Q4 Tests (reduce)

Test 1 - fun x y -> x + y
    Input: [1; 2; 3; 4]
    Output: 10

Test 2 - fun x y -> x * y
    Input: [2; 3; 4; 5]
    Output: 120

Test 3 - fun x y -> x - y
    Input: [1; 2; 3]
    Output: 4