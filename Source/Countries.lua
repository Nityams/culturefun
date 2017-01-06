local Countries = {}
local deck = {}

local Austraila = {
  name = "Austraila",
  flag = "Assets/Images/Flags/Australia_Flag.png",
  food = "Barramundi",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Hello",
  coordinates = {lat = -35.31, lon = 149.12}, -- Canberra @ 35° 18.45' S, 149° 7.47'° E
  fun_fact = {
    "Did you know, Australia is the world’s 6th largest country by size?",
    "Finding Nemo takes place in the world’s largest reef system,the Great Barrier Reef. It is located on the north-eastern coast of Australia!"
  }
}

local Brazil = {
  name = "Brazil",
  flag = "Assets/Images/Flags/Brazil_Flag.png",
  food = "Feijoada",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Olá",
  coordinates = {lat = -15.79, lon = -47.88}, -- Brasília @ 15° 47.65' S, -47° 52.93' W
  fun_fact = {
    "Did you know, Brazil is the largest country in South America!",
    "The 2016 Olympic Games took place in Rio de Janeiro, Brazil!"
  }
}

local Canada = {
  name = "Canada",
  flag = "Assets/Images/Flags/Canada_Flag.png",
  food = "Poutine",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Hello",
  coordinates = {lat = 45.42, lon = -75.70}, -- Ottawa @ 45° 25.29 ' N, 75° 41.83' W
  fun_fact = {
    "Did you know, the maple leaf is a major Canadian symbol and is featured on Canada’s flag!",
    "Fun Fact: Ice hockey is the most popular sport in Canada!"
  }
}

local China = {
  name = "China",
  flag = "Assets/Images/Flags/China_Flag.png",
  food = "Dumplings",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Nǐ hǎo",
  coordinates = {lat = 39.90, lon = 116.41}, -- Beijing @ 39° 54.25' N, 116° 24.44' E
  fun_fact = {
    "Did you know, the Great Wall of China is actually not visible from space?",
    "China is the 3rd country to send someone to space!"
  }
}

local Croatia = {
  name = "Croatia",
  flag = "Assets/Images/Flags/Croatia_Flag.png",
  food = "Cobanac",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Dobrodošli",
  coordinates = {lat = 48.86, lon = 2.35}, -- Zagreb @ 48° 51.39 N, 2° 21.13 E
  fun_fact = {
    "Did you know, the breed of dog from the movie 101 Dalmatians came from Croatia?",
    "Fun fact: Pens were invented in Croatia by Slavoljub Penkala"
  }
}

local DominicanRepublic = {
  name = "Dominican Republic",
  flag = "Assets/Images/Flags/Dominican_Republic_Flag.png",
  food ="Sancocho",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Hola",
  coordinates = {lat = 18.49, lon = -69.93}, -- Santo Domingo @ 18° 29.16348' N, 69° 55.87 W
  fun_fact = {
    "Baseball is the most popular sport in the Dominican Republic!",
    "Fun Fact: the famous amber piece in Jurassic Park can be found at the Amber Museum in Puerto Plata! "
  }
}

local EastTimor = {
  name = "East Timor",
  flag = "Assets/Images/Flags/East_Timor_Flag.png",
  food ="Batar daan",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Elo",
  coordinates = {lat = -8.56, lon = 125.56}, -- Dili
  fun_fact = {
    "East Timor recently gained their independence in 2002!",
    "Dili is the capital city of East Timor!"
  }
}

local Egypt = {
  name = "Egypt",
  flag = "Assets/Images/Flags/Egypt_Flag.png",
  food = "Koshari",
  greetings_food = "Assets/Images/FoodGame/Dialogs/egyptian_dialog.png",
  greeting = "Marhabaan",
  coordinates = { lat = 30.03, lon = 31.22 },  -- Cairo @ 30°2′N 31°13′E
  fun_fact = {
    "Did you know, the longest river in the world, the Nile, runs through Egypt!",
    "Fun Fact: One of the Seven Wonders of the Ancient world, the Great Pyramid of Giza, is located in Egypt!"
  }
}

