#!/usr/bin/python3
import psycopg2
import cgi
from datetime import datetime


def pay_an_order(form, cursor, connection):
    order_id = form.getvalue('pay_order_no')
    customer_id = form.getvalue('customer_no')
    if int(order_id) < 0:
        print("<h1>Order ID can't be negative</h1>")
        print(" <form action='main_menu.html'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return
    if int(customer_id) < 0:
        print("<h1>Error: Customer ID can't be negative</h1>")
        print(" <form action='main_menu.html'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return

    # Making SQL query to verify if an order with that order number exists
    cursor.execute("SELECT * FROM orders WHERE order_no = %(order_no)s", {'order_no': order_id})
    order = cursor.fetchone()

    if order is None:
        print("<h1>Error: Order with this ID does not exist</h1>")
        print(" <form action='main_menu.html'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return

    # Making SQL query to verify if the order has already been paid
    cursor.execute("SELECT * FROM pay WHERE order_no = %(order_no)s", {'order_no': order_id})
    paid_order = cursor.fetchone()

    if paid_order is not None:
        print("<h1>Error: This order has already been payed</h1>")
        print(" <form action='main_menu.html'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return


    # Making SQL query to verify if a customer with that customer number exists
    cursor.execute("SELECT * FROM customer WHERE cust_no = %(customer_number)s", {'customer_number': customer_id})
    customer = cursor.fetchone()

    if customer is None:
        print("<h1>Error: Customer not found</h1>")
        print(" <form action='main_menu.html'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return

    # Making SQL Query
    cursor.execute("INSERT INTO pay VALUES(%(order_number)s, %(customer_number)s)",
                   {'order_number': order_id,
                    'customer_number': customer_id})

    connection.commit()
    print("<h1>Order paid successfully</h1>")
    print(" <form action='main_menu.html'>")
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
        print(" <form action='main_menu.html'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return

    # Update the product price
    cursor.execute("UPDATE product SET price = %(price)s WHERE SKU = %(product_id)s",
                   {'price': new_price,
                    'product_id': product_id})

    connection.commit()
    print("<h1>Product price updated successfully</h1>")
    print(" <form action='main_menu.html'>")
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
        print(" <form action='main_menu.html'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return

    # Update the product price
    cursor.execute("UPDATE product SET description = %(description)s WHERE SKU = %(product_id)s",
                   {'description': new_descr,
                    'product_id': product_id})

    connection.commit()
    print("<h1>Product description updated successfully</h1>")
    print(" <form action='main_menu.html'>")
    print("     <input type='submit' value='Go Back'>")
    print(" </form>")


def remove_product(form, cursor, connection):
    product_id = form.getvalue('product_remove_sku')

    # Making SQL query to find a product and delete it
    cursor.execute("SELECT * FROM product WHERE SKU = %(product_id)s", {'product_id': product_id})
    product = cursor.fetchone()

    if product is None:
        print("<h1>Error: Product not found</h1>")
        print(" <form action='main_menu.html'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return

    # Delete the product
    cursor.execute("DELETE FROM product WHERE SKU = %(product_id)s", {'product_id': product_id})
    connection.commit()

    print("<h1>Product deleted successfully</h1>")
    print(" <form action='main_menu.html'>")
    print("     <input type='submit' value='Go Back'>")
    print(" </form>")


def remove_customer(form, cursor, connection):
    customer_id = form.getvalue('customer_remove_id')
    if int(customer_id) < 0:
        print("<h1>Error: Customer ID can't be negative</h1>")
        print(" <form action='main_menu.html'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return

    # Making SQL query to find a customer and delete it
    cursor.execute("SELECT * FROM customer WHERE cust_no = %(customer_number)s", {'customer_number': customer_id})
    customer = cursor.fetchone()

    if customer is None:
        print("<h1>Error: Customer not found</h1>")
        print(" <form action='main_menu.html'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return

    # Delete the customer
    cursor.execute("DELETE FROM customer WHERE cust_no = %(customer_number)s", {'customer_number': customer_id})
    connection.commit()

    print("<h1>Customer deleted successfully</h1>")
    print(" <form action='main_menu.html'>")
    print("     <input type='submit' value='Go Back'>")
    print(" </form>")


def remove_supplier(form, cursor, connection):
    supplier_tin = form.getvalue('supplier_tin_remove')

    # Making SQL query to find a supplier and delete it
    cursor.execute("SELECT * FROM supplier WHERE TIN = %(tin)s", {'tin': supplier_tin})
    supplier = cursor.fetchone()

    if supplier is None:
        print("<h1>Error: Supplier not found</h1>")
        print(" <form action='main_menu.html'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return

    # Delete the customer
    cursor.execute("DELETE FROM supplier WHERE TIN = %(tin)s", {'tin': supplier_tin})
    connection.commit()

    print("<h1>Supplier deleted successfully</h1>")
    print(" <form action='main_menu.html'>")
    print("     <input type='submit' value='Go Back'>")
    print(" </form>")


def make_an_order(form, cursor, connection):
    order_id = form.getvalue('make_order_no')
    customer_id = form.getvalue('client_id_order')
    date = form.getvalue('date')
    product_id = form.getvalue('product_order_sku')
    qty = form.getvalue('qty')
    if int(customer_id) < 0:
        print("<h1>Error: Customer ID can't be negative</h1>")
        print(" <form action='main_menu.html'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return
    if int(qty) <= 0:
        print("<h1>Error: Quantity can't be negative or zero</h1>")
        print(" <form action='main_menu.html'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return
    if int(order_id) < 0:
        print("<h1>Error: Order ID can't be negative</h1>")
        print(" <form action='main_menu.html'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return

    # We have to verify if the date provided is not older than today's
    today = datetime.today().date()
    order_date = datetime.strptime(date, "%Y-%m-%d").date()
#
    if order_date < today:
        print("<h1>Error: Date provided is older than today's date</h1>")
        print(" <form action='main_menu.html'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return

    # Making SQL query to verify if an order with that order number exists
    cursor.execute("SELECT * FROM orders WHERE order_no = %(order_no)s", {'order_no': order_id})
    order = cursor.fetchone()

    if order is not None:
        print("<h1>Error: Order with this ID already exists</h1>")
        print(" <form action='main_menu.html'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return

    # Making SQL query to verify if the product exists
    cursor.execute("SELECT * FROM product WHERE SKU = %(product_id)s", {'product_id': product_id})
    product = cursor.fetchone()

    if product is None:
        print("<h1>Error: Product not found</h1>")
        print(" <form action='main_menu.html'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return

    # Making SQL query to verify if the customer exists
    cursor.execute("SELECT * FROM customer WHERE cust_no = %(customer_number)s", {'customer_number': customer_id})
    customer = cursor.fetchone()

    if customer is None:
        print("<h1>Error: Customer not found</h1>")
        print(" <form action='main_menu.html'>")
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
    print(" <form action='main_menu.html'>")
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
        print(" <form action='main_menu.html'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return
    elif int(product_ean) < 0:
        print("<h1>Product EAN can't be negative</h1>")
        print(" <form action='main_menu.html'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return

    # Making SQL query to verify if a product with that id exists before creating a product
    cursor.execute("SELECT * FROM product WHERE SKU = %(product_sku)s", {'product_sku': product_sku})
    product = cursor.fetchone()

    if product is not None:
        print("<h1>Error: Product with this ID already exists</h1>")
        print(" <form action='main_menu.html'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return

    # Since the EAN Product Attribute is Unique, we have to verify it as well if the EAN is not null
    if product_ean is not None:
        cursor.execute("SELECT * FROM product WHERE ean = %(product_ean)s", {'product_ean': product_ean})
        product = cursor.fetchone()
        if product is not None:
            print("<h1>Error: Product with this EAN already exists</h1>")
            print(" <form action='main_menu.html'>")
            print("     <input type='submit' value='Go Back'>")
            print(" </form>")
            return

    # Now that we verified everything, we can create the product
    cursor.execute("INSERT INTO product VALUES(%(product_sku)s, %(product_name)s, %(product_description)s,%(product_price)s, %(product_ean)s)",
                   {'product_sku': product_sku, 'product_name': product_name,
                    'product_description': product_descr, 'product_price': product_price,
                    'product_ean': product_ean})

    connection.commit()
    print("<h1>Product registed successfully</h1>")
    print(" <form action='main_menu.html'>")
    print("     <input type='submit' value='Go Back'>")
    print(" </form>")


def register_customer(form, cursor, connection):
    customer_id = form.getvalue('customer_register_id')
    customer_name = form.getvalue('customer_register_name')
    if int(customer_id) < 0:
        print("<h1>Error: Customer ID can't be negative</h1>")
        print(" <form action='main_menu.html'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return

    # This one is unique, so we have to verify if someone has an email equal to this
    customer_email = form.getvalue('customer_register_email')
    customer_phone = form.getvalue('customer_register_phone')
    customer_address = form.getvalue('customer_register_address')

    # Making SQL query to verify if a customer with that id exists before creating a customer
    cursor.execute("SELECT * FROM customer WHERE cust_no = %(cust_no)s", {'cust_no': customer_id})
    customer = cursor.fetchone()

    if customer is not None:
        print("<h1>Error: Customer with this ID already exists</h1>")
        print(" <form action='main_menu.html'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return

    # Making SQL query to verify if a customer with that email exists before creating a customer
    cursor.execute("SELECT * FROM customer WHERE email = %(email)s", {'email': customer_email})
    customer = cursor.fetchone()

    if customer is not None:
        print("<h1>Error: Customer with this email already exists</h1>")
        print(" <form action='main_menu.html'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return

    # After verifying everything we can finnaly create a customer
    cursor.execute("INSERT INTO customer VALUES(%(customer_id)s, %(customer_name)s, %(customer_email)s, %(customer_phone)s, %(customer_address)s)",
                   {'customer_id': customer_id, 'customer_name': customer_name,
                    'customer_email': customer_email, 'customer_phone': customer_phone,
                    'customer_address': customer_address})

    connection.commit()
    print("<h1>Customer registed successfully</h1>")
    print(" <form action='main_menu.html'>")
    print("     <input type='submit' value='Go Back'>")
    print(" </form>")


def register_supplier(form, cursor, connection):
    supplier_tin = form.getvalue('supplier_register_tin')
    supplier_name = form.getvalue('supplier_register_name')
    supplier_address = form.getvalue('supplier_register_address')
    supplier_product_sku = form.getvalue('supplier_product_sku')

    # Making SQL query to verify if a product with that SKU code exists before creating a supplier
    cursor.execute("SELECT * FROM product WHERE SKU = %(product_sku)s", {'product_sku': supplier_product_sku})
    product = cursor.fetchone()

    if product is None:
        print("<h1>Error: Product with this SKU does not exist</h1>")
        print(" <form action='main_menu.html'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return

    # Making sure that this Supplier TIN is not in use
    cursor.execute("SELECT * FROM supplier WHERE TIN = %(tin)s", {'tin': supplier_tin})
    supplier = cursor.fetchone()

    if supplier is not None:
        print("<h1>Error: Supplier with this ID already exists</h1>")
        print(" <form action='main_menu.html'>")
        print("     <input type='submit' value='Go Back'>")
        print(" </form>")
        return

    # Now that we have verified everything we can continue to create the supplier
    cursor.execute(
        "INSERT INTO supplier VALUES(%(tin)s, %(supplier_name)s, %(supplier_address)s, %(product_sku)s)",
        {'tin': supplier_tin, 'supplier_name': supplier_name,
         'supplier_address': supplier_address, 'product_sku': supplier_product_sku})

    connection.commit()
    print("<h1>Supplier registed successfully</h1>")
    print(" <form action='main_menu.html'>")
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

    form = cgi.FieldStorage()

    if any(field == 'product_register_sku' for field in form.keys()):
        register_product(form, cursor, connection)
    elif any(field == 'product_remove_sku' for field in form.keys()):
        remove_product(form, cursor, connection)
    elif any(field == 'supplier_tin_register' for field in form.keys()):
        register_supplier(form, cursor, connection)
    elif any(field == 'supplier_tin_remove' for field in form.keys()):
        remove_supplier(form, cursor, connection)
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
        print('<h1>Unknown Operation</h1>')

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
