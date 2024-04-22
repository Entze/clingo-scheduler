BEGIN {
    pattern="Answer: [0-9]+"
    answer_set = 0
}

$0 ~ pattern {
    answer_set = 1
    next
}

answer_set == 1 {
    print $0
    answer_set = 0
}