local ElSalvador = {
  name = "El Salvador",
  flag = "Assets/Images/Flags/El_Salvador_Flag.png",
  food = "Panes Rellenos",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "buenos dias!",
  coordinates = { lat = 13.69, lon = -89.22 },  -- San Salvador
  fun_fact = {
    "Fun Fact: El Salvador is known as the Land of the Volcanoes!",
    "Did you know, El Salvador only has two seasons, one from May to October and the other from November to April?"
  }
}

local France = {
  name = "France",
  flag = "Assets/Images/Flags/France_Flag.png",
  food = "Cassoulet",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Bonjour",
  coordinates = {lat = 48.86, lon = 2.35}, -- Paris @48° 51.40 N, 2° 21.13 E
  fun_fact = {
    "Did you know, the Eiffel Tower is located in France’s capital, Paris?",
    "Fun Fact: The Mona Lisa, is housed in Paris, France!  Vive la France! (Long live France!)"
  }
}

local Georgia = {
  name = "Georgia",
  flag = "Assets/Images/Flags/Georgia_Flag.png",
  food = "Khinkali",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "buenos dias!",
  coordinates = { lat = 41.72, lon = 44.83 },  -- Tbilisi
  fun_fact = {
    "Tbilisi is Georgia’s largest capital and city!",
    "Fun Fact: The world’s deepest cave, the Voronya Cave is located in Georgia"
  }
}

local Germany = {
  name = "Germany",
  flag = "Assets/Images/Flags/Germany_Flag.png",
  food = "Rouladen",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Hallo",
  coordinates = { lat =52.52 , lon = 13.41}, -- Berlin @ 52° 31.20'N, 13° 24.30' E
  fun_fact = {
    "Did you know, over 100 German were awarded the Nobel prize including Albert Einstein?",
    "Fun Fact: Germany has been home to famous composers such as Johann Bach and Ludwig van Beethoven!"
  }
}

local Guatemala = {
  name = "Guatemala",
  flag = "Assets/Images/Flags/Guatemala_Flag.png",
  food = "Pastel de banano",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Hola",
  coordinates = { lat =14.63 , lon = -90.51}, -- Guatemala City @ 14° 38.10'N, 90° 30.41' W
  fun_fact = {
    "Did you know the name Guatemala comes from a word meaning ‘a place of many trees’?",
    "Fun Fact: The first chocolate bar was invented in Guatemala during the Mayan time!"
  }
}

local Haiti = {
  name = "Haiti",
  flag = "Assets/Images/Flags/Haiti_Flag.png",
  food = "Bean purée",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Alo",
  coordinates = { lat =18.59 , lon = -72.31}, -- Port-au-Prince @ 18° 35.67'N, 72° 18.45' W
  fun_fact = {
    "Soccer is Haiti’s national sport!",
    "The official languages of Haiti include French and Haitian Creole."
  }
}

local Honduras = {
  name = "Honduras",
  flag = "Assets/Images/Flags/Honduras_Flag.png",
  food = "Pastelitos",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Hola",
  coordinates = { lat =14.07 , lon = -87.19}, -- Tegucigalpa @ 14° 4.34'N, 87° 11.53' W
  fun_fact = {
    "Fun Fact: Honduras is also known as the Banana Republic",
    "Did you know, it rains fishes in the tiny town of Yoro at least once a year? "
  }
}

local Hungary = {
  name = "Hungary",
  flag = "Assets/Images/Flags/Hungary_Flag.png",
  food = "Lángos",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Helló",
  coordinates = { lat =47.50 , lon = 19.04}, -- Budapest @ 47° 29.87'N, 19° 2.41' E
  fun_fact = {
    "Fun Fact: the Rubik’s cube was invented in Hungary by Emo Rubik! ",
    "Typically, people introduce themselves last name first. "
  }
}

local Italy = {
  name = "Italy",
  flag = "Assets/Images/Flags/Italy_Flag.png",
  food = "Pasta",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Ciao",
  coordinates = { lat =41.90 , lon = 12.50}, -- Rome @ 41° 54.17'N, 12° 29.78' E
  fun_fact = {
    "Did you know, city-states such as the Vatican City and San Marino are located in Italy?",
    "Fun Fact: Leonardo Da Vinci was born and raised in Italy"
  }
}

