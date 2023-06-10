#!/usr/bin/python3

print("Content-type: text/html\n\n")

print('<html>')
print('<head>')
print('  <title>Web App Prototype</title>')
print('</head>')
print('\n')
print('<body>')
print('  <h1>Web App Prototype</h1>')
print('  <img src="orders-post.jpg" alt="OLX">')
print('\n')
print('  <h2>Register and Remove Products</h2>')
print('  <form action="/main.py" method="post">')
print('     <label for="product_sku">Product SKU:</label>')
print('     <input type="text" id="product_sku" name="product_name" required>')
print('     <label for="product_name">Product Name:</label>')
print('     <input type="text" id="product_name" name="product_name" required>')
print('     <label for="product_description">Product Description:</label>')
print('     <input type="text" id="product_description" name="product_description" required>')
print('     <label for="product_price">Product Price:</label>')
print('     <input type="number" id="product_price" name="product_price" min="0" max="10000" step="0.01" required>')
print('     <label for="product_ean">Product EAN:</label>')
print('     <input type="text" id="product_ean" name="product_ean">')
print('     <input type="submit" value="Register Product">')
print('  </form>')
print('\n')
print('  <form action="/main.py" method="post">')
print('    <label for="product_id">Product SKU:</label>')
print('    <input type="text" id="product_id" name="product_id" required>')
print('    <input type="submit" value="Remove Product">')
print('  </form>')
print('\n\n')
print('  <h2>Modify Product Prices and Descriptions</h2>')
print('  <form action="/main.py" method="post">')
print('    <label for="product_id_price">Product ID:</label>')
print('    <input type="text" id="product_id_price" name="product_id_price" required>')
print('    <label for="new_price">New Price:</label>')
print('    <input type="number" id="new_price" name="new_price" min="0" max="10000" step="0.05" required>')
print('    <input type="submit" value="Modify Price">')
print('  </form>')
print('')
print('  <form action="/main.py" method="post">')
print('    <label for="product_id_description">Product ID:</label>')
print('    <input type="text" id="product_id_description" name="product_id_description" required>')
print('    <label for="new_description">New Description:</label>')
print('    <input type="text" id="new_description" name="new_description" required>')
print('    <input type="submit" value="Modify Description">')
print('  </form>')
print('\n\n')
print('  <h2>Register and Remove Customer</h2>')
print('  <form action="/main.py" method="post">')
print('    <label for="customer_register_id">Customer ID:</label>')
print('    <input type="text" id="customer_register_id" name="customer_register_id" required>')
print('    <label for="customer_register_name">Customer Name</label>')
print('    <input type="text" id="customer_register_name" name="customer_register_name" required>')
print('    <label for="customer_register_email">Customer Email</label>')
print('    <input type="email" id="customer_register_email" name="customer_register_email" required>')
print('    <label for="customer_register_phone">Customer Phone</label>')
print('    <input type="tel" id="customer_register_phone" name="customer_register_phone" pattern="[0-9]{9}" required>')
print('    <label for="customer_register_address">Customer Address</label>')
print('    <input type="text" id="customer_register_address" name="customer_register_address" required>')
print('    <input type="submit" value="Register Customer">')
print('  </form>')
print('\n')
print('  <form action="/main.py" method="post">')
print('    <label for="customer_id">Customer ID:</label>')
print('    <input type="text" id="customer_id" name="customer_id" required>')
print('    <input type="submit" value="Remove Customer">')
print('  </form>')
print('\n')
print('  <h2>Make an Order</h2>')
print('  <form action="/main.py" method="post">')
print('    <label for="order_no">Order ID:</label>')
print('    <input type="number" id="order_no" name="order_no" required>')
print('    <label for="client_id_order">Customer ID:</label>')
print('    <input type="text" id="client_id_order" name="client_id_order" required>')
print('    <label for="date">Date:</label>')
print('    <input type="date" id="date" name="date" required>')
print('    <label for="product_order_sku">Product ID:</label>')
print('    <input type="number" id="product_order_sku" name="product_order_sku" required>')
print('    <label for="qty">Quantity:</label>')
print('    <input type="number" id="qty" name="qty" required>')
print('    <input type="submit" value="Make Order">')
print('  </form>')
print('\n')
print('  <h2>Pay an Order</h2>')
print('  <form action="/main.py" method="post">')
print('    <label for="order_id">Order ID:</label>')
print('    <input type="text" id="order_id" name="order_id" required>')
print('  <form action="/simulate_payment" method="post">')
print('    <label for="customer_no">Customer ID:</label>')
print('    <input type="text" id="customer_no" name="customer_no" required>')
print('    <input type="submit" value="Pay">')
print('  </form>')
print('\n')
print('</body>')
print('</html>')