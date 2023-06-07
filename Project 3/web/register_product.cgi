#!/usr/bin/python3
import psycopg2
import cgi

ist_id = 'ist1103641'
host = 'db.tecnico.ulisboa.pt'
port = 5432
password = 'Tomastab2003'
db_name = ist_id

connection = None
dsn = f'host={host} port={port} user={ist_id} password={password} dbname={db_name}'

# This script is destined to register new products
try:
    # Create a connection
    connection = psycopg2.connect(dsn)
    connection.autocommit = False
    print('<p>Connected</p>')

    cursor = connection.cursor()

    form = cgi.FieldStorage()
    product_sku = form.getvalue('product_sku')
    product_name = form.getvalue('product_name')
    product_description = form.getvalue('product_description')
    product_price = form.getvalue('product_price')
    product_ean = form.getvalue('product_ean')

    # Perform the product registration
    cursor.execute("INSERT INTO product (SKU, name, description, price, ean) VALUES (%s, %s, %s, %s, %s)",
                   (product_sku, product_name, product_description, product_price, product_ean))

    # Commit the transaction
    connection.commit()

    # Fetch the updated product table
    cursor.execute("SELECT * FROM product")
    products = cursor.fetchall()

    # Header
    print('Content-type:text/html\n')
    print('<html>')
    print('<head>')
    print('<title>Register Client</title>')
    print('</head>')
    print('</html>')

    # Print the product table
    print('<h2>Product Table</h2>')
    print('<table>')
    print('<tr><th>SKU</th><th>Name</th><th>Description</th><th>Price</th><th>EAN</th></tr>')
    for product in products:
        sku, name, description, price, ean = product
        print('<tr><td>{}</td><td>{}</td><td>{}</td><td>{}</td><td>{}</td></tr>'.format(sku, name, description, price, ean))
    print('</table>')

    connection.close()

except Exception as error:
    print('<h1>An error occurred.</h1>')
    print('<p>{}</p>'.format(error))
    print('<p>Something went wrong while creating a new Product with the information you gave.</p>')
finally:
    if connection is not None:
        connection.close()
        print('<p>Connection closed.</p>')