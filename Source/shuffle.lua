local Countries = require "Countries"

print("\nStart\n")

print("\nCreate Deck\n")

buildDeck()
shuffleDeck()
showDeck()

print("\nDrawing Deck\n")

-- print(leftInDeck())
while leftInDeck() >= 4 do
    draw = drawDeck(4)
    for k,v in pairs(draw) do
        print("drawn ", k, v.name)
    end
end
showDeck()

print("\nEnd\n")
