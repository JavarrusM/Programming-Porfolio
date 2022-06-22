########################### DO NOT MODIFY THIS SECTION ##########################
#################################################################################
import sqlite3
from sqlite3 import Error
import csv
#################################################################################

## Change to False to disable Sample
SHOW = True

############### SAMPLE CLASS AND SQL QUERY ###########################
######################################################################
class Sample():
    def sample(self):
        try:
            connection = sqlite3.connect("sample")
            connection.text_factory = str
        except Error as e:
            print("Error occurred: " + str(e))
        print('\033[32m' + "Sample: " + '\033[m')
        
        # Sample Drop table
        connection.execute("DROP TABLE IF EXISTS sample;")
        # Sample Create
        connection.execute("CREATE TABLE sample(id integer, name text);")
        # Sample Insert
        connection.execute("INSERT INTO sample VALUES (?,?)",("1","test_name"))
        connection.commit()
        # Sample Select
        cursor = connection.execute("SELECT * FROM sample;")
        print(cursor.fetchall())

######################################################################

class HW2_sql():
    ############### DO NOT MODIFY THIS SECTION ###########################
    ######################################################################
    def create_connection(self, path):
        connection = None
        try:
            connection = sqlite3.connect(path)
            connection.text_factory = str
        except Error as e:
            print("Error occurred: " + str(e))
    
        return connection

    def execute_query(self, connection, query):
        cursor = connection.cursor()
        try:
            if query == "":
                return "Query Blank"
            else:
                cursor.execute(query)
                connection.commit()
                return "Query executed successfully"
        except Error as e:
            return "Error occurred: " + str(e)
    ######################################################################
    ######################################################################

    # GTusername [0 points]
    def GTusername(self):
        gt_username = "jmickl6"
        return gt_username
    
    # Part a.i Create Tables [2 points]
    def part_ai_1(self,connection):
        ############### EDIT SQL STATEMENT ###################################
        part_ai_1_sql = """CREATE TABLE MOVIES (
                            ID INTEGER,
                            TITLE TEXT,
                            SCORE REAL
                        );"""
        ######################################################################
        
        return self.execute_query(connection, part_ai_1_sql)

    def part_ai_2(self,connection):
        ############### EDIT SQL STATEMENT ###################################
        part_ai_2_sql = """CREATE TABLE MOVIE_CAST (
                            MOVIE_ID INTEGER,
                            CAST_ID INTEGER,
                            CAST_NAME TEXT,
                            BIRTHDAY TEXT,
                            POPULARITY REAL
                        );"""
        ######################################################################
        
        return self.execute_query(connection, part_ai_2_sql)
    
    # Part a.ii Import Data [2 points]
    def part_aii_1(self,connection,path):
        ############### CREATE IMPORT CODE BELOW ############################
        with open('./data/movies.csv', newline='', errors='ignore') as movies:
            moviereader = csv.reader(movies, delimiter=',')
            for row in moviereader:
                query = "INSERT INTO MOVIES (ID, TITLE, SCORE) VALUES " + str(tuple(row)) + ";"
                connection.execute(query)
       ######################################################################
        
        sql = "SELECT COUNT(id) FROM movies;"
        cursor = connection.execute(sql)
        return cursor.fetchall()[0][0]
    
    def part_aii_2(self,connection, path):
        ############### CREATE IMPORT CODE BELOW ############################
        with open('./data/movie_cast.csv', newline='', errors='ignore') as movie_cast:
            movie_castreader = csv.reader(movie_cast, delimiter=',')
            for row in movie_castreader:
                query = "INSERT INTO MOVIE_CAST (MOVIE_ID, CAST_ID, CAST_NAME, BIRTHDAY, POPULARITY) VALUES " + str(tuple(row)) + ";"
                connection.execute(query)
        ######################################################################
        
        sql = "SELECT COUNT(cast_id) FROM movie_cast;"
        cursor = connection.execute(sql)
        return cursor.fetchall()[0][0]

    # Part a.iii Vertical Database Partitioning [5 points]
    def part_aiii(self,connection):
        ############### EDIT CREATE TABLE SQL STATEMENT ###################################
        part_aiii_sql = """ CREATE TABLE CAST_BIO (
                                CAST_ID INTEGER,
                                CAST_NAME TEXT,
                                BIRTHDAY DATE,
                                POPULARITY REAL

                            );
                        """
        ######################################################################
        
        self.execute_query(connection, part_aiii_sql)
        
        ############### CREATE IMPORT CODE BELOW ############################
        part_aiii_insert_sql = """INSERT INTO CAST_BIO
                                    (
                                        CAST_ID,
                                        CAST_NAME,
                                        BIRTHDAY,
                                        POPULARITY
                                    ) 
                                    SELECT DISTINCT
                                    MC.CAST_ID, 
                                    MC.CAST_NAME, 
                                    MC.BIRTHDAY,
                                    MC.POPULARITY
                                    FROM MOVIE_CAST MC;
                                    
        
        """
        ######################################################################
        
        self.execute_query(connection, part_aiii_insert_sql)
        
        sql = "SELECT COUNT(cast_id) FROM cast_bio;"
        cursor = connection.execute(sql)
        return cursor.fetchall()[0][0]
       

    # Part b Create Indexes [1 points]
    def part_b_1(self,connection):
        ############### EDIT SQL STATEMENT ###################################
        part_b_1_sql = "CREATE INDEX movie_index ON MOVIES (id);"
        ######################################################################
        return self.execute_query(connection, part_b_1_sql)
    
    def part_b_2(self,connection):
        ############### EDIT SQL STATEMENT ###################################
        part_b_2_sql = "CREATE INDEX cast_index ON MOVIE_CAST (cast_id);"
        ######################################################################
        return self.execute_query(connection, part_b_2_sql)
    
    def part_b_3(self,connection):
        ############### EDIT SQL STATEMENT ###################################
        part_b_3_sql = "CREATE INDEX cast_bio_index ON CAST_BIO (cast_Id);"
        ######################################################################
        return self.execute_query(connection, part_b_3_sql)
    
    # Part c Calculate a Proportion [3 points]
    def part_c(self,connection):
        ############### EDIT SQL STATEMENT ###################################
        part_c_sql = """SELECT  printf("%0.2f",100.0 * COUNT(CASE WHEN SCORE > 50 AND TITLE LIKE "%war%" THEN 1 END)/COUNT(*))
                        FROM MOVIES;
                     """
        ######################################################################
        cursor = connection.execute(part_c_sql)
        return cursor.fetchall()[0][0]

    # Part d Find the Most Prolific Actors [4 points]
    def part_d(self,connection):
        ############### EDIT SQL STATEMENT ###################################
        part_d_sql = """SELECT CAST_NAME, COUNT(MOVIE_ID) AS APPEARANCE_COUNT 
                        FROM MOVIE_CAST
                        WHERE POPULARITY > 10
                        GROUP BY CAST_NAME
                        ORDER BY APPEARANCE_COUNT DESC, CAST_NAME
                        LIMIT 5;
                    """
        ######################################################################
        cursor = connection.execute(part_d_sql)
        return cursor.fetchall()

    # Part e Find the Highest Scoring Movies With the Least Amount of Cast [4 points]
    def part_e(self,connection):
        ############### EDIT SQL STATEMENT ###################################
        part_e_sql = """SELECT TITLE, printf("%0.2f",SCORE) AS MOVIE_SCORE, COUNT(CAST_NAME) AS CAST_COUNT
                        FROM MOVIES
                        INNER JOIN MOVIE_CAST ON MOVIE_CAST.MOVIE_ID = MOVIES.ID
                        GROUP BY MOVIE_ID
                        ORDER BY 1.0 * MOVIE_SCORE DESC, CAST_COUNT ASC
                        LIMIT 5;
                    """
        ######################################################################
        cursor = connection.execute(part_e_sql)
        return cursor.fetchall()
    
    # Part f Get High Scoring Actors [4 points]
    def part_f(self,connection):
        ############### EDIT SQL STATEMENT ###################################
        part_f_sql = """SELECT CAST_ID, CAST_NAME,  printf('%0.2f',AVG(SCORE)) AS AVERAGE_SCORE
                        FROM MOVIES
                        INNER JOIN MOVIE_CAST ON MOVIE_CAST.MOVIE_ID = MOVIES.ID
                        WHERE SCORE >= 25
                        GROUP BY CAST_ID
                        HAVING COUNT(*) > 2
                        ORDER BY 1.0 * AVERAGE_SCORE DESC, CAST_NAME ASC
                        LIMIT 10;
        """
        ######################################################################
        cursor = connection.execute(part_f_sql)
        return cursor.fetchall()

    # Part g Creating Views [6 points]
    def part_g(self,connection):
        ############### EDIT SQL STATEMENT ###################################
        part_g_sql = """CREATE VIEW good_collaboration
                        AS 
                        SELECT
                            MB1.CAST_ID AS CAST_MEMBER_ID1,
                            MB2.CAST_ID AS CAST_MEMBER_ID2,
                            COUNT(MB1.MOVIE_ID) AS MOVIE_COUNT,
                            AVG(SCORE) AS AVERAGE_MOVIE_SCORE
                        FROM
                            MOVIE_CAST AS MB1
                        INNER JOIN MOVIE_CAST AS MB2 ON MB1.MOVIE_ID = MB2.MOVIE_ID
                        INNER JOIN MOVIES AS MOVIES ON MB1.MOVIE_ID = MOVIES.ID
                        --GROUP BY MB1.MOVIE_ID
                        WHERE CAST_MEMBER_ID1 < CAST_MEMBER_ID2
                        GROUP BY CAST_MEMBER_ID1, CAST_MEMBER_ID2
                        HAVING MOVIE_COUNT >= 3 AND 1.0 * AVERAGE_MOVIE_SCORE >= 40;
                    """
        ######################################################################
        return self.execute_query(connection, part_g_sql)
    
    def part_gi(self,connection):
        ############### EDIT SQL STATEMENT ###################################
        part_g_i_sql = """  SELECT CAST_MEMBER_ID1,  CAST_BIO.CAST_NAME, printf("%0.2f",AVG(AVERAGE_MOVIE_SCORE)) AS COLLABORATION_SCORE
                            FROM GOOD_COLLABORATION
                            INNER JOIN CAST_BIO ON GOOD_COLLABORATION.CAST_MEMBER_ID1 = CAST_BIO.CAST_ID
                            GROUP BY CAST_MEMBER_ID1
                            ORDER BY 1.0 * COLLABORATION_SCORE DESC, CAST_NAME ASC
                            LIMIT 5;
                       """
        ######################################################################
        cursor = connection.execute(part_g_i_sql)
        return cursor.fetchall()
    
    # Part h FTS [4 points]
    def part_h(self,connection,path):
        ############### EDIT SQL STATEMENT ###################################
        part_h_sql = """CREATE VIRTUAL TABLE MOVIE_OVERVIEW USING fts3(
                            ID INTEGER,
                            OVERVIEW TEXT
                        );
                    """
        ######################################################################
        connection.execute(part_h_sql)
        ############### CREATE IMPORT CODE BELOW ############################
        with open('./data/movie_overview.csv', newline='', errors='ignore', encoding='utf-8-sig') as movie_overview:
            movie_overviewreader = csv.reader(movie_overview, delimiter=',')
            for row in movie_overviewreader:
                id = row[0]
                doc = row[1].replace('\"', '\'') 
                query = "INSERT INTO MOVIE_OVERVIEW (ID, OVERVIEW) VALUES " + str((id, doc)) + ";"
                connection.execute(query)
        ######################################################################
        sql = "SELECT COUNT(id) FROM movie_overview;"
        cursor = connection.execute(sql)
        return cursor.fetchall()[0][0]
        
    def part_hi(self,connection):
        ############### EDIT SQL STATEMENT ###################################
        part_hi_sql = "SELECT COUNT(*) FROM MOVIE_OVERVIEW WHERE OVERVIEW MATCH 'fight'"
        ######################################################################
        cursor = connection.execute(part_hi_sql)
        return cursor.fetchall()[0][0]
    
    def part_hii(self,connection):
        ############### EDIT SQL STATEMENT ###################################
        part_hii_sql = """SELECT COUNT(*) FROM MOVIE_OVERVIEW WHERE OVERVIEW MATCH 'space NEAR/5 program';"""
        ######################################################################
        cursor = connection.execute(part_hii_sql)
        return cursor.fetchall()[0][0]


