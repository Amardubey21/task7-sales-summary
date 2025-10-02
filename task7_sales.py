import sqlite3
import pandas as pd
import matplotlib.pyplot as plt

# 1. Connect to DB (SQLite file, not MySQL)
conn = sqlite3.connect("sales_data.db")
cursor = conn.cursor()

# 2. Create table and insert sample data
cursor.execute('''CREATE TABLE IF NOT EXISTS sales
                (id INTEGER PRIMARY KEY AUTOINCREMENT,
                 product TEXT,
                 quantity INT,
                 price REAL)''')

# Insert data only if table empty
cursor.execute("SELECT COUNT(*) FROM sales")
if cursor.fetchone()[0] == 0:
    sample_data = [
        ('Laptop', 3, 50000),
        ('Laptop', 2, 52000),
        ('Mobile', 5, 15000),
        ('Mobile', 8, 16000),
        ('Tablet', 4, 25000),
        ('Tablet', 3, 23000)
    ]
    cursor.executemany("INSERT INTO sales (product, quantity, price) VALUES (?, ?, ?)", sample_data)
    conn.commit()

# 3. Run query
query = """
SELECT product, 
       SUM(quantity) AS total_qty, 
       SUM(quantity * price) AS revenue
FROM sales
GROUP BY product
"""
df = pd.read_sql_query(query, conn)

# 4. Print results
print(df)

# 5. Plot bar chart
df.plot(kind='bar', x='product', y='revenue', legend=False)
plt.title("Revenue by Product")
plt.ylabel("Revenue (₹)")
plt.savefig("sales_chart.png")
plt.show()

# Close connection
conn.close()
