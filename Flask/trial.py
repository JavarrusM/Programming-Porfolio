import csv 
with open('data/movies.csv', 'r', encoding='utf-8') as f:
    reader = csv.reader(f)
    table = list()
    for header in reader:
        print(header)
        break

    row_limit = 100
    ctr = 0
    
    # Read in each row
    for row in reader:
        table.append(row)

        # Only read first 100 data rows - [2 points] Q5.a
        ctr += 1
        if ctr >= 100: break
        
print(len(table))
table.sort(key=lambda x: x[-1])
print(table)