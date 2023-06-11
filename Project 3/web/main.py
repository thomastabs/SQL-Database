#!/usr/bin/python3
import psycopg2
import cgi


def pay_an_order(form, cursor, connection):
    order_id = form.getvalue('order_id')
    customer_num = form.getvalue('customer_no')

    # Making SQL Query
    sql = "INSERT INTO pay VALUES(%(order_number), %(customer_number))", {'order_number': order_id,
                                                                          'customer_number': customer_num}
    cursor.execute(sql)
    connection.commit()
    print("<h1>Order paid successfully</h1>")


def modify_product_price(form, cursor, connection):
    product_id = form.getvalue('product_id_price')
    new_price = form.getvalue('new_price')

    # Making SQL query to find a product and update its price
    sql = "SELECT * FROM product WHERE SKU = %(product_id)s", {'product_id': product_id}
    cursor.execute(sql)
    product = cursor.fetchone()

    if product is None:
        print("<h1>Error: Product not found</h1>")
        print('<p>Error found, terminating operation</p>')
        return

    sql = "UPDATE product SET price = %(price)s WHERE SKU = %(product_id)s", {'price': new_price,
                                                                              'product_id': product_id}
    # Update the product price
    cursor.execute(sql)
    connection.commit()

    print("<h1>Product price updated successfully</h1>")


def modify_product_description(form, cursor, connection):
    product_id = form.getvalue('product_id_description')
    new_descr = form.getvalue('new_description')

    # Making SQL query to find a product and update its description
    sql = "SELECT * FROM product WHERE SKU = %(product_id)s", {'product_id': product_id}
    cursor.execute(sql)
    product = cursor.fetchone()

    if product is None:
        print("<h1>Error: Product not found</h1>")
        print('<p>Error found, terminating operation</p>')
        return

    sql = "UPDATE product SET description = %(description)s WHERE SKU = %(product_id)s", {'description': new_descr,
                                                                                          'product_id': product_id}
    # Update the product price
    cursor.execute(sql)
    connection.commit()

    print("<h1>Product description updated successfully</h1>")


def remove_product(form, cursor, connection):
    product_id = form.getvalue('product_id')

    # Making SQL query to find a product and delete it
    sql = "SELECT * FROM product WHERE SKU = %(product_id)s", {'product_id': product_id}
    cursor.execute(sql)
    product = cursor.fetchone()

    if product is None:
        print("<h1>Error: Product not found</h1>")
        print('<p>Error found, terminating operation</p>')
        return

    sql = "DELETE FROM product WHERE SKU = %(product_id)s", {'product_id': product_id}
    # Delete the product
    cursor.execute(sql)
    connection.commit()

    print("<h1>Product deleted successfully</h1>")


def remove_customer(form, cursor, connection):
    customer_id = form.getvalue('customer_id')

    # Making SQL query to find a product and delete it
    sql = "SELECT * FROM customer WHERE cust_no = %(customer_number)s", {'customer_number': customer_id}
    cursor.execute(sql)
    customer = cursor.fetchone()

    if customer is None:
        print("<h1>Error: Customer not found</h1>")
        print('<p>Error found, terminating operation</p>')
        return

    sql = "DELETE FROM customer WHERE cust_no = %(customer_number)s", {'customer_number': customer_id}
    # Delete the customer
    cursor.execute(sql)
    connection.commit()

    print("<h1>Customer deleted successfully</h1>")


def make_an_order(form, cursor, connection):
    # Question 1: Should I also make a product_sku and qty field form for putting the order num in contain?
    return form


def register_product(form, cursor, connection):
    product_sku = form.getvalue('product_sku')
    product_name = form.getvalue('product_name')
    product_descr = form.getvalue('product_description')
    product_price = form.getvalue('product_price')
    product_ean = form.getvalue('product_ean')
    if product_ean is None:
        pass
    elif not product_ean.isdigit():
        print("<h1>Product EAN is not a numeric sequence</h1>")
        print('<p>Error found, terminating operation</p>')
        return

    # Making SQL Query
    sql = "INSERT INTO product VALUES(%(product_sku), %(product_name), %(product_description), %(product_price), " \
          "%(product_ean))", {'product_sku': product_sku, 'product_name': product_name,
                              'product_description': product_descr, 'product_price': product_price,
                              'product_ean': product_ean}

    cursor.execute(sql)
    connection.commit()
    print("<h1>Product registed successfully</h1>")


def register_customer(form, cursor, connection):
    customer_id = form.getvalue('customer_register_id')
    customer_name = form.getvalue('customer_register_name')
    if customer_name is not str:
        print("<h1>Customer Name should be only letters</h1>")
        print('<p>Error found, terminating operation</p>')
        return
    # Idk how to verify this
    customer_email = form.getvalue('customer_register_email')
    customer_phone = form.getvalue('customer_register_phone')
    # Idk how to verify this 100% correctly
    customer_address = form.getvalue('customer_register_address')


    # Making SQL Query
    sql = "INSERT INTO customer VALUES(%(customer_id), %(customer_name), %(customer_email), %(customer_phone), " \
          "%(customer_address))", {'customer_id': customer_id, 'customer_name': customer_name,
                                   'customer_email': customer_email, 'customer_phone': customer_phone,
                                   'customer_address': customer_address}

    cursor.execute(sql)
    connection.commit()
    print("<h1>Customer registed successfully</h1>")


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
    if len(form) == 1:
        # If the length is 1, then the forms are divided between removing products or removing a customer
        if any(form[field].value == 'product_id' for field in form):
            remove_product(form, cursor, connection)
        else:
            remove_customer(form, cursor, connection)
    elif len(form) == 2:
        # If the length is 2, then the forms are divided between
        # modifying product prices or descriptions or paying an order
        if any(form[field].value == 'order_id' for field in form):
            pay_an_order(form, cursor, connection)
        elif any(form[field].value == 'product_id_price' for field in form):
            modify_product_price(form, cursor, connection)
        else:
            modify_product_description(form, cursor, connection)
    elif len(form) == 4:
        make_an_order(form, cursor, connection)
    else:
        # If the length is bigger than 4, then the forms can be
        # only register a product or register a customer
        if any(form[field].value == 'product_sku' for field in form):
            register_product(form, cursor, connection)
        else:
            register_customer(form, cursor, connection)

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