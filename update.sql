UPDATE properties SET type_id = CASE
  WHEN type = 'metal' THEN 1
  WHEN type = 'metalloid' THEN 2
  WHEN type = 'nonmetal' THEN 3
  END;