local Japan = {
  name = "Japan",
  flag = "Assets/Images/Flags/Japan_Flag.png",
  food = "Sushi",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Kon'nichiwa",
  coordinates = { lat =35.69 , lon = 139.69}, -- Tokyo @ 35° 41.37'N, 139° 41.50' E
  fun_fact = {
    "Did you know, Sumo wrestling is the national sport of Japan but Baseball is the most popular?",
    "Fun Fact: Foods such as sushi, sashimi and tempura came from Japan!"
  }
}

local Kazakhstan = {
  name = "Kazakhstan",
  flag = "Assets/Images/Flags/Kazakhstan_Flag.png",
  food = "Besbarmak",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Sälem!",
  coordinates = { lat =51.16 , lon = 71.47}, -- Astana @ 51° 9.63'N, 71° 28.22' E
  fun_fact = {
    "Ancient Kazakhs were the first people to tame and ride horses!",
    "Fun Fact: Snow Leopards are a national symbol of Kazakhstan! (They're very pretty)"
  }
}

local Kenya = {
  name = "Kenya",
  flag = "Assets/Images/Flags/Kenya_Flag.png",
  food = "Ugali",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Jambo!",
  coordinates = { lat =-1.29, lon = 36.82}, -- Nairobi @ 1° 17.52'S, 36° 49.32' E
  fun_fact = {
    "Nairobi is the largest city and capital of Kenya!",
    "Fun Fact: Kenya only has two seasons, a rainy and dry season!"
  }
}

local Laos = {
  name = "Laos",
  flag = "Assets/Images/Flags/Laos_Flag.png",
  food = "Ping Kai",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "sabaidee!",
  coordinates = { lat =-17.97, lon = 102.63}, -- Vientiane @ 17° 58.54' N, 102° 37.99' E
  fun_fact = {
    "The Laotian New Year is celebrated for three whole days! April 13th to 15th!",
    "Fun Fact: There is an area where there are over 300 giant jars of unknown origin! "
  }
}

local Liberia = {
  name = "Liberia",
  flag = "Assets/Images/Flags/Liberia_Flag.png",
  food = "Fufu",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Hello!",
  coordinates = { lat = 34.14, lon = -118.00}, -- Monrovia @ 34° 8.66' N, 118° 0.12' W
  fun_fact = {
    "Did you know, The Liberian flag is designed after the American flag?",
    "Fun Fact: Liberia is a bird-haven where more than 700 bird species reside!"
  }
}

local Luxembourg = {
  name = "Luxembourg",
  flag = "Assets/Images/Flags/Luxembourg_Flag.png",
  food = "F'rell Am Rèisleck",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Salut!",
  coordinates = { lat = 49.61, lon = 6.13}, -- Luxembourg City @ 49° 36.70' N, 6° 7.92' E
  fun_fact = {
    "Fun Fact: Luxembourg was named the European Capital of Culture in 1995 and in 2007!",
    "Did you know, forests cover more than 1/3rd of the country?"
  }
}

local Macedonia = {
  name = "Macedonia",
  flag = "Assets/Images/Flags/Macedonia_Flag.png",
  food = "Burek",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Zdravo!",
  coordinates = { lat = 42.00, lon = 21.42}, -- Skopje@ 41° 59.84' N, 21° 25.68' E
  fun_fact = {
    "The Millennium Cross being 66 metre, is the biggest cross in the world!",
    "Did you know, sidewalks in Macedonia are used for parking but not walking?"
  }
}

local Madagascar = {
  name = "Madagascar",
  flag = "Assets/Images/Flags/Madagascar_Flag.png",
  food = "Romazava",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Manahoana!",
  coordinates = { lat = -18.88, lon = 47.51}, -- Antananarivo@ 18° 52.75' S, 47° 30.47' E
  fun_fact = {
    "Did you know, Madagascar is the fourth largest island in the world?",
    "Fun Fact:  Madagascar has two seasons, one lasting from May to October and the other from November to April"
  }
}

local Malaysia = {
  name = "Malaysia",
  flag = "Assets/Images/Flags/Malaysia_Flag.png",
  food = "Satay",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Selamat pagi",
  coordinates = { lat = 3.14, lon = 101.69}, -- Kuala Lumpur @ 3° 8.34' N, 101° 41.21 E
  fun_fact = {
    "Did you know, the national animal of Malaysia is the endangered Malayan tiger? SAVE THE TIGERS!",
    "Fun Fact: Malaysia is located on two landmasses separated by the South China Sea?"
  }
}

