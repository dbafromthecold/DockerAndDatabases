CREATE USER replicator WITH REPLICATION ENCRYPTED PASSWORD 'Testing1122';
SELECT * FROM pg_create_physical_replication_slot('replication_slot_slave1');