select 
	y.external_tree_id,
	y.standortnr,
	y.artbot,
	2024 - y.pflanzjahr as real_age,
	y.alter as min_calc_age,
	2024 - y.pflanzjahr - y.alter as diff_min_calc_to_real_age,
	2024 - y.pflanzjahr - y.clifton_park as diff_clifton_park_calc_to_real_age,
	2024 - y.pflanzjahr - y.baumsicht as diff_baumsicht_calc_to_real_age,
	2024 - y.pflanzjahr - y.sondengaenger as diff_sondengaenger_calc_to_real_age,
	2024 - y.pflanzjahr - y.zier_h_2000 as diff_zier_h_2000_calc_to_real_age,
	2024 - y.pflanzjahr - y.baumportal as diff_baumportal_calc_to_real_age,
	2024 - y.pflanzjahr - y.mitchell as diff_mitchell_calc_to_real_age,
	2024 - y.pflanzjahr - y.kappel_mattheck as diff_kappel_mattheck_calc_to_real_age,
	y.lat,
	y.lng,
	y.kronendurchmesser,
	y.baumhoehe
from (	
	select
		x.external_tree_id,
		x.standortnr,
		x.artbot,
		x.pflanzjahr,
		LEAST(x.clifton_park, x.baumsicht, x.sondengaenger, x.zier_h_2000, x.baumportal, x.mitchell, x.kappel_mattheck) as alter,
		x.clifton_park, 
		x.baumsicht, 
		x.sondengaenger, 
		x.zier_h_2000, 
		x.baumportal, 
		x.mitchell,
		x.kappel_mattheck,
		x.lat,
		x.lng,
		x.kronendurchmesser,
		x.baumhoehe
	from (
		select 
			j.external_tree_id,
			j.standortnr,
			j.artbot,
			j.pflanzjahr,
			round(j.stammumfg::float / g.clifton_park) as clifton_park, 
			round(j.stammumfg::float / g.baumsicht) as baumsicht, 
			round(j.stammumfg::float / g.sondengaenger) as sondengaenger, 
			round(j.stammumfg::float / g.zier_h_2000) as zier_h_2000, 
			round(j.stammumfg::float / g.baumportal) as baumportal, 
			round(j.stammumfg::float / g.mitchell) as mitchell,
			round(j.stammumfg::float / g.kappel_mattheck) as kappel_mattheck,
			j.lat,
			j.lng,
			j.kronendurchmesser,
			j.baumhoehe
		from (	
			select 
				t.external_tree_id, 
				t.standortnr,
				t.artbot,
				t.pflanzjahr,
				t.stammumfg,
				t.lat,
				t.lng,
				t.kronedurch as kronendurchmesser,
				t.baumhoehe
			from trees as t
		) as j
		join growth_rates g on j.artbot ILIKE (g.art_bot || '%')
	) as x
) as y