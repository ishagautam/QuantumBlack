# QuantumBlack
QuantumBlack questions for platform team


## Exercises
### Generate 100 files
* Each file should contain a line with between 1 and 65 randomly chosen
  printable characters (both the number of the characters and the characters
  themselves are random)
* Line "This is every 5th file!" should appear in every 5th file
* Every 7th file ignores the previous two rules and contains the concatencated
  contents of all of the previous files.
* Write test-suite for your implementation.

## Solution

### Language
I decided to use Python for the solution because of it's intuitive and readable syntax, simple file handling, built-in random module, and powerful unittest module. 

### Control Flow
The nature of the exercise led me to consider a solution using control flow within a loop. Files whose indices were a multiple of 7 were deemed a special case, and written separately from all other files. This supported the potential issue where a file's index is both a multiple of 5 and 7, as my solution sticks to the problem definition and treats *all* multiples of 7 according to the specified rule. 

### Printable
The definition of "printable characters" was rather vague, and as such I chose a definition that fit best with the language I was using, and the rest of the problem definition. Python 2.7 by default encodes in ASCII, so I limited the scope of printable chars to ASCII printable chars. One sticking point with ASCII printable chars led me to narrow the definition further: the newline character is in this set, however the problem definition specifies that the random characters must be on *a line* in the file. Including newlines may cause each file to have more than one line, so I chose a set of printable ASCII chars that does not include the newline.

### Test Suite
In the test suite I aimed for coverage by responding to each problem specification, and also not using the exact same logic that I used in the solution code. This practice would avoid bias, since if some error exists in the shared code, the test suite would not catch it.


