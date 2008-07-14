{ import: Object }

[
    | random |
    random := Random new.
    10 timesRepeat: [random next println].
]
