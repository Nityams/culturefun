local Countries = {}

Spain = {name = "Spain", flag = "Assets/Images/Flags/Spain_Flag.png", food = "<insert pic>", greetings = "<insert pic>"}
USA = {name = "USA", flag = "Assets/Images/Flags/United_States_Flag.png", food = "<insert pic>", greetings = "<insert pic>"}
South_Africa= {name = "South_Africa", flag = "Assets/Images/Flags/South_Africa_Flag.png", food = "<insert pic>", greetings = "<insert pic>"}
Mexico = {name = "Mexico", flag = "Assets/Images/Flags/Mexico_Flag.png", food = "<insert pic>", greetings = "<insert pic>"}
Russia = {name = "Russia", flag = "Assets/Images/Flags/Russia_Flag.png", food = "<insert pic>", greetings = "<insert pic>"}
Egypt = {name = "Egypt", flag = "Assets/Images/Flags/Egypt_Flag.png", food = "<insert pic>", greetings = "<insert pic>"}
New_Zealand = {name = "New_Zealand", flag = "Assets/Images/Flags/New_Zealand_Flag.png", food = "<insert pic>", greetings = "<insert pic>"}
UK = {name = "UK", flag = "Assets/Images/Flags/United_Kingdom_Flag.png", food = "<insert pic>", greetings = "<insert pic>"}
Switzerland = {name = "Switzerland", flag = "Assets/Images/Flags/Switzerland_Flag.png", food = "<insert pic>", greetings = "<insert pic>"}
Vietnam = {name = "Vietnam", flag = "Assets/Images/Flags/Vietnam_Flag.png", food = "<insert pic>", greetings = "<insert pic>"}

-- no flags found:
France = {name = "France", flag = "<insert pic>", food = "<insert pic>", greetings = "<insert pic>"}
China = {name = "China", flag = "<insert pic>", food = "<insert pic>", greetings = "<insert pic>"}
Japan = {name = "Japan", flag = "<insert pic>", food = "<insert pic>", greetings = "<insert pic>"}
Brazil = {name = "Brazil", flag = "<insert pic>", food = "<insert pic>", greetings = "<insert pic>"}

table.insert( Countries, Spain)
table.insert( Countries, USA )
table.insert(Countries, South_Africa)
table.insert( Countries, Mexico )
table.insert( Countries, Russia )
table.insert( Countries, Egypt )
table.insert(Countries, New_Zealand)
table.insert( Countries, UK )
table.insert( Countries, Switzerland )
table.insert( Countries, Vietnam )


function Countries.getList()
  for i = 1, #Countries do
    print(i,"=", Countries[i].name, "\n")
  end
end
return Countries
