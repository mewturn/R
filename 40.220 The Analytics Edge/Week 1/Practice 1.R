## 40.220 The Analytics Edge taught by Natarajan Karthik
## Summer 2017
## Practice 1 
## Completed by Milton Li

## QUESTION 1 ##
x <- c(4,2,6)
y <- c(1,0,-1)

#length of x: 3 elements
length(x)

#sum up every element of x = 12
sum(x)

#multiply each x termwise by itself and sum up every element: 56
sum(x^2)

#add each x and y termwise = 5 2 5
x+y

#multiply each x and y termwise = 4 0 -6
x*y

#subtract each x termwise by 2 = 2 0 4
x-2

#multiply each x termwise by itself = 16 4 36
x^2

#x1*y1 x2*y2 x3*y1 = 4 0 6
x*y[1:2]

## QUESTION 2 ##
#sequence of 7 to 11 in intervals of +1 = 7 8 9 10 11
7:11

#sequence of 2 to 9 in intervals of +1 = 2 3 4 ... 9
seq(2,9)

#sequence of 4 to 10 in intervals of +2 = 4 6 8 10
seq(4,10,by=2)

#sequence of 3 to 30 with 10 points = 3 6 9 12 ... 30
seq(3,30,length=10)

#sequence of 6 to -4 in intervals of -2 = 6 4 2 0 -2 -4
seq(6,-4,by=-2)

## QUESTION 3 ##
#repeat 2 by 4 times = 2 2 2 2
rep(2,4)

#repeat 1 5 by 4 times = 1 5 1 5 1 5 1 5
rep(c(1,5),4)

#repeat 1 by 4 times and then 2 by 5 times
rep(c(1,2),c(4,5))

## QUESTION 4 ##
x <- c(5,9,2,3,4,6,7,0,12,2,9)

#2nd element of x = 9
x[2]

#2nd to 4th elements of x = 9 2 3
x[2:4]

#2nd, 3rd and 6th elements of x = 9 2 6
x[c(2,3,6)]

#1st to 5th elements of x and 10th to 12th elements of x
#5 9 2 3 4 2 9 NA
x[c(1:5,10:12)]

#everything except the 10th to 12th elements of x
#5 9 2 3 4 6 7 0 8 12
x[-(10:12)]

## QUESTION 5 ##
#When creating a matrix, contents are filled along columns
# [3   2]
# [-1 -1]
x <- matrix(c(3,-1,2,-1), nrow=2, ncol=2)

# [1 4  0]
# [0 1 -1]
y <- matrix(c(1,0,4,1,0,-1), nrow=2, ncol=3)

#multiply each x termwise by 2
# [6   4]
# [-2 -2]
2*x

#multiply each x termwise by x
# [9 4]
# [1 1]
x*x

#matrix multplication of x and x
# [3*3+2*(-1) = 7, 3*2+2*(-1) = 4]
# [-1*3+1 = -2,       -1*2+1 = -1]
x%*%x

#matrix multiplication of x and y
x%*%y

#transpose y
t(y)

#gives the inverse of x
solve(x)

#gets the first row of x = [3 2]
x[1,]

#gets the second row of x = [-1 -1]
x[2,]

#gets the second column of x = [2 -1]
x[,2]

#gets the element on row=1, col=2 of y = 4
y[1,2]

#gets the elements from columns 2 to 3 of y
y[,2:3]

## QUESTION 6 ##