local Maldives = {
  name = "Maldives",
  flag = "Assets/Images/Flags/Maldives_Flag.png",
  food = "Bis keemiyaa",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Assalaamu Alaikum!",
  coordinates = { lat = 4.18, lon = 73.51}, -- Malé @ 4° 10.53' N, 73° 30.56' E
  fun_fact = {
    "Fun Fact: Maldives is the lowest and flattest country in the world!",
    "Did you know, Maldives held the first underwater meeting to raise awareness on climate change?"
  }
}

local Mexico = {
  name = "Mexico",
  flag = "Assets/Images/Flags/Mexico_Flag.png",
  food = "Tamales",
  greetings_food = "Assets/Images/FoodGame/Dialogs/mexican_dialog.png",
  greeting = "Hola",
  coordinates = { lat = 19.43, lon = -99.13 }, -- Mexico City @ 19°26′N 99°08′W
  fun_fact = {
    "Did you know, Mexico City is built over the ruins of an Aztec City, Tenochtitlan?",
    "Fun Fact: The main language spoken in Mexico is Spanish!"
  }
}

local Mongolia = {
  name = "Mongolia",
  flag = "Assets/Images/Flags/Mongolia_Flag.png",
  food = "Khorkhog",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Сайн уу!",
  coordinates = { lat = 47.89, lon = 106.91}, -- Ulaanbaatar @ 47° 53.18' N, 106° 54.34' E
  fun_fact = {
    "Fun Fact: The Bogd Khan National Park is the oldest National Park in the world!",
    "Did you know, gerbils run around as wild animals in Mongolia?"
  }
}

local Montenegro = {
  name = "Montenegro",
  flag = "Assets/Images/Flags/Montenegro_Flag.png",
  food = "Kacamak",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Zdravo!",
  coordinates = { lat = 42.43, lon = 19.26}, -- Podgorica @ 42° 25.83' N, 19° 15.56' E
  fun_fact = {
    "The name Montenegro originated from the dark mountain forests that cover the land!",
    "The Grand Canyon of Tara River in Montenegro is the second largest canyon in the world!"
  }
}

local Morocco = {
  name = "Morocco",
  flag = "Assets/Images/Flags/Morocco_Flag.png",
  food = "B’ssara",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "ṣbah lkḥīr!",
  coordinates = { lat = 33.97, lon = -6.84}, -- Rabat @ 33° 58' N, 6° 51' W
  fun_fact = {
    "Did you know, in Morocco it is impolite to say no to meat if it is offered at a meal? ",
    "Fun fact: The most popular sport in Morocco is football(soccer)!"
  }
}

local Mozambique = {
  name = "Mozambique",
  flag = "Assets/Images/Flags/Mozambique_Flag.png",
  food = "Matapa",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Hola!",
  coordinates = { lat = -25.89, lon = 32.60}, -- Maputo @ 25° 54 S, 32° 36' E
  fun_fact = {
    "Maputo is the largest city and the capital city of Mozambique",
    "The official language of Mozambique is Portuguese!"
  }
}

--food not found!!!
-- local Nauru = {
--   name = "Nauru",
--   flag = "Assets/Images/Flags/Nauru_Flag.png",
--   --food = "",
--   greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
--   greeting = "Ekamowir Omo!",
--   coordinates = { lat = -0.55, lon = 166.92}, -- Yaren District @ 0°32 S, 166° 55' E
--   fun_fact = {
--     "Fun Fact: Nauru is the world’s smallest island nation",
--     "Nauru is the only republican state without an official capital!"
--   }
-- }

local Netherlands = {
  name = "Netherlands",
  flag = "Assets/Images/Flags/Netherlands_Flag.png",
  food = "Poffertjes",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Ekamowir Omo!",
  coordinates = { lat = 52.37, lon = 4.90}, -- Amsterdam @ 52° 22' N, 4° 54' E
  fun_fact = {
    "Amsterdam is the largest city and capital of the Netherlands!",
    "Did you know, Amsterdam is built entirely on wooden poles?"
  }
}

