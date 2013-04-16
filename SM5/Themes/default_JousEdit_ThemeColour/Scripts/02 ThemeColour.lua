red = GetUserPrefN("ThemeColourRed")*10/256;
green = GetUserPrefN("ThemeColourGreen")*10/256;
blue = GetUserPrefN("ThemeColourBlue")*10/256;

TColour = {
	ThemeColour = color(string.format("%f, %f, %f, %f", red, green, blue, "1")),
}