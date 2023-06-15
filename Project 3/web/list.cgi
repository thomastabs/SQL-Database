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
print('<title>Request Answer</title>')
print('<link rel="stylesheet" type="text/css" href="style.css">')
print('</head>')
print('<body>')
print('<div class="container">')

connection = None

try:
    # Creating connection
    connection = psycopg2.connect(dsn)

    connection.autocommit = False
    cursor = connection.cursor()

    # Execute SQL queries to retrieve data from the tables
    cursor.execute(
        "SELECT p.SKU, p.name AS product_name, p.description, p.price, s.TIN, s.name AS supplier_name FROM product p JOIN supplier s ON p.SKU = s.SKU")
    products_suppliers = cursor.fetchall()

    cursor.execute(
        "SELECT o.order_no, o.cust_no, o.date, c.name AS customer_name, c.email FROM orders o JOIN customer c ON o.cust_no = c.cust_no")
    orders_customers = cursor.fetchall()

    cursor.execute(
        "SELECT o.order_no, o.cust_no, o.date, c.name AS customer_name, c.email FROM orders o JOIN customer c ON o.cust_no = c.cust_no JOIN pay p ON o.order_no = p.order_no")
    paid_orders_customers = cursor.fetchall()

    # List All Tables
    print("<h1>Products joined with Suppliers</h1>")
    print("<table>")
    print("  <tr>")
    print("    <th>SKU</th>")
    print("    <th>Product Name</th>")
    print("    <th>Product Description</th>")
    print("    <th>Product Price</th>")
    print("    <th>Supplier TIN</th>")
    print("    <th>Supplier Name</th>")
    print("  </tr>")
    for product in products_suppliers:
        print("  <tr>")
        print(f"    <td>{product[0]}</td>")
        print(f"    <td>{product[1]}</td>")
        print(f"    <td>{product[2]}</td>")
        print(f"    <td>{product[3]}</td>")
        print(f"    <td>{product[4]}</td>")
        print(f"    <td>{product[5]}</td>")
        print("  </tr>")
    print("</table>")

    print("<h1>Orders joined with Contains</h1>")
    print("<table>")
    print("  <tr>")
    print("    <th>Order No</th>")
    print("    <th>Customer No</th>")
    print("    <th>Date</th>")
    print("    <th>Customer Name</th>")
    print("    <th>Customer Email</th>")
    print("  </tr>")
    for order in orders_customers:
        print("  <tr>")
        print(f"    <td>{order[0]}</td>")
        print(f"    <td>{order[1]}</td>")
        print(f"    <td>{order[2]}</td>")
        print(f"    <td>{order[3]}</td>")
        print(f"    <td>{order[4]}</td>")
        print("  </tr>")
    print("</table>")

    print("<h1>Paid Orders and Customers</h1>")
    print("<table>")
    print("  <tr>")
    print("    <th>Order No</th>")
    print("    <th>Customer No</th>")
    print("    <th>Date</th>")
    print("    <th>Customer Name</th>")
    print("    <th>Customer Email</th>")
    print("  </tr>")
    for paid_order in paid_orders_customers:
        print("  <tr>")
        print(f"    <td>{paid_order[0]}</td>")
        print(f"    <td>{paid_order[1]}</td>")
        print(f"    <td>{paid_order[2]}</td>")
        print(f"    <td>{paid_order[3]}</td>")
        print(f"    <td>{paid_order[4]}</td>")
        print("  </tr>")
    print("</table>")
    print('</div>')
    print("</body>")
    print("</html>")
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
