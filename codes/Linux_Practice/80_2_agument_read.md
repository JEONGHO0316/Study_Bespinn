
인자와 read를 함께 사용하여 변수 조합 출력

~$ 80_2_shell_variables_read.sh agument_first
 read input : read_first
input values : agument_first read_first


```
V_input="$1"
echo "$V_input"
read -p "read_input:" V_Re

echo $V_Re

```

```
[jeongho@localhost quest]$ source ./shell_read.sh text
text
read_input:asd
asd
```
