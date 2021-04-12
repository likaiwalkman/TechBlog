用curl发起form表单提交:
curl -v --cookie "JSSESSIONID=12345" -F "a=1" -F "b=2" -F "attach=@/home/admin/YOUR_FILE_PATH" http_endpoint