local New_Zealand = {
  name = "New Zealand",
  flag = "Assets/Images/Flags/New_Zealand_Flag.png",
  food = "Hangi",
  greetings_food = "Assets/Images/FoodGame/Dialogs/new-zealand_dialog.png",
  greeting = "Hallo",
  coordinates = { lat = -41.28, lon = 174.45 },  -- Wellington @ 41°17′S 174°27′E
  fun_fact = {
    "Did you know, Kiwi is a nickname for New Zealanders?",
    "Fun Fact: The Lord of the Rings movies were filmed in New Zealand!"
  }
}

local Nigeria = {
  name = "Nigeria",
  flag = "Assets/Images/Flags/Nigeria_Flag.png",
  food = "Jollof rice",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Hello!",
  coordinates = { lat = 9.08, lon = 7.40}, -- Abuja @ 9° 4' N, 7° 24' E
  fun_fact = {
    "English, is the official language of Nigeria!",
    "Fun Fact: Nigeria is one of human existence oldest locations!"
  }
}

local Norway = {
  name = "Norway",
  flag = "Assets/Images/Flags/Norway_Flag.png",
  food = "Røkt Laks",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Hallo!",
  coordinates = { lat = 59.91, lon = 10.75}, -- Oslo @ 59° 55' N, 10° 45' E
  fun_fact = {
    "Football (soccer) is the most played sport in Norway!",
    "Did you know that polar bears and reindeers can be found in Norway?"
  }
}

local Palau = {
  name = "Palau",
  flag = "Assets/Images/Flags/Palau_Flag.png",
  food = "Pichi-pichi",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Alii!",
  coordinates = { lat = 7.50, lon = 134.62}, -- Ngerulmud @ 7° 30' N, 134° 37' E
  fun_fact = {
    "The Milky Way Lagoon has millions of golden jellyfish that move horizontally across the lake daily! ",
    "The Floating Garden Islands, is made up of limestone and used to be a coral reef!"
  }
}

local Peru = {
  name = "Peru",
  flag = "Assets/Images/Flags/Peru_Flag.png",
  food = "Ceviche",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Quechua !",
  coordinates = { lat = -12.05, lon = -77.04}, -- Lima @ 12° 3' S, 77° 3' W
  fun_fact = {
    "Lake Titicaca in Southern Peru is South America’s largest lake!",
    "Did you know, Peru is home to the most bird species in the world?"
  }
}

local Philippines = {
  name = "Philippines",
  flag = "Assets/Images/Flags/Philippines_Flag.png",
  food = "Adobo",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "kumusta ka!",
  coordinates = { lat = 14.60, lon = 120.98}, -- Manila @ 14° 36' N, 120° 59' E
  fun_fact = {
    "The national symbol of the Philippines is the Philippine eagle which are the largest eagles in the world!",
    "Fun Fact: The Philippines are the world’s leading producer of coconuts!"
  }
}

local Portugal = {
  name = "Portugal",
  flag = "Assets/Images/Flags/Portugal_Flag.png",
  food = "Caldo Verde",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Boa tarde!",
  coordinates = { lat = 38.72, lon = -9.14}, -- Lisbon
  fun_fact = {
    "Did you know, the oldest bookstore in the world is in Portugal’s capital, Lisbon?",
    "Portugal's only neighbor is Spain which is to the East! "
  }
}

local Russia = {
  name = "Russia",
  flag = "Assets/Images/Flags/Russia_Flag.png",
  food = "Borsch",
  greetings_food = "Assets/Images/FoodGame/Dialogs/russian_dialog.png",
  greeting = "Zdravstvuyte",
  coordinates = { lat = 55.75, lon = 37.62 },  -- Moscow @ 55°45′N 37°37′E
  fun_fact = {
    "Did you know, in Russia it is believed to be a bad omen to shake hands over a doorway?",
    "Fun Fact: the world’s first satellite, Sputnik, was launched by the Soviet Union (now Russia)!"
  }
}

local Saudi_Arabia = {
  name = "Saudi Arabia",
  flag = "Assets/Images/Flags/Saudi_Arabia_Flag.png",
  food = "Kabsa",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Marhaba!",
  coordinates = { lat = 24.71, lon = 46.68}, -- Riyadh
  fun_fact = {
    "Fun Fact: Saudi Arabia is the birthplace of Islam and home to the Mecca and Medina",
    "Did you know, Saudi Arabia is the largest country in the world without a river?"
  }
}

