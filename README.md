Using XCode 11.2.1

1) using SplitViewController for the requested UI of lanscape device "half for tableview, half for map"
2) JsonMapper: It's helper class for mapping data from json file to Model
3) BaseListPresnter: contains main stuff may any view with list of data would need. I made this because I see that we  have two json file to read data from and load it in to tableView, so there's no need to write stuff twice / Same for BaseListModel
4) CitiesListModel: this file contains fetch data from json logic and search logic. I used binary search "twice" first for geeting first index, and secound for geeting last index in array, after this I can get sub array of results, the time complexity would be (2 log n), and it's better thank swift filter it's time complexity would be (n), although I implemnted it on CitiesListModel+SwiftFilterApproach file, you can replace CitiesListModel presenter class with CitiesListModelFilter and everthing will work normally
5) AboutModel: I changes some stuff from sample, I need it to be more MVP, also I created two data models, one two serialize from json file and another UIModel for using it fill tableview cells
