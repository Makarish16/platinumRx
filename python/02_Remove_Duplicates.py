# Question 2: Remove duplicates and print unique string using a loop

def remove_duplicates(input_string):
    unique_string = ""

    for char in input_string:
        if char not in unique_string:
            unique_string += char

    print(f"Original: {input_string}")
    print(f"Unique:   {unique_string}")


remove_duplicates("aabbcddddeff")
remove_duplicates("hello world")