local Serbia = {
  name = "Serbia",
  flag = "Assets/Images/Flags/Serbia_Flag.png",
  food = "PLJESKAVICA",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Zdravo!",
  coordinates = { lat = 44.79, lon = 20.45}, -- Belgrade
  fun_fact = {
    "Fun Fact: the name “Serbia” is Greek for “Land of the Serbs”",
    "Did you know, famous scientists like Nikola Tesla were from Serbia?"
  }
}

local Singapore = {
  name = "Singapore",
  flag = "Assets/Images/Flags/Singapore_Flag.png",
  food = "Bak Kut Teh",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Ni hao!",
  coordinates = { lat = 1.35, lon = 103.82},
  fun_fact = {
    "Singapore is one of three surviving city-states in the world!",
    "Fun Fact: The National University of Singapore has the world’s first ‘Hug me’ Coca-Cola machine that gives you Cola for every hug you give it!"
  }
}

local Slovakia = {
  name = "Slovakia",
  flag = "Assets/Images/Flags/Slovakia_Flag.png",
  food = "Halušky",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Ahoj!",
  coordinates = { lat = 48.15, lon = 17.11}, -- Bratislava
  fun_fact = {
    "Fun Fact: there are more than 6000 caves in Slovakia!",
    "Did you know, Slovakia’s capital Bratislava borders two other countries; Austria and Hungary?"
  }
}

local Slovenia = {
  name = "Slovenia",
  flag = "Assets/Images/Flags/Slovenia_Flag.png",
  food = "Bujta repa ",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "zdravo!",
  coordinates = { lat = 46.06, lon = 14.50}, -- Ljubljana
  fun_fact = {
    "Fun Fact: The oldest vine in the world is in Maribor, Slovenia!",
    "The most famous wedding place in Slovenia is the island in Lake Bled, where the groom must carry the bride up 99 steps and the bride must remain quiet to ensure a happy and long marriage."
  }
}

local South_Africa= {
  name = "South Africa",
  flag = "Assets/Images/Flags/South_Africa_Flag.png",
  food = "Chakalaka pap",
  greetings_food = "Assets/Images/FoodGame/Dialogs/south_african_dialog.png",
  greeting = "Hello",
  coordinates = { lat = -26.44, lon = 28.06 },  -- Johannesburg @ 26°12′16″S 28°2′44″E
  fun_fact = {
    "Fun Fact: South Africa has three capital cities; Cape Town, Bloemfontein and Pretoria!",
    "South Africa is the only country in the world to have hosted the Soccer, Cricket and Rugby World Cup!"
  }
}

local Korea = {
  name = "Korea",
  flag = "Assets/Images/Flags/South_Korea_Flag.png",
  food = "Kimchi",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Yeoboseyo",
  coordinates = {lat = 37.57, lon = 126.98}, --Seoul
  fun_fact = {
    "During the university entrance exam, family and friends of high school students give them sticky candy for good fortune!",
    "Fun Fact: Koreans are pretty good at video games..."
  }
}

local Spain = {
  name = "Spain",
  flag = "Assets/Images/Flags/Spain_Flag.png",
  food = "Paella",
  greetings_food = "Assets/Images/FoodGame/Dialogs/spanish_dialog.png",
  greeting = "Hola",
  coordinates = { lat = 40.43, lon = -3.70 },  -- Madrid @ 40°26′N 3°42′W
  fun_fact = {
    "Did you know, the world’s oldest restaurant, Botin Restaurant, is located in Madrid Spain?",
    "Madrid is the largest city and capital of Spain!"
  }
}

local Switzerland = {
  name = "Switzerland",
  flag = "Assets/Images/Flags/Switzerland_Flag.png",
  food = "Cheese Fondue",
  greetings_food = "Assets/Images/FoodGame/Dialogs/swiss_dialog.png",
  greeting = "Bonjour",
  coordinates = { lat = 46.95, lon = 7.45},  -- Bern @ 46°57′N 7°27′E
  fun_fact = {
    "There are taxes for owning a dog in Switzerland!",
    "Did you know, Switzerland is one of only two countries to have a square flag?"
  }
}

local Syria = {
  name = "Syria",
  flag = "Assets/Images/Flags/Syria_Flag.png",
  food = "Fattoush",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "ahlan!",
  coordinates = { lat = 33.51, lon = 36.27}, -- Damascus
  fun_fact = {
    "Did you know, the largest lake in Syria, Lake Assad, is man made?",
    "Fun Fact: Syria’s capital, Damascus, is called the Jasmine City!"
  }
}

