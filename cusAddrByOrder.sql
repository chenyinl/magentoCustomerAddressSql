SELECT
    t.cid AS mid,
    t.email_ AS email,
    t.group_id_ AS group_id,
    GROUP_CONCAT(t.fname_ SEPARATOR '') AS fname,
    GROUP_CONCAT(t.lname_ SEPARATOR '') AS lname,
    t.street_ AS street,
    GROUP_CONCAT(t.city_ SEPARATOR '') AS city,
    GROUP_CONCAT(t.state_code_ SEPARATOR '') AS state_code,
    GROUP_CONCAT(t.zip_ SEPARATOR '') AS zip,
    GROUP_CONCAT(t.county_ SEPARATOR '') AS country,
    GROUP_CONCAT(t.phone_ SEPARATOR '') AS phone
FROM(
    SELECT
        ce.entity_id AS cid,
        ce.email AS email_,
        ce.group_id AS group_id_,
        caev.attribute_id AS attr,
        caet.value AS street_,
        IF(caev.attribute_id=20, caev.value, '') AS fname_,
        IF(caev.attribute_id=22, caev.value, '') AS lname_,
        IF(caev.attribute_id=26, caev.value, '') AS city_,
        IF(caev.attribute_id=28, caev.value, '') AS state_code_,
        IF(caev.attribute_id=30, caev.value, '') AS zip_,
        IF(caev.attribute_id=31, caev.value, '') AS phone_,
        IF(caev.attribute_id=27, caev.value, '') AS county_,
        caev.value AS info
    FROM
        customer_address_entity as cae, 
        customer_entity as ce,
        customer_address_entity_text AS caet,
        customer_address_entity_varchar AS caev
    where
        cae.parent_id=ce.entity_id AND
        caet.entity_id=cae.entity_id AND
        caev.entity_id=cae.entity_id
    ) AS t
WHERE t.cid in (
    SELECT 
        so.customer_id
    FROM
        sales_flat_order AS so
    WHERE
        so.entity_id >".$start." AND
        so.entity_id < ".$end."
)
GROUP BY t.cid
