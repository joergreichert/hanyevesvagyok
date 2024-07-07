select
    x.id,
    x.standortnr,
    x.artbot,
    LEAST(x.clifton_park_min, x.baumsicht_min, x.sondengaenger_min, x.zier_h_2000_min, x.baumportal_min, x.mitchell_min, x.kappel_mattheck_min) as min_alter,
    LEAST(x.clifton_park_max, x.baumsicht_max, x.sondengaenger_max, x.zier_h_2000_max, x.baumportal_max, x.mitchell_max, x.kappel_mattheck_max) as max_alter,
    x.clifton_park_min, 
    x.clifton_park_max, 
    x.baumsicht_min, 
    x.baumsicht_max, 
    x.sondengaenger_min, 
    x.sondengaenger_max, 
    x.zier_h_2000_min, 
    x.zier_h_2000_max, 
    x.baumportal_min, 
    x.baumportal_max, 
    x.mitchell_min,
    x.mitchell_max,
    x.kappel_mattheck_min,
    x.kappel_mattheck_max,
    x.lat,
    x.lng,
    x.kronendurchmesser,
    x.baumhoehe
from (
    select 
        j.id,
        j.standortnr,
        j.artbot,
        round(j.stammumfg_min::float / g.clifton_park) as clifton_park_min, 
        round(j.stammumfg_max::float / g.clifton_park) as clifton_park_max, 
        round(j.stammumfg_min::float / g.baumsicht) as baumsicht_min, 
        round(j.stammumfg_max::float / g.baumsicht) as baumsicht_max, 
        round(j.stammumfg_min::float / g.sondengaenger) as sondengaenger_min, 
        round(j.stammumfg_max::float / g.sondengaenger) as sondengaenger_max, 
        round(j.stammumfg_min::float / g.zier_h_2000) as zier_h_2000_min, 
        round(j.stammumfg_max::float / g.zier_h_2000) as zier_h_2000_max, 
        round(j.stammumfg_min::float / g.baumportal) as baumportal_min, 
        round(j.stammumfg_max::float / g.baumportal) as baumportal_max, 
        round(j.stammumfg_min::float / g.mitchell) as mitchell_min, 
        round(j.stammumfg_max::float / g.mitchell) as mitchell_max, 
        round(j.stammumfg_min::float / g.kappel_mattheck) as kappel_mattheck_min,
        round(j.stammumfg_max::float / g.kappel_mattheck) as kappel_mattheck_max,
        j.lat,
        j.lng,
        j.kronendurchmesser,
        j.baumhoehe
    from (	
        select 
            t.id, 
            t.standortnr,
            t.artbot,
            t.stammumfg,
            t.lat,
            t.lng,
            t.kronedurch as kronendurchmesser,
            t.baumhoehe,
            CASE
                WHEN t.stammumfg LIKE '%<%' THEN 
                    null
                WHEN t.stammumfg LIKE '%>%' THEN 
                    split_part(t.stammumfg, '>', 2)
                WHEN t.stammumfg LIKE '%-%' THEN 
                    split_part(t.stammumfg, '-', 1)
                ELSE t.stammumfg
            END AS stammumfg_min,
            CASE
                WHEN t.stammumfg LIKE '%<%' THEN 
                    split_part(t.stammumfg, '<', 2)
                WHEN t.stammumfg LIKE '%>%' THEN 
                    null
                WHEN t.stammumfg LIKE '%-%' THEN 
                    split_part(t.stammumfg, '-', 2)
                ELSE
                    null
            END AS stammumfg_max
        from trees as t
    ) as j
    join growth_rates g on j.artbot ILIKE (g.art_bot || '%')
) as x