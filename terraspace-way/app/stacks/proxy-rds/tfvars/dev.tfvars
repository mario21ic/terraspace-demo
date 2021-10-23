env = "<%= expansion(':ENV') %>"
region = "<%= expansion(':REGION') %>"
vpc_id = <%= output('network.vpc_id') %>
subnet_id = <%= output('network.first_public_subnet_id') %>

