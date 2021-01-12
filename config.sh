# localtion of aws cren file user/.aws 
AWS_CREDENTIALS=~/.aws/credentials

mfa=${1}
# used AWS ROLE DETAIL
creds=`aws sts assume-role --role-arn arn:aws:iam::111111111111111111:role/######-###########-###-####-assumerole --role-session-name "RoleSession1" --serial-number arn:aws:iam::111111:mfa/XXX.XX-XX@XXX.com --token-code ${mfa} --profile XX.XXX-XX@XXX.com`

export AWS_ACCESS_KEY_ID=`echo ${creds} | ./jq-win64.exe .Credentials.AccessKeyId | sed -e 's/^"//' -e 's/"$//'`
export AWS_SECRET_ACCESS_KEY=`echo ${creds} | ./jq-win64.exe .Credentials.SecretAccessKey | sed -e 's/^"//' -e 's/"$//'`
export AWS_SESSION_TOKEN=`echo ${creds} | ./jq-win64.exe .Credentials.SessionToken | sed -e 's/^"//' -e 's/"$//'`

sed -i -e "/\[default\]/,+3 d" $AWS_CREDENTIALS

echo "[default]
aws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}
aws_access_key_id = ${AWS_ACCESS_KEY_ID}
aws_session_token = ${AWS_SESSION_TOKEN}" >> $AWS_CREDENTIALS

echo `echo ${creds} | ./jq-win64.exe .Credentials.Expiration`