local Taiwan = {
  name = "Taiwan",
  flag = "Assets/Images/Flags/Taiwan_Flag.png",
  food = "Gua bao",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "ni hao!",
  coordinates = { lat = 25.03, lon = 121.56}, -- Taipei
  fun_fact = {
    "Fun Fact: In Taiwan, the teachers switch classes, not the students!",
    "Did you know, it takes around 8 hours to drive around the whole island?"
  }
}

local Thailand = {
  name = "Thailand",
  flag = "Assets/Images/Flags/Thailand_Flag.png",
  food = "Som Tum",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "S̄wạs̄dī",
  coordinates = {lat = 13.75, lon = 100.50}, --Bangkok
  fun_fact = {
    "Fun Fact: Siamese cats originated in Thailand!",
    "Elephants are Thailand’s national symbol!"
  }
}

local Ukraine = {
  name = "Ukraine",
  flag = "Assets/Images/Flags/Ukraine_Flag.png",
  food = "Varenyky",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Dobryy den'!",
  coordinates = { lat = 50.45, lon = 30.52}, -- Kiev
  fun_fact = {
    "The official language is Ukrainian but most people are bilingual and speak Russian!",
    "Ukraine has the deepest metro station in the world!"
  }
}

local UK = {
  name = "United Kingdom",
  flag = "Assets/Images/Flags/United_Kingdom_Flag.png",
  food = "Fish and Chips",
  greetings_food = "Assets/Images/FoodGame/Dialogs/british_dialog.png",
  greeting = "Hello",
  coordinates = { lat = 51.62, lon = -0.12 },  -- London @ 51°30′N 0°7′W
  fun_fact = {
    "Fun Fact: In the UK, if you reach 100 years old, you will get a personalized card from the Queen!",
    "London’s subway, the “Tube” is one of the oldest in the world!"
  }
}

local USA = {
  name = "U.S.A",
  flag = "Assets/Images/Flags/United_States_Flag.png",
  food = "Apple Pie",
  greetings_food = "Assets/Images/FoodGame/Dialogs/american_dialog.png",
  greeting = "Hello",
  coordinates = { lat = 38.88, lon = -77.02 },  -- Washington, D.C. @ 38°53′N 77°01′W
  fun_fact = {
    "The first man to walk on the moon was the American Neil Armstrong.",
    "The U.S. has the longest border in the world with Canada but the border is not a straight line!"
  }
}

local Uruguay = {
  name = "Uruguay",
  flag = "Assets/Images/Flags/Uruguay_Flag.png",
  food = "Chivito",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Hola!",
  coordinates = { lat = -34.90, lon = -56.16}, -- Montevideo
  fun_fact = {
    "Fun Fact: There are three cows for every person in the country!",
    "Did you know, there are more sheep and humans in Uruguay?"
  }
}

local Vatican = {
  name = "Vatican City",
  flag = "Assets/Images/Flags/Vatican_City_Flag.png",
  food = "Cannoli",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Ciao!",
  coordinates = { lat = 41.90, lon = 12.45},
  fun_fact = {
    "Vatican City is the smallest country in the world and is one of three surviving city-states!",
    "Did you know, Vatican City is the home of the Pope, the religious leader of the Catholic world!"
  }
}

local Vietnam = {
  name = "Vietnam",
  flag = "Assets/Images/Flags/Vietnam_Flag.png",
  food = "Pho",
  greetings_food = "Assets/Images/FoodGame/Dialogs/vietnamese_dialog.png",
  greeting = "Chao ban",
  coordinates = { lat = 21.03, lon = 105.85 },  -- Hanoi @ 21°2′N 105°51′E
  fun_fact = {
    "Did you know the Tortoise is a lucky symbol in Vietnam?",
    "Fun Fact: Vietnam is home to the world’s largest cave, the Son Doong!"
  }
}

