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

Crear controlador en aplicación principal:

    $ padrino g controller base --app one

### Mmigraciones

Migraciones con DBMATE - ubicaciones:

    $ dbmate -d "ubicaciones/migrations" -e "DATABASE_UBICACIONES" new <<nombre_de_migracion>>
    $ dbmate -d "ubicaciones/migrations" -e "DATABASE_UBICACIONES" up

---

Fuentes:

+ http://padrinorb.com/
+ http://padrinorb.com/guides/generators/sub-applications/
