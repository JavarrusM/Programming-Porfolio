// Databricks notebook source
// STARTER CODE - DO NOT EDIT THIS CELL
import org.apache.spark.sql.functions.desc
import org.apache.spark.sql.functions._
import org.apache.spark.sql.types._
import spark.implicits._
import org.apache.spark.sql.expressions.Window

// COMMAND ----------

// STARTER CODE - DO NOT EDIT THIS CELL
val customSchema = StructType(Array(StructField("lpep_pickup_datetime", StringType, true), StructField("lpep_dropoff_datetime", StringType, true), StructField("PULocationID", IntegerType, true), StructField("DOLocationID", IntegerType, true), StructField("passenger_count", IntegerType, true), StructField("trip_distance", FloatType, true), StructField("fare_amount", FloatType, true), StructField("payment_type", IntegerType, true)))

// COMMAND ----------

// STARTER CODE - YOU CAN LOAD ANY FILE WITH A SIMILAR SYNTAX.
val df = spark.read
   .format("com.databricks.spark.csv")
   .option("header", "true") // Use first line of all files as header
   .option("nullValue", "null")
   .schema(customSchema)
   .load("/FileStore/tables/nyc_tripdata.csv") // the csv file which you want to work with
   .withColumn("pickup_datetime", from_unixtime(unix_timestamp(col("lpep_pickup_datetime"), "MM/dd/yyyy HH:mm")))
   .withColumn("dropoff_datetime", from_unixtime(unix_timestamp(col("lpep_dropoff_datetime"), "MM/dd/yyyy HH:mm")))
   .drop($"lpep_pickup_datetime")
   .drop($"lpep_dropoff_datetime")

// COMMAND ----------

// LOAD THE "taxi_zone_lookup.csv" FILE SIMILARLY AS ABOVE. CAST ANY COLUMN TO APPROPRIATE DATA TYPE IF NECESSARY.

// ENTER THE CODE BELOW
val taxiZoneSchema = StructType(Array(StructField("TlocationID", IntegerType, true), StructField("Borough", StringType, true), StructField("Zone", StringType, true), StructField("service_zone", StringType, true)))

val taxiZone_df = spark.read
   .format("com.databricks.spark.csv")
   .option("header", "true") // Use first line of all files as header
   .option("nullValue", "null")
   .schema(taxiZoneSchema)
   .load("/FileStore/tables/taxi_zone_lookup.csv")


// COMMAND ----------

// STARTER CODE - DO NOT EDIT THIS CELL
// Some commands that you can use to see your dataframes and results of the operations. You can comment the df.show(5) and uncomment display(df) to see the data differently. You will find these two functions useful in reporting your results.
// display(df)
df.show(5) // view the first 5 rows of the dataframe

// COMMAND ----------

// STARTER CODE - DO NOT EDIT THIS CELL
// Filter the data to only keep the rows where "PULocationID" and the "DOLocationID" are different and the "trip_distance" is strictly greater than 2.0 (>2.0).

// VERY VERY IMPORTANT: ALL THE SUBSEQUENT OPERATIONS MUST BE PERFORMED ON THIS FILTERED DATA

val df_filter = df.filter($"PULocationID" =!= $"DOLocationID" && $"trip_distance" > 2.0)
df_filter.show(5)

// COMMAND ----------

// PART 1a: The top-5 most popular drop locations - "DOLocationID", sorted in descending order - if there is a tie, then one with lower "DOLocationID" gets listed first
// Output Schema: DOLocationID int, number_of_dropoffs int 

// Hint: Checkout the groupBy(), orderBy() and count() functions.

// ENTER THE CODE BELOW
val df_top5_dropoff = df_filter.groupBy($"DOLocationID")
  .agg(count(lit(1)).alias("number_of_drop_offs"))
  .orderBy($"number_of_drop_offs".desc, $"DOLocationID".asc)
  .withColumn("DOLocationID", $"DOLocationID".cast(IntegerType))
  .withColumn("number_of_drop_offs", $"number_of_drop_offs".cast(IntegerType))
  .limit(5)
  .show()

