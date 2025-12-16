# An example database to compare 2 ways of aggregating data in 4D:
1. SQL
2. ORDA

Using SQL, it is easy to use the GROUP BY statement to aggregate data. It returns arrays of data that then might need to be formatted properly before display.
Using ORDA, looping through each record and creating a hashmap (filling an object) is a suprisingly fast way to aggregate data. The hashmap needs to be formatted properly before display as well.

Pro's and cons:

Pro's
SQL: Usually fast performance and nice readability of what is being aggregated.
ORDA: Native 4D code that is easily modified by any 4D developer.
ORDA: Often close to the perfomance of SQL (when using a hashmap and execute on server) or even faster!

Cons
SQL: Can be slower if grouped by a field that needs to be calculated (example: group by year, using a date field)
SQL: Needs knowledge of SQL to be able to read and optimize.
ORDA: Aggregations need to be done server side (for performance). This means you need to manage the methods to be performed server side.

Turns out that like everything in programming: what's better? well, it depends.
Make sure to test your queries! ORDA can be fast too!

# Graphs won't work
The WebAreas are supposed to display graphs, but these only work using a component that is not publicly available.

# Generate data
Upon opening the project for the first time (or when the data file is empty), you get a prompt if you want to create data.
Choosing yes will generate 1 million rows of the Sales table. This might take a minute or two, so be patient!
