Title: Guide to spatial analysis - Introduction
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

#### Visualization
You can visualize continuous and discrete values by classes. You can create the classes manually, or you can use one of the following statistical techniques to determine the class intervals.

 - **Natural breaks** (Jenks): breaks are chosen along breaking changes in frequency (on a histogram). Thus, each block group on the map is more likely to have similar values.
 - **Quantile**: Each class has the same number of features. Thus higher frequency areas on the histogram have more classes assigned to them. Thus, the values on the ends of the histogram (which typically have low frequency) get clumbed into the same class.
 - **Equal interval**: Equal interval is easy to comprehend when you look at the legend. It splits the histogram with a set number of classes that are equally spaced from one another. On the map, the most features fall under a few number of classes
 - **Standard Deviation**: Breaks are calculated by how many standard deviations they are from the mean. On the map, each group shows how many std each is from the mean.

![map classification schemes](/images/map-classification-schemes.jpg)

Most people can distinguish up to `7` classes on a map. `4` or `5` are great number of classes to reveal patterns.
