
인자와 read를 함께 사용하여 변수 조합 출력

~$ 80_2_shell_variables_read.sh agument_first
 read input : read_first
input values : agument_first read_first


```
[jeongho@localhost quest]$ source ./shell_read.sh agument_first read_first
agument_first
read_input: read_first
read_first
```
```
V_agu="$1"
V_input="$2"

echo "$1"

read -p "read_input: " "$2"
echo "$2"

```