CPATH='.:../lib/hamcrest-core-1.3.jar:../lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

PATHJ=$(find student-submission -name "ListExamples.java")

if [ $? -ne 00 ]
then
  echo "No Java files found"
  exit 1
fi
  cp -r "$PATHJ" TestListExamples.java grading-area

# shellcheck disable=SC2164
cd grading-area
javac -cp $CPATH ListExamples.java TestListExamples.java

if [ $? -ne 00 ]
then
  echo "Java not Compiled"
  exit 1
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > Junit-output.txt
JUNIT=$(grep "Tests run" Junit-output.txt | grep -o '[0-9]\+' | awk 'NR==1')
JUNIT2=$(grep "Tests run" Junit-output.txt | grep -o '[0-9]\+' | awk 'NR==2')
if [ -z $JUNIT  ]
then
  echo 100%
else
  echo "$((($JUNIT2-$JUNIT)*100/$JUNIT2))%"
fi
# shellcheck disable=SC2046
# shellcheck disable=SC1072
# shellcheck disable=SC2005
cat Junit-output.txt

#TESTT=$( $JUNIT | grep -o '[0-9]\+')




# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
