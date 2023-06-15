#!/usr/bin/python3
import psycopg2
import cgi


ist_id = 'ist1103641'
host = 'db.tecnico.ulisboa.pt'
port = 5432
password = 'Tomastab2003'
db_name = ist_id

connection = None
dsn = 'host={} port={} user={} password={} dbname={}'.format(host, port, ist_id, password, db_name)

print("Content-type: text/html\n\n")

print('<html>')
print('<head>')
print('<title>Listing Tables</title>')
print('<link rel="stylesheet" type="text/css" href="style.css">')
print('<style>')
print('table {')
print('  width: 100%;')
print('  border-collapse: collapse;')
print('  margin-top: 20px;')
print('  margin-bottom: 40px;')
print('}')
print('table, th, td {')
print('  border: 1px solid black;')
print('  text-align: center;')
print('}')
print('th, td {')
print('  padding: 8px;')
print('}')
print('.custom-button { ')
print('  position: fixed;')
print('  top: 10px;')
print('  left: 10px;')
print('  width: 7%;')
print('  padding: 10px;')
print('  background-color: #4285f4;')
print('  color: #fff;')
print('  border: none;')
print('  border-radius: 6px;')
print('  cursor: pointer;')
print('  font-size: 16px;')
print('  transition: background-color 0.3s;')
print('}')
print('.custom-button:hover { ')
print('   background-color: #3367d6;')
print(' }')
print('</style>')
print('</head>')
print('<body>')
print('<form action="main_menu" method="post">')
print('<input type="submit" value="Go Back" class="custom-button">')
print('  </form>')
print('<div class="container">')

connection = None

try:
    # Creating connection
    connection = psycopg2.connect(dsn)

    connection.autocommit = False
    cursor = connection.cursor()

    # Execute SQL queries to retrieve data from the tables
    cursor.execute(
        "SELECT * FROM product")
    productss = cursor.fetchall()

    cursor.execute(
        "SELECT * FROM supplier")
    supplierss = cursor.fetchall()

    cursor.execute(
        "SELECT o.order_no, o.cust_no, o.date, c.SKU AS product_sku, c.qty FROM orders o JOIN contains c ON o.order_no = c.order_no")
    orders_contains = cursor.fetchall()

    cursor.execute(
        "SELECT * FROM pay")
    paid_ordersss = cursor.fetchall()

    cursor.execute(
        "SELECT * FROM customer")
    customersss = cursor.fetchall()


    # List All Tables
    print("<h1>Products</h1>")
    print("<table>")
    print("  <tr>")
    print("    <th>SKU</th>")
    print("    <th>Product Name</th>")
    print("    <th>Product Description</th>")
    print("    <th>Product Price</th>")
    print("    <th>EAN</th>")
    print("  </tr>")
    for product in productss:
        print("  <tr>")
        print(f"    <td>{product[0]}</td>")
        print(f"    <td>{product[1]}</td>")
        print(f"    <td>{product[2]}</td>")
        print(f"    <td>{product[3]}</td>")
        print(f"    <td>{product[4]}</td>")
        print("  </tr>")
    print("</table>")

    print("<h1>Suppliers</h1>")
    print("<table>")
    print("  <tr>")
    print("    <th>TIN</th>")
    print("    <th>Supplier Name</th>")
    print("    <th>Supplier Address</th>")
    print("    <th>SKU</th>")
    print("    <th>Date</th>")
    print("  </tr>")
    for supplier in supplierss:
        print("  <tr>")
        print(f"    <td>{supplier[0]}</td>")
        print(f"    <td>{supplier[1]}</td>")
        print(f"    <td>{supplier[2]}</td>")
        print(f"    <td>{supplier[3]}</td>")
        print(f"    <td>{supplier[4]}</td>")
        print("  </tr>")
    print("</table>")

    print("<h1>Orders</h1>")
    print("<table>")
    print("  <tr>")
    print("    <th>Order No</th>")
    print("    <th>Customer No</th>")
    print("    <th>Date</th>")
    print("    <th>SKU</th>")
    print("    <th>Quantity</th>")
    print("  </tr>")
    for order in orders_contains:
        print("  <tr>")
        print(f"    <td>{order[0]}</td>")
        print(f"    <td>{order[1]}</td>")
        print(f"    <td>{order[2]}</td>")
        print(f"    <td>{order[3]}</td>")
        print(f"    <td>{order[4]}</td>")
        print("  </tr>")
    print("</table>")

    print("<h1>Paid Orders</h1>")
    print("<table>")
    print("  <tr>")
    print("    <th>Order No</th>")
    print("    <th>Customer No</th>")
    print("  </tr>")
    for paid_order in paid_ordersss:
        print("  <tr>")
        print(f"    <td>{paid_order[0]}</td>")
        print(f"    <td>{paid_order[1]}</td>")
        print("  </tr>")
    print("</table>")

    print("<h1>Customers</h1>")
    print("<table>")
    print("  <tr>")
    print("    <th>Customer No</th>")
    print("    <th>Customer Name</th>")
    print("    <th>Customer Email</th>")
    print("    <th>Customer Phone</th>")
    print("    <th>Customer Address</th>")
    print("  </tr>")
    for customer in customersss:
        print("  <tr>")
        print(f"    <td>{customer[0]}</td>")
        print(f"    <td>{customer[1]}</td>")
        print(f"    <td>{customer[2]}</td>")
        print(f"    <td>{customer[3]}</td>")
        print(f"    <td>{customer[4]}</td>")
        print("  </tr>")
    print("</table>")

    cursor.close()
    connection.close()

except Exception as e:
    print('<h1>An error occurred.</h1>')
    print('<p>{}</p>'.format(e))
finally:
    if connection is not None:
        connection.close()

print("</div>")
print('</body>')
print('</html>')
