# Padrino Boilerplate

Instalar dependencias:

    $ bundler install --binstubs

Arrancar aplicación con Webrick:

    $ padrino s -p 4000

Arrancar aplicación con Puma:

    $ puma -p 4000

Crear sub aplicación:

    $ padrino g app one

Crear controlador en aplicación principal:

    $ padrino g controller base

Crear controlador en sub-aplicación:

    $ padrino g controller base --app one

### Mmigraciones

Migraciones con DBMATE - ubicaciones:

    $ dbmate -d "ubicaciones/migrations" -e "DATABASE_UBICACIONES" new <<nombre_de_migracion>>
    $ dbmate -d "ubicaciones/migrations" -e "DATABASE_UBICACIONES" up

Migraciones con DBMATE - archivos:

    $ dbmate -d "archivos/migrations" -e "DATABASE_ARCHIVOS" new <<nombre_de_migracion>>
    $ dbmate -d "archivos/migrations" -e "DATABASE_ARCHIVOS" up

---

Fuentes:

+ http://padrinorb.com/
+ http://padrinorb.com/guides/generators/sub-applications/
+ https://stackoverflow.com/questions/26594897/override-not-found-sinatra-application
