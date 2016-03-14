SELECT Domain_name, data_type, udt_name
FROM Information_Schema.domains
WHERE data_type = 'character varying' AND udt_name = 'varchar'
ORDER BY 1, 2
