#!/usr/bin/python3
import psycopg2
import cgi


def pay_an_order(form, cursor, connection):
    order_id = form.getvalue('pay_order_no')
    customer_num = form.getvalue('customer_no')

    # Making SQL query to verify if an order with that order number exists
    cursor.execute("SELECT * FROM orders WHERE order_no = %(order_no)s", {'order_no': order_id})
    order = cursor.fetchone()

    if order is None:
        print("<h1>Error: Order with this ID does not exist</h1>")
        print('<p>Error found, terminating operation</p>')
        print(" <form action='index.HTML'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return

    # Making SQL query to verify if a customer with that customer number exists
    cursor.execute("SELECT * FROM customer WHERE cust_no = %(customer_number)s", {'customer_number': customer_num})
    customer = cursor.fetchone()

    if customer is None:
        print("<h1>Error: Customer not found</h1>")
        print('<p>Error found, terminating operation</p>')
        print(" <form action='index.HTML'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return

    # Making SQL Query
    cursor.execute("INSERT INTO pay VALUES(%(order_number)s, %(customer_number)s)",
                   {'order_number': order_id,
                    'customer_number': customer_num})

    connection.commit()
    print("<h1>Order paid successfully</h1>")
    print(" <form action='index.HTML'>")
    print("     <input type='submit' value='Go Back'>")
    print(" </form>")

def modify_product_price(form, cursor, connection):
    product_id = form.getvalue('product_id_price')
    new_price = form.getvalue('new_price')

    # Making SQL query to find a product and update its price
    cursor.execute("SELECT * FROM product WHERE SKU = %(product_id)s", {'product_id': product_id})
    product = cursor.fetchone()

    if product is None:
        print("<h1>Error: Product not found</h1>")
        print('<p>Error found, terminating operation</p>')
        print(" <form action='index.HTML'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return

    # Update the product price
    cursor.execute("UPDATE product SET price = %(price)s WHERE SKU = %(product_id)s",
                   {'price': new_price,
                    'product_id': product_id})

    connection.commit()
    print("<h1>Product price updated successfully</h1>")
    print(" <form action='index.HTML'>")
    print("     <input type='submit' value='Go Back'>")
    print(" </form>")

def modify_product_description(form, cursor, connection):
    product_id = form.getvalue('product_id_description')
    new_descr = form.getvalue('new_description')

    # Making SQL query to find a product and update its description
    cursor.execute("SELECT * FROM product WHERE SKU = %(product_id)s", {'product_id': product_id})
    product = cursor.fetchone()

    if product is None:
        print("<h1>Error: Product not found</h1>")
        print('<p>Error found, terminating operation</p>')
        print(" <form action='index.HTML'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return

    # Update the product price
    cursor.execute("UPDATE product SET description = %(description)s WHERE SKU = %(product_id)s",
                   {'description': new_descr,
                    'product_id': product_id})

    connection.commit()
    print("<h1>Product description updated successfully</h1>")
    print(" <form action='index.HTML'>")
    print("     <input type='submit' value='Go Back'>")
    print(" </form>")


def remove_product(form, cursor, connection):
    product_id = form.getvalue('product_remove_sku')

    # Making SQL query to find a product and delete it
    cursor.execute("SELECT * FROM product WHERE SKU = %(product_id)s", {'product_id': product_id})
    product = cursor.fetchone()

    if product is None:
        print("<h1>Error: Product not found</h1>")
        print('<p>Error found, terminating operation</p>')
        print(" <form action='index.HTML'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return

    # Delete the product
    cursor.execute("DELETE FROM product WHERE SKU = %(product_id)s", {'product_id': product_id})
    connection.commit()

    print("<h1>Product deleted successfully</h1>")
    print(" <form action='index.HTML'>")
    print("     <input type='submit' value='Go Back'>")
    print(" </form>")


def remove_customer(form, cursor, connection):
    customer_id = form.getvalue('customer_remove_id')

    # Making SQL query to find a customer and delete it
    cursor.execute("SELECT * FROM customer WHERE cust_no = %(customer_number)s", {'customer_number': customer_id})
    customer = cursor.fetchone()

    if customer is None:
        print("<h1>Error: Customer not found</h1>")
        print('<p>Error found, terminating operation</p>')
        print(" <form action='index.HTML'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return

    # Delete the customer
    cursor.execute("DELETE FROM customer WHERE cust_no = %(customer_number)s", {'customer_number': customer_id})
    connection.commit()

    print("<h1>Customer deleted successfully</h1>")
    print(" <form action='index.HTML'>")
    print("     <input type='submit' value='Go Back'>")
    print(" </form>")


def make_an_order(form, cursor, connection):
    order_id = form.getvalue('make_order_no')
    customer_id = form.getvalue('client_id_order')
    date = form.getvalue('date')
    product_id = form.getvalue('product_order_sku')
    qty = form.getvalue('qty')

    # Making SQL query to verify if an order with that order number exists
    cursor.execute("SELECT * FROM orders WHERE order_no = %(order_no)s", {'order_no': order_id})
    order = cursor.fetchone()

    if order is not None:
        print("<h1>Error: Order with this ID already exists</h1>")
        print('<p>Error found, terminating operation</p>')
        print(" <form action='index.HTML'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return

    # Making SQL query to verify if the product exists
    cursor.execute("SELECT * FROM product WHERE SKU = %(product_id)s", {'product_id': product_id})
    product = cursor.fetchone()

    if product is None:
        print("<h1>Error: Product not found</h1>")
        print('<p>Error found, terminating operation</p>')
        print(" <form action='index.HTML'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return

    # Making SQL query to verify if the customer exists
    cursor.execute("SELECT * FROM customer WHERE cust_no = %(customer_number)s", {'customer_number': customer_id})
    customer = cursor.fetchone()

    if customer is None:
        print("<h1>Error: Customer not found</h1>")
        print('<p>Error found, terminating operation</p>')
        print(" <form action='index.HTML'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return

    # Now we can finally make an order, with the transaction method
    cursor.execute("START TRANSACTION;"
                   "SET CONSTRAINTS ALL DEFERRED;"
                   "INSERT INTO orders VALUES(%(order_no)s, %(cust_no)s, %(date)s);"
                   "INSERT INTO contains VALUES(%(order_no)s, %(product_sku)s, %(quantity)s);"
                   "COMMIT;",
                   {'order_no': order_id, 'cust_no': customer_id,
                    'date': date, 'quantity': qty, 'product_sku': product_id})

    connection.commit()
    print("<h1>Order made successfully</h1>")
    print(" <form action='index.HTML'>")
    print("     <input type='submit' value='Go Back'>")
    print(" </form>")

def register_product(form, cursor, connection):
    product_sku = form.getvalue('product_register_sku')
    product_name = form.getvalue('product_name')
    product_descr = form.getvalue('product_description')
    product_price = form.getvalue('product_price')
    product_ean = form.getvalue('product_ean')
    if product_ean is None:
        pass
    elif not product_ean.isdigit():
        print("<h1>Product EAN is not a numeric sequence</h1>")
        print('<p>Error found, terminating operation</p>')
        print(" <form action='index.HTML'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return

    # Making SQL Query
    cursor.execute("INSERT INTO product VALUES(%(product_sku)s, %(product_name)s, %(product_description)s,%(product_price)s, %(product_ean)s)",
                   {'product_sku': product_sku, 'product_name': product_name,
                    'product_description': product_descr, 'product_price': product_price,
                    'product_ean': product_ean})

    connection.commit()
    print("<h1>Product registed successfully</h1>")
    print(" <form action='index.HTML'>")
    print("     <input type='submit' value='Go Back'>")
    print(" </form>")


def register_customer(form, cursor, connection):
    customer_id = form.getvalue('customer_register_id')
    customer_name = form.getvalue('customer_register_name')
    if not isinstance(customer_name, str):
        print("<h1>Customer Name should be only letters</h1>")
        print('<p>Error found, terminating operation</p>')
        print(" <form action='index.HTML'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return
    # Idk how to verify this
    customer_email = form.getvalue('customer_register_email')
    customer_phone = form.getvalue('customer_register_phone')
    # Idk how to verify this 100% correctly
    customer_address = form.getvalue('customer_register_address')

    # Making SQL Query
    cursor.execute("INSERT INTO customer VALUES(%(customer_id)s, %(customer_name)s, %(customer_email)s, %(customer_phone)s, %(customer_address)s)",
                   {'customer_id': customer_id, 'customer_name': customer_name,
                    'customer_email': customer_email, 'customer_phone': customer_phone,
                    'customer_address': customer_address})

    connection.commit()
    print("<h1>Customer registed successfully</h1>")
    print(" <form action='index.HTML'>")
    print("     <input type='submit' value='Go Back'>")
    print(" </form>")


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
print('</head>')
print('<body>')

connection = None

try:
    # Creating connection
    connection = psycopg2.connect(dsn)

    connection.autocommit = False
    print('<p>Connected</p>')
    cursor = connection.cursor()

    form = cgi.FieldStorage()

    # Help for debug
    print(len(form))
    for field in form.keys():
        value = form.getvalue(field)
        print(f"Field: {field}")
        print(f"Value: {value}")
        print('\n')

    if any(field == 'product_register_sku' for field in form.keys()):
        register_product(form, cursor, connection)
    elif any(field == 'product_remove_sku' for field in form.keys()):
        remove_product(form, cursor, connection)
    elif any(field == 'product_id_price' for field in form.keys()):
        modify_product_price(form, cursor, connection)
    elif any(field == 'product_id_description' for field in form.keys()):
        modify_product_description(form, cursor, connection)
    elif any(field == 'customer_register_id' for field in form.keys()):
        register_customer(form, cursor, connection)
    elif any(field == 'customer_remove_id' for field in form.keys()):
        remove_customer(form, cursor, connection)
    elif any(field == 'make_order_no' for field in form.keys()):
        make_an_order(form, cursor, connection)
    elif any(field == 'pay_order_no' for field in form.keys()):
        pay_an_order(form, cursor, connection)
    else:
        print('<p>Unknown Operation</p>')

    print('<p>Operation finished</p>')
    cursor.close()
    connection.close()

except Exception as e:
    print('<h1>An error occurred.</h1>')
    print('<p>{}</p>'.format(e))
finally:
    if connection is not None:
        connection.close()

print('</body>')
print('</html>')
