# Create a bunch of objects
temp <- LETTERS[1:3]
data <- data.frame(x = 1:10, y = 10:1)
p1 <- ggplot(data, aes(x, y)) + geom_point()

# List the objects, and remove them if you wish.
# Here, I listed as exception p1.
get.objects()

# Number of objects in the environment:
length(ls())
rm(list = get.objects(exception = "p1",
                      message = FALSE))
length(ls())
