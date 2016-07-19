# module Devx
#   class DiamondMind
#     include ActiveModel::Model

#     require 'rubygems'
#     require 'curb'
#     require 'uri'
#     require 'addressable/uri'

#     POST_URL = 'https://pcisecure.diamondmindschools.com/api/transact.php'

#     def initialize()
#       @login = {}
#       @order = {}
#       @billing = {}
#       @shipping = {}
#       @responses = {}
#     end

#     def setLogin(username, password)
#       @login['username'] = 'demo'
#       @login['password'] = 'password'
#     end

#     def setOrder( orderid, orderdescription, tax, shipping, ponumber,ipadress)
#         @order['orderid'] = orderid;
#         @order['orderdescription'] = orderdescription
#         @order['shipping'] = "%.2f" % shipping
#         @order['ipaddress'] = ipadress
#         @order['tax'] = "%.2f" % tax
#         @order['ponumber'] = ponumber
#     end

#     def setBilling(
#             firstname,
#             lastname,
#             company,
#             address1,
#             address2,
#             city,
#             state,
#             zip,
#             country,
#             phone,
#             fax,
#             email,
#             website)
#         @billing['firstname'] = firstname
#         @billing['lastname']  = lastname
#         @billing['company']   = company
#         @billing['address1']  = address1
#         @billing['address2']  = address2
#         @billing['city']      = city
#         @billing['state']     = state
#         @billing['zip']       = zip
#         @billing['country']   = country
#         @billing['phone']     = phone
#         @billing['fax']       = fax
#         @billing['email']     = email
#         @billing['website']   = website
#     end

#     def setShipping(firstname,
#             lastname,
#             company,
#             address1,
#             address2,
#             city,
#             state,
#             zipcode,
#             country,
#             email)
#         @shipping['firstname'] = firstname
#         @shipping['lastname']  = lastname
#         @shipping['company']   = company
#         @shipping['address1']  = address1
#         @shipping['address2']  = address2
#         @shipping['city']      = city
#         @shipping['state']     = state
#         @shipping['zip']       = zipcode
#         @shipping['country']   = country
#         @shipping['email']     = email

#     end

#     def doSale(amount, ccnumber, ccexp, cvv='')

#         query  = ""
#         # Login Information

#         query = query + "username=" + URI.escape(@login['username']) + "&"
#         query += "password=" + URI.escape(@login['password']) + "&"
#         # Sales Information
#         query += "ccnumber=" + URI.escape(ccnumber) + "&"
#         query += "ccexp=" + URI.escape(ccexp) + "&"
#         query += "amount=" + URI.escape("%.2f" %amount) + "&"
#         if (cvv!='')
#             query += "cvv=" + URI.escape(cvv) + "&"
#         end

#         # Order Information
#         @order.each do | key,value|
#             query += key +"=" + URI.escape(value) + "&"
#         end

#         # Billing Information
#         @billing.each do | key,value|
#             query += key +"=" + URI.escape(value) + "&"
#         end
#         # Shipping Information

#         @shipping.each do | key,value|
#             query += key +"=" + URI.escape(value) + "&"
#         end

#         query += "type=sale"
#         return doPost(query)
#     end


#     def doPost(query)


#         curlObj = Curl::Easy.new("https://pcisecure.diamondmindschools.com/api/transact.php")
#         curlObj.connect_timeout = 30
#         curlObj.timeout = 30
#         curlObj.header_in_body = false
#         curlObj.ssl_verify_peer=false
#         curlObj.post_body = query
#         curlObj.perform()
#         data = curlObj.body_str

#         # NOTE: The domain name below is simply used to create a full URI to allow URI.parse to parse out the query values
#         # for us. It is not used to send any data
#         data = '"https://pcisecure.diamondmindschools.com/api/transact.php?' + data
#         uri = Addressable::URI.parse(data)
#         uri.scheme = 'https'
#         @responses = uri.query_values
#         return @responses['response']
#     end

#     def getResponses()
#         return @responses
#     end




#     def self.process
#       gw = Devx::DiamondMind.new()
#       # NOTE: your username and password should replace the ones below
#       gw.setLogin("demo", "password");

#       gw.setBilling("John","Smith","Acme, Inc.","123 Main St","Suite 200", "Beverly Hills",
#               "CA","90210","US","555-555-5555","555-555-5556","support@example.com",
#               "www.example.com")

#       gw.setShipping("Mary","Smith","na","124 Shipping Main St","Suite Ship", "Beverly Hills",
#               "CA","90210","US","support@example.com")

#       gw.setOrder("1234","Big Order",1, 2, "PO1234","65.192.14.10")

#       r = gw.doSale("5.00","4111111111111111","1212",'999')
#       myResponses = gw.getResponses

#       print myResponses['response'] + "  "

#       if (myResponses['response'] == '1')
#           print "Approved \n"
#       elsif (myResponses['response'] == '2')
#           print "Declined \n"
#       elsif (myResponses['response'] == '3')
#           print "Error \n"
#       end
#     end
#   end
# end

