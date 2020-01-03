1) using SplitViewController for the requested UI of lanscape device "half for tableview, half for map"
2) JsonMapper: It's helper class for mapping data from json file to Model
3) BaseListPresnter: contains main stuff may any view with list of data would need. I made this because I see that we  have two json file to read data from and load it in to tableView, so there's no need to write stuff twice / Same for BaseListModel
