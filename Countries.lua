local Countries = {}

Spain = {
    name = "Spain",
    flag = "Assets/Images/Flags/Spain_Flag.png",
    food = "Paella",
    greetings_food = "Assets/Images/FoodGame/Dialogs/spanish_dialog.png"
}
USA = {
    name = "USA",
    flag = "Assets/Images/Flags/United_States_Flag.png",
    food = "Apple Pie",
    greetings_food = "Assets/Images/FoodGame/Dialogs/american_dialog.png"
}
South_Africa= {
    name = "South_Africa",
    flag = "Assets/Images/Flags/South_Africa_Flag.png",
    food = "Chakalaka pap",
    greetings_food = "Assets/Images/FoodGame/Dialogs/south_african_dialog.png"
}
Mexico = {
    name = "Mexico",
    flag = "Assets/Images/Flags/Mexico_Flag.png",
    food = "Tamales",
    greetings_food = "Assets/Images/FoodGame/Dialogs/mexican_dialog.png"
}
Russia = {
    name = "Russia",
    flag = "Assets/Images/Flags/Russia_Flag.png",
    food = "Borsch",
    greetings_food = "Assets/Images/FoodGame/Dialogs/russian_dialog.png"
}
Egypt = {
    name = "Egypt",
    flag = "Assets/Images/Flags/Egypt_Flag.png",
    food = "Koshari",
    greetings_food = "Assets/Images/FoodGame/Dialogs/egyptian_dialog.png"
}
New_Zealand = {
    name = "New_Zealand",
    flag = "Assets/Images/Flags/New_Zealand_Flag.png",
    food = "Hangi",
    greetings_food = "Assets/Images/FoodGame/Dialogs/new-zealand_dialog.png"
}
UK = {
    name = "UK",
    flag = "Assets/Images/Flags/United_Kingdom_Flag.png",
    food = "Fish and Chips",
    greetings_food = "Assets/Images/FoodGame/Dialogs/british_dialog.png"
}
Switzerland = {
    name = "Switzerland",
    flag = "Assets/Images/Flags/Switzerland_Flag.png",
    food = "Cheese Fondue",
    greetings_food = "Assets/Images/FoodGame/Dialogs/swiss_dialog.png"
}
Vietnam = {
    name = "Vietnam",
    flag = "Assets/Images/Flags/Vietnam_Flag.png",
    food = "Pho",
    greetings_food = "Assets/Images/FoodGame/Dialogs/vietnamese_dialog.png"
}

-- no flags found:
France = {
    name = "France",
    flag = "<insert pic>",
    food = "<insert pic>",
    greetings_food = "<insert pic>"
}
China = {
    name = "China",
    flag = "<insert pic>",
    food = "<insert pic>",
    greetings_food = "<insert pic>"
}
Japan = {
    name = "Japan",
    flag = "<insert pic>",
    food = "<insert pic>",
    greetings_food = "<insert pic>"
}
Brazil = {
    name = "Brazil",
    flag = "<insert pic>",
    food = "<insert pic>",
    greetings_food = "<insert pic>"
}

table.insert(Countries, Spain) --Paella
table.insert(Countries, USA)  -- Apple Pie
table.insert(Countries, South_Africa) --Chakalaka & pap
table.insert(Countries, Mexico) --Tamales
table.insert(Countries, Russia) --Borsch
table.insert(Countries, Egypt)  --Koshari
table.insert(Countries, New_Zealand)  --Hangi
table.insert(Countries, UK)   --Fish and Chips
table.insert(Countries, Switzerland) --Cheese fondue
table.insert(Countries, Vietnam)  --Pho

-- No flags found
-- table.insert(Countries, France)
-- table.insert(Countries, China)
-- table.insert(Countries, Japan)
-- table.insert(Countries, Brazil)


function Countries.getList()
  for i = 1, #Countries do
    print(i, "=", Countries[i].name, "\n")
  end
end
return Countries
