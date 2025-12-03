import sys
print('Hello, World!')
print('The sum of 2 and 3 is 5.')
sum = int(sys.argv[1]) + int(sys.argv[2])
print('The sum of {0} and {1} is {2}.'.format(sys.argv[1], sys.argv[2], sum))

import boto3
s3 = boto3.resource('s3')
for bucket in s3.buckets.all():
 print(bucket.na