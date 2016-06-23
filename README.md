# Weather for 24 US Cities

## Basic information

* Data scraped from Weather Underground.
* Plotted using Rstudio/ggplot2.

All data taken from the city's nearest airport.

Total downloaded file size is about 30MB. Play with `weather.R`. Remember to set the correct directory using the `setwd()` command at the top of the code. **I have not included the code I used to scrape Wunderground**, mostly because:

* (a) it would probably tick off the website owner if I initiated a Hug of Death,
* (b) the `.csv` files are already present so what's the point, 
* (c) it only works for Linux (scrapes via `wget`), and 
* (d) it's very poorly written garbage that nobody should use anyway.

`weather-indiv.R` is for individual plots, but make sure you read the commented lines.

A few of these plots on the Temperature plot will have "Grey areas" which indicate that the data is out-of-range. So basically too hot or too cold. You can fix this by changing the scale limits, but it makes the other cities a little less beautiful, so I decided against.

If you're wondering how it's possible to have humidity below water's freezing temperature, [you should read this paper \[PDF\]](http://www.rhs.com/papers/RH_WMO.pdf).

## Full Plot Gallery

![Average Daily Temp for US Cities](http://i.imgur.com/qXuq5sN.png)

![Temperature and Humidity Profile for US Cities](http://i.imgur.com/msdgsYD.png)

## Individual cities

I picked the 24 cities based on a balancing act of the following criteria:

* Cities with data-rich sources (some of the best historic data happens to be provided by international airports in the US, so I exclusively used those)
* Cities with high populations (helps with the international airport thing too)
* Cities that are evenly spread throughout the geography of the US. Here's a map of the [US cities](http://i.imgur.com/f6ROfVQ.png) I used.
* Cool (and, well, hot) anomalies like Alaska, Hawaii, and Siberia.

## Individual Plots (Gallery)

Below are individualized plots for 24 of the cities on this file, plus a few more I peppered in after planning to use them and then deciding otherwise. **If you want to request me to do a city, send me a message and I'll see what I can do when I have the time.** Feel free to repost these to your city's subreddit; just give attribution.

[Anchorage](http://imgur.com/a/ghFpa), [Atlanta](http://imgur.com/a/NLMC0), [Baltimore](http://imgur.com/a/Wdqdm), [Billings](http://imgur.com/a/BoFH9), [Bismarck](http://imgur.com/a/WQNkS), [Boston](http://imgur.com/a/X90Zc), [Charleston](http://imgur.com/a/GXfgg), [Chicago](http://imgur.com/a/TxiAU), [Cleveland](http://imgur.com/a/J3Wxv), [Denver](http://imgur.com/a/kRiHh), [El Paso](http://imgur.com/a/1tJ8F), [Honolulu](http://imgur.com/a/xTJvA), [Houston](http://imgur.com/a/l2bND), [Los Angeles](http://imgur.com/a/AzvOA), [Miami](http://imgur.com/a/f22GN), [Minneapolis](http://imgur.com/a/lYwdI), [Nashville](http://imgur.com/a/RyRJa), [New Orleans](http://imgur.com/a/alJq4), [New York City](http://imgur.com/a/ivgFK), [Oklahoma City](http://imgur.com/a/YjvAW), [Philadelphia](http://imgur.com/a/5bKd9), [Phoenix](http://imgur.com/a/Yx7qb), [Portland](http://imgur.com/a/IfNz5), [Rochester](http://imgur.com/a/b8Mrk), [Salt Lake City](http://imgur.com/a/8lC0q), [San Francisco](http://imgur.com/a/NDAjf), [Seattle](http://imgur.com/a/evr7B), [St. Louis](http://imgur.com/a/Zlpq6), [Topeka](http://imgur.com/a/pfq8w)

## Alternate Plots

In addition to these plots, I was able to get some alternate plotting done:

* I was going to do an alt-plot that adjusted for wind chill and heat index, but it looked like it might have been painfully time consuming to tabulate. Perhaps another Redditor can use the data to mess with Texas.
* [Cloud cover for US cities](http://i.imgur.com/3GO2TmE.png), as measured in Oktas. Looks like the only data available in "Okta" units is after 1972.
* [Precipitation for US cities](http://i.imgur.com/nezCst1.png), measured in inches. Shows some very strange rainy seasons in the 70s and the 90s.

## And finally...

* [Proof that it's not always sunny in Philadelphia](http://i.imgur.com/WYOMxpD.png)

## Other Information:

* For international version, [Click here](https://github.com/zonination/weather-intl/)
* For Reddit thread, [Click here](https://np.reddit.com/r/dataisbeautiful/comments/46kjr6/a_tale_of_48_cities_the_the_daily_temperature_and/)
