#!/usr/bin/python3
import psycopg2
import cgi

def pay_an_order(form, cursor, connection):
    order_id = form.getvalue('order_id')
    customer_num = form.getvalue('custumer_no')
    if order_id is not int:
        print('Order Number is not a full integer')
        cursor.rollback()
    if customer_num is not int:
        print('Customer Number is not a full integer')
        cursor.rollback()

    # Making SQL Query
    sql = "INSERT INTO pay VALUES(%(order_number), %(customer_number))", {'order_number': order_id, 'customer_number': customer_num}
    cursor.execute(sql)

    connection.commit()

def modify_product_price(form, cursor, connection):
    return form

def modify_product_description(form, cursor, connection):
    return form

def remove_product(form,cursor,connection):
    return form

def remove_customer(form,cursor,connection):
    return form

def make_an_order(form,cursor,connection):
    return form

def register_product(form, cursor, connection):
    return form

def register_customer(form, cursor, connection):
    return form

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
    elif len(form) == 3:
        # If the length is 2, then the forms can be only making an order
        make_an_order(form, cursor, connection)
    else:
        # If the length is bigger than 3, then the forms can be
        # only register a product or register a customer
        if any(form[field].value == 'product_sku' for field in form):
            register_product(form, cursor, connection)
        else:
            register_customer(form, cursor, connection)

except Exception as e:
    print('<h1>An error occurred.</h1>')
    print('<p>{}</p>'.format(e))
finally:
    if connection is not None:
        connection.close()

print('</body>')
print('</html>')