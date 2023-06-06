import psycopg2
import cgi

ist_id = 'ist1103641'
host = 'db.tecnico.ulisboa.pt'
port = 5432
password = 'Tomastab2003'
db_name = ist_id

connection = None
dsn = 'host={} port={} user={} password={} dbname={}'.format(host, port, ist_id, password, db_name)

try:
    # Create a connection
    connection = psycopg2.connect(dsn)
    print('<p>Connected</p>')

    cursor = connection.cursor()
    sql_query = 'SELECT * FROM customer;'
    cursor.execute(sql_query)

    # Header
    print('Content-type:text/html\n')
    print('<html>')
    print('<head>')
    print('<title>Python CGI Test</title>')
    print('</head>')
    print('</html>')

    result = cursor.fetchall()
    row_count = len(result)
    print('<p>How many rows: {}</p>'.format(row_count))
    col_count = len(cursor.description)
    print('<p>How many columns: {}</p>'.format(col_count))

    # Printing the result
    print('<table border=“5”>')
    for row in result:app
        print('<tr>')
        for value in row:
            print(' < td > {} < / td > '.format(value))
        print('</tr>')
    print('</table>')

    # Closing the cursor
    cursor.close()
    print('<p>Test completed successfully.</p>')

    # Free the connection
    connection.close()

except Exception as error:
    print('<h1>An error occurred.</h1>')
    print('<p>{}</p>'.format(error))
finally:
    if connection is not None:
        connection.close()
        print('<p>Connection closed.</p>')