local Zimbabwe = {
  name = "Zimbabwe",
  flag = "Assets/Images/Flags/Zimbabwe_Flag.png",
  food = "Sadza",
  greetings_food = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png",
  greeting = "Hello!",
  coordinates = { lat = -17.83, lon = 31.03}, -- Harare
  fun_fact = {
    "The largest Waterfall in the world, Victoria Falls, is in Zimbabwe!",
    "Fun Fact: Zimbabwe means 'Great House of Stones'"
  }
}

--Alphabetical Insertion of Countries into Countries Table listing

table.insert(Countries, Austraila)
table.insert(Countries, Brazil)
table.insert(Countries, Canada)
table.insert(Countries, China)
table.insert(Countries, Croatia)
table.insert(Countries, DominicanRepublic)
table.insert(Countries, EastTimor)
table.insert(Countries, Egypt)  --Koshari
table.insert(Countries, ElSalvador)
table.insert(Countries, France)
table.insert(Countries, Georgia)
table.insert(Countries, Germany)
table.insert(Countries, Guatemala)
table.insert(Countries, Haiti)
table.insert(Countries, Honduras)
table.insert(Countries, Hungary)
table.insert(Countries, Italy)
table.insert(Countries, Japan)
table.insert(Countries, Kazakhstan)
table.insert(Countries, Kenya)
table.insert(Countries, Laos)
table.insert(Countries, Liberia)
table.insert(Countries, Luxembourg)
table.insert(Countries, Macedonia)
table.insert(Countries, Madagascar)
table.insert(Countries, Malaysia)
table.insert(Countries, Maldives)
table.insert(Countries, Mexico) --Tamales
table.insert(Countries, Mongolia)
table.insert(Countries, Montenegro)
table.insert(Countries, Morocco)
table.insert(Countries, Mozambique)
table.insert(Countries, Nauru)
table.insert(Countries, Netherlands)
table.insert(Countries, New_Zealand)
table.insert(Countries, Nigeria)
table.insert(Countries, Norway)
table.insert(Countries, Palau)
table.insert(Countries, Peru)
table.insert(Countries, Philippines)
table.insert(Countries, Portugal)
table.insert(Countries, Russia) --Borsch
table.insert(Countries, Saudi_Arabia)
table.insert(Countries, Serbia)
table.insert(Countries, Singapore)
table.insert(Countries, South_Africa) --Chakalaka & pap
table.insert(Countries, Korea) -- Should be changed to south Korea
table.insert(Countries, Spain) --Paella
-- table.insert(Countries, Sudan) -- Need to Find Info
table.insert(Countries, Switzerland) --Cheese fondue
table.insert(Countries, Taiwan)
table.insert(Countries, New_Zealand)  --Hangi
table.insert(Countries, Ukraine)
table.insert(Countries, UK)   --Fish and Chips
table.insert(Countries, USA)  -- Apple Pie
table.insert(Countries, Uruguay)
table.insert(Countries, Vatican)
table.insert(Countries, Vietnam)  --Pho
table.insert(Countries, Zimbabwe)


-- No flags or dialog
-- table.insert(Countries, France)
-- table.insert(Countries, China)
-- table.insert(Countries, Japan)
-- table.insert(Countries, Brazil)

-- Print out contents of Countries and Deck tables
function showCountries()
  for i,v in ipairs(Countries) do
    print(i, v.name)
  end
end
function showDeck()
  for i,v in ipairs(deck) do
    print(i, v.name)
  end
end
function showTable(t)
  for i,v in ipairs(t) do
    print(i, v.name)
  end
end

-- Clear current deck and create new one from Countries
function buildDeck()
  -- Discard
  deck = {}
  -- Build
  for i,v in ipairs(Countries) do
    deck[i] = v
  end
end

-- Randomizes deck order
function shuffleDeck()
  -- Ok I get this
  math.randomseed(os.time())
  local rand = math.random

  -- What is going on
  local iterations = #deck
  local j

  -- Black magic I say
  for i = iterations, 2, -1 do
    j = rand(i)
    deck[i], deck[j] = deck[j], deck[i]
  end
end

-- Remove a number of countries from the deck
function drawDeck(count)
  draw = {}
  for i=1,count do
    -- Removing table element shifts all elements, so index 1
    draw[i] = deck[1]
    table.remove(deck, 1)
  end
  return draw
end

-- Number of cards left in the deck
function leftInDeck()
  count = 0
  for i,v in ipairs(deck) do
    count = count + 1
  end
  return count
end

return Countries
