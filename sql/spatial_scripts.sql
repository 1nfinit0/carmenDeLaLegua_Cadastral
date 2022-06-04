\c catastro;

ALTER TABLE clegua.limite DROP COLUMN id;

ALTER TABLE clegua.limite ADD COLUMN ubigeo varchar;

UPDATE clegua.limite y
    SET ubigeo = x.ubigeo
    FROM clegua.ubigeo_inei x
    WHERE x.distrito = 'Carmen de La Legua';
    
ALTER TABLE clegua.sector ADD COLUMN sector VARCHAR;

UPDATE clegua.sector
    SET sector = '0'||id::varchar
    
ALTER TABLE clegua.lote ADD COLUMN ubigeo varchar(6);
ALTER TABLE clegua.lote ADD COLUMN sector varchar(2);
ALTER TABLE clegua.lote ADD COLUMN manzana varchar(3);
ALTER TABLE clegua.lote ADD COLUMN edifica varchar(2);
ALTER TABLE clegua.lote ADD COLUMN entrada varchar(2);
ALTER TABLE clegua.lote ADD COLUMN piso varchar(2);
ALTER TABLE clegua.lote ADD COLUMN unidad varchar(3);
ALTER TABLE clegua.lote ADD COLUMN cod_ref_catastral varchar(24);
ALTER TABLE clegua.lote ADD COLUMN dtotal float;
ALTER TABLE clegua.lote ADD COLUMN dcontrol varchar(1);
ALTER TABLE clegua.manzana ADD COLUMN manzana varchar(3);

DELETE FROM clegua.lote
    WHERE gid > 0 AND gid <= 12
        
UPDATE clegua.manzana x
    SET manzana = y.codigo
    FROM clegua.centroides_manzanas y
    WHERE ST_CONTAINS(x.geom,y.geom) = true;
    
update clegua.lote
    set manzana = '0'||manzana
    where length(manzana)=2
    
update clegua.lote
    set manzana = '00'||manzana
    where length(manzana)=1
    

UPDATE clegua.lote x
        SET ubigeo = u.ubigeo
        FROM clegua.ubigeo_inei u
        WHERE ST_CONTAINS(u.geom, x.geom) = true;
UPDATE clegua.lote x
        SET sector = s.sector
        FROM clegua.sector s
        WHERE ST_CONTAINS(s.geom, x.geom) = true;
UPDATE clegua.lote x
        SET manzana = m.manzana
        FROM clegua.manzana m
        WHERE ST_CONTAINS(m.geom, x.geom) = true;
UPDATE clegua.lote
        SET manzana = 005
        WHERE manzana IS NULL;
UPDATE clegua.lote
        SET edifica = 0||(TRUNC(random()*(5-1)+1))::varchar;
UPDATE clegua.lote
        SET entrada = 0||(TRUNC(random()*(3-1)+1))::varchar;
UPDATE clegua.lote
        SET piso = 0||(TRUNC(random()*(7-1)+1))::varchar;
UPDATE clegua.lote
        SET unidad = '00'||(TRUNC(random()*(7-1)+1))::varchar;
UPDATE clegua.lote
        SET dtotal = (SELECT  (substring(ubigeo::text,1,1))::int+
        (substring(ubigeo::text,2,1))::int+
        (substring(ubigeo::text,3,1))::int+
        (substring(ubigeo::text,4,1))::int+
        (substring(ubigeo::text,5,1))::int+
        (substring(ubigeo::text,6,1))::int+
        (substring(sector::text,1,1))::int+
        (substring(sector::text,2,1))::int+
        (substring(manzana::text,1,1))::int+
        (substring(manzana::text,2,1))::int+
        (substring(manzana::text,3,1))::int+
        (substring(lote::text,1,1))::int+
        (substring(lote::text,2,1))::int+
        (substring(lote::text,3,1))::int+
        (substring(edifica::text,1,1))::int+
        (substring(edifica::text,2,1))::int+
        (substring(entrada::text,1,1))::int+
        (substring(entrada::text,2,1))::int+
        (substring(piso::text,1,1))::int+
        (substring(piso::text,2,1))::int+
        (substring(unidad::text,1,1))::int+
        (substring(unidad::text,2,1))::int+
        (substring(unidad::text,3,1))::int)



UPDATE clegua.lote SET
    dcontrol = trunc(10*(dtotal/9-trunc(dtotal/9)))
   
        
        
UPDATE clegua.lote
        SET cod_ref_catastral = ubigeo||sector||manzana||lote||edifica||entrada||piso||unidad||dcontrol
