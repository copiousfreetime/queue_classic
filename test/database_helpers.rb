module DatabaseHelpers

  def clean_database
    drop_table
    create_table
    disconnect
  end

  def create_database
    postgres.exec "CREATE DATABASE queue_classic_test"
  end

  def drop_database
    postgres.exec "DROP DATABASE IF EXISTS queue_classic_test"
  end

  def create_table
    test_db.exec(
      "CREATE TABLE jobs"    +
      "("                    +
      "job_id    SERIAL,"    +
      "details   text,"      +
      "locked_at timestamp with time zone" +
      ");"
    )
  end

  def drop_table
    test_db.exec("DROP TABLE jobs")
  end

  def disconnect
    test_db.finish
    postgres.finish
  end

  def test_db
    @testdb ||= PGconn.connect(:dbname => 'queue_classic_test')
    @testdb.exec("SET client_min_messages TO 'warning'")
    @testdb
  end

  def postgres
    @postgres ||= PGconn.connect(:dbname => 'postgres')
    @postgres.exec("SET client_min_messages TO 'warning'")
    @postgres
  end
end