if __name__ == "__main__":
    
    ########################### DO NOT MODIFY THIS SECTION ##########################
    #################################################################################
    if SHOW == True:
        sample = Sample()
        sample.sample()

    print('\033[32m' + "Q2 Output: " + '\033[m')
    db = HW2_sql()
    try:
        conn = db.create_connection("Q2")
    except:
        print("Database Creation Error")

    try:
        conn.execute("DROP TABLE IF EXISTS movies;")
        conn.execute("DROP TABLE IF EXISTS movie_cast;")
        conn.execute("DROP TABLE IF EXISTS cast_bio;")
        conn.execute("DROP VIEW IF EXISTS good_collaboration;")
        conn.execute("DROP TABLE IF EXISTS movie_overview;")
    except:
        print("Error in Table Drops")

    try:
        print('\033[32m' + "part ai 1: " + '\033[m' + str(db.part_ai_1(conn)))
        print('\033[32m' + "part ai 2: " + '\033[m' + str(db.part_ai_2(conn)))
    except:
         print("Error in Part a.i")

    try:
        print('\033[32m' + "Row count for Movies Table: " + '\033[m' + str(db.part_aii_1(conn,"data/movies.csv")))
        print('\033[32m' + "Row count for Movie Cast Table: " + '\033[m' + str(db.part_aii_2(conn,"data/movie_cast.csv")))
    except:
        print("Error in part a.ii")

    try:
        print('\033[32m' + "Row count for Cast Bio Table: " + '\033[m' + str(db.part_aiii(conn)))
    except:
        print("Error in part a.iii")

    try:
        print('\033[32m' + "part b 1: " + '\033[m' + db.part_b_1(conn))
        print('\033[32m' + "part b 2: " + '\033[m' + db.part_b_2(conn))
        print('\033[32m' + "part b 3: " + '\033[m' + db.part_b_3(conn))
    except:
        print("Error in part b")

    try:
        print('\033[32m' + "part c: " + '\033[m' + str(db.part_c(conn)))
    except:
        print("Error in part c")

    try:
        print('\033[32m' + "part d: " + '\033[m')
        for line in db.part_d(conn):
            print(line[0],line[1])
    except:
        print("Error in part d")

    try:
        print('\033[32m' + "part e: " + '\033[m')
        for line in db.part_e(conn):
            print(line[0],line[1],line[2])
    except:
        print("Error in part e")

    try:
        print('\033[32m' + "part f: " + '\033[m')
        for line in db.part_f(conn):
            print(line[0],line[1],line[2])
    except:
        print("Error in part f")
    
    try:
        print('\033[32m' + "part g: " + '\033[m' + str(db.part_g(conn)))
        print('\033[32m' + "part g.i: " + '\033[m')
        for line in db.part_gi(conn):
            print(line[0],line[1],line[2])
    except:
        print("Error in part g")

    try:   
        print('\033[32m' + "part h.i: " + '\033[m'+ str(db.part_h(conn,"data/movie_overview.csv")))
        print('\033[32m' + "Count h.ii: " + '\033[m' + str(db.part_hi(conn)))
        print('\033[32m' + "Count h.iii: " + '\033[m' + str(db.part_hii(conn)))
    except:
        print("Error in part h")

    conn.close()
    #################################################################################
    #################################################################################
  
