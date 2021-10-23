# Required variables:
#user = any
#pass = any
user = "<%= aws_secret("demo-#{Terraspace.env}-user") %>"
pass = "<%= aws_secret("demo-#{Terraspace.env}-pass") %>"
KeyFromOtherStack = <%= output('newstack.myKey') %>

