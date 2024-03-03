CREATE TABLE kimia_farma.kf_analisa AS 
SELECT ft.transaction_id, ft.date, ft.branch_id, kc.branch_name, kc.kota, kc.provinsi, kc.rating as rating_cabang, ft.customer_name, pc.product_id, pc.product_name, pc.price, ft.discount_percentage, pc.price * (1-ft.discount_percentage/100) as nett_sales,ft.rating as rating_transaksi,
  (pc.price*(1-ft.discount_percentage/100))*
    case  
      WHEN pc.price <= 50000 THEN 0.10 
      WHEN pc.price > 50000 and pc.price <=100000 THEN 0.15
      WHEN pc.price > 100000 and pc.price <=300000 THEN 0.20
      WHEN pc.price > 300000 and pc.price <=500000 THEN 0.25
      WHEN pc.price > 500000 THEN 0.30
      END AS persentase_gross_laba,

  (pc.price * (1-ft.discount_percentage/100))-
  (pc.price * (1-ft.discount_percentage/100))*
    case 
      WHEN pc.price <= 50000 THEN 0.10 
      WHEN pc.price > 50000 and pc.price <=100000 THEN 0.15
      WHEN pc.price > 100000 and pc.price <=300000 THEN 0.20
      WHEN pc.price > 300000 and pc.price <=500000 THEN 0.25
      WHEN pc.price > 500000 THEN 0.30
      END AS nett_profit
FROM kimia_farma.kf_final_transaction as ft
left join kimia_farma.kf_kantor_cabang as kc
  on ft.branch_id = kc.branch_id
left join kimia_farma.kf_product as pc
  on ft.product_id = pc.product_id


;