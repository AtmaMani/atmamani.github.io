# Guide to spatial analysis
A set of notes explaining the core of spatial analysis.

## Basics of spatial data structures
### 2 fundamental representations
 * vector - each entity /feature is a row in a table. Each feature can be queried, have one or more attributes. Features are generally discrete entities. Vectors can be represented using
   * points
   * lines
   * polygons

 * raster - custinuous image surface made up of a matrix of cell values in continuous space. Each layer in general has just 1 attribute that it defines.

### Geographic Attributes
Attributes of entities / features can be classified into following categories
 - Categorical - (political affiliation, age group, income group)
 - ranks - (severity of poverty, risk prediction, severity of assault)
 - counts and amounts - (number of employees at a business, number of people in a house)
 - ratios
   - proportions - generally the ratio of a measured value to another measured value. Eg: ratio of number of people in age 10-25 to total population
   - density - a ratio where the denominator is a spatial measurement. Eg: ratio of number of people to area