// COMMAND ----------

// PART 1b: The top-5 most popular pickup locations - "PULocationID", sorted in descending order - if there is a tie, then one with lower "PULocationID" gets listed first 
// Output Schema: PULocationID int, number_of_pickups int

// Hint: Code is very similar to part 1a above.

// ENTER THE CODE BELOW
val df_top5_pickup = df_filter.groupBy($"PULocationID")
  .agg(count(lit(1)).alias("number_of_pickups"))
  .orderBy($"number_of_pickups".desc, $"PULocationID".asc)
  .withColumn("PULocationID", $"PULocationID".cast(IntegerType))
  .withColumn("number_of_pickups", $"number_of_pickups".cast(IntegerType))
  .limit(5)
  .show()

// COMMAND ----------

// PART 2: List the top-3 locations with the maximum overall activity, i.e. sum of all pickups and all dropoffs at that LocationID. In case of a tie, the lower LocationID gets listed first.
// Output Schema: LocationID int, number_activities int

// Hint: In order to get the result, you may need to perform a join operation between the two dataframes that you created in earlier parts (to come up with the sum of the number of pickups and dropoffs on each location). 

// ENTER THE CODE BELOW
val total_do = df_filter.groupBy($"DOLocationID")
  .agg(count(lit(1)).alias("number_of_drop_offs"))

val total_pu = df_filter.groupBy($"PULocationID")
    .agg(count(lit(1)).alias("number_of_pickups"))

val combined_data = total_do.join(total_pu, $"DOLocationID" === $"PULocationID")
  .withColumn("number_activities", $"number_of_pickups" + $"number_of_drop_offs")
  .select($"DOLocationID", $"number_activities")
  .withColumnRenamed("DOLocationID", "LocationID")
  .withColumn("number_activities", $"number_activities".cast(IntegerType))
  .withColumn("LocationID", $"LocationID".cast(IntegerType))
  .orderBy($"number_activities".desc, $"LocationID".asc)
  .limit(3)
  .show()

// COMMAND ----------

// PART 3: List all the boroughs in the order of having the highest to lowest number of activities (i.e. sum of all pickups and all dropoffs at that LocationID), along with the total number of activity counts for each borough in NYC during that entire period of time.
// Output Schema: Borough string, total_number_activities int

// Hint: You can use the dataframe obtained from the previous part, and will need to do the join with the 'taxi_zone_lookup' dataframe. Also, checkout the "agg" function applied to a grouped dataframe.

// ENTER THE CODE BELOW
val active_data = total_do.join(total_pu, $"DOLocationID" === $"PULocationID")
  .withColumn("number_activities", $"number_of_pickups" + $"number_of_drop_offs")
  .join(taxiZone_df, $"TLocationID" === $"DOLocationID")
  .groupBy($"Borough")
  .agg(sum($"number_activities"))
  .withColumnRenamed("sum(number_activities)", "total_number_activities")
  .orderBy($"total_number_activities".desc)
  .withColumn("total_number_activities", $"total_number_activities".cast(IntegerType))
  .show()
  



// COMMAND ----------

// PART 4: List the top 2 days of week with the largest number of (daily) average pickups, along with the values of average number of pickups on each of the two days. The day of week should be a string with its full name, for example, "Monday" - not a number 1 or "Mon" instead.
// Output Schema: day_of_week string, avg_count float

// Hint: You may need to group by the "date" (without time stamp - time in the day) first. Checkout "to_date" function.

// ENTER THE CODE BELOW
val top_2_days = df_filter
  .withColumn("pickup_date", date_format(col("pickup_datetime"), "y-M-d"))
  .groupBy("pickup_date")
  .agg(count(lit(1)))
  .withColumn("day_of_week", date_format(col("pickup_date"), "EEEEE"))
  .groupBy("day_of_week")
  .agg(avg($"count(1)"))
  .withColumn("avg_count", $"avg(count(1))".cast(FloatType))
  .orderBy($"avg_count".desc)
  .drop($"avg(count(1))")
  .limit(2)
  .show()

// COMMAND ----------

// PART 5: For each particular hour of a day (0 to 23, 0 being midnight) - in their order from 0 to 23, find the zone in Brooklyn borough with the LARGEST number of pickups. 
// Output Schema: hour_of_day int, zone string, max_count int

// Hint: You may need to use "Window" over hour of day, along with "group by" to find the MAXIMUM count of pickups

// ENTER THE CODE BELOW

// Using Window
val top_zone = df_filter
  .withColumn("hour_of_day", date_format(col("pickup_datetime"), "H"))  
  .join(taxiZone_df, $"TLocationID" === $"PULocationID")
  .groupBy($"zone", $"hour_of_day")
  .agg(count($"PULocationID"))
  .withColumnRenamed("count(PULocationID)", "max_count")

val w = Window.partitionBy($"hour_of_day").orderBy($"max_count".desc)

val df_zone = top_zone.withColumn("row_number", row_number.over(w))
  .where($"row_number" === 1)
  .drop($"row_number")
  .withColumn("hour_of_day", $"hour_of_day".cast(IntegerType))
  .withColumn("max_count", $"max_count".cast(IntegerType))
  .orderBy($"hour_of_day".asc)
  .select($"hour_of_day", $"zone", $"max_count")
  .show(24)

// Not Using Window
// val top_zone = df_filter
//   .withColumn("hour_of_day", date_format(col("pickup_datetime"), "H"))  
//   .join(taxiZone_df, $"TLocationID" === $"PULocationID")
//   .groupBy($"zone", $"hour_of_day")
//   .agg(count($"PULocationID"))
//   .orderBy($"hour_of_day", $"count(PULocationID)".desc)
//   .groupBy($"hour_of_day")
//   .agg(max($"count(PULocationID)"), first($"zone"))
//   .orderBy($"hour_of_day".desc)
//   .show() 
//   .groupBy("hour_of_day")
//   .agg(max($"count(PULocationID)"), first($"zone"))
//   .show()

// COMMAND ----------

// PART 6 - Find which 3 different days of the January, in Manhattan, saw the largest percentage increment in pickups compared to previous day, in the order from largest increment % to smallest increment %. 
// Print the day of month along with the percent CHANGE (can be negative), rounded to 2 decimal places, in number of pickups compared to previous day.
// Output Schema: day int, percent_change float


// Hint: You might need to use lag function, over a window ordered by day of month.

// ENTER THE CODE BELOW
val window = Window.partitionBy($"month").orderBy($"day")

val jan_days = df_filter
  .filter(date_format(col("pickup_datetime"), "MMM") === "Jan")
  .withColumn("day", date_format(col("pickup_datetime"), "d"))
  .groupBy($"day")
  .agg(count(lit(1)))
  .withColumnRenamed("count(1)", "count")
  .withColumn("day", $"day".cast(IntegerType))
  .withColumn("count", $"count".cast(IntegerType))
  .withColumn("month", lit("Jan"))
  .withColumn("prev_count", lag($"count", 1).over(window))
  .withColumn("percent_change",(($"count" - $"prev_count") / $"count" ))
  .withColumn("percent_change", bround($"percent_change",2).cast(FloatType))
  .orderBy($"percent_change".desc)
  .drop("month", "prev_count", "count")
  .limit(3)
  .show()

// df.withColumn("lag",lag("salary",2).over(windowSpec))
      

// val window = Window.partitionBy("company").orderBy("company")
// df = df.withColumn("prev_value", F.lag(df.price).over(price_window))

// COMMAND ----------


