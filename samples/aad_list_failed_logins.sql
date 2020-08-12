SELECT o365investigations.auditaad.creationtime AS CreationTime,
       o365investigations.auditaad.operation    AS Operation,
       o365investigations.auditaad.workload     AS workload,
       o365investigations.auditaad.clientip     AS clientIP,
       o365investigations.auditaad.userid       AS UserId,
       ( CASE o365investigations.auditaad.organizationid
           WHEN 'TENANT1-UUID' THEN
           'tenant1.onmicrosoft.com'
           WHEN 'TENANT2-UUID' THEN
           'tenant2.onmicrosoft.com'
           ELSE 'UNKNOWN'
         end )                                  AS Tenant_name
FROM   o365investigations.auditaad
WHERE  ( ( o365investigations.auditaad.resultstatus <> 'Success' )
--         AND ( o365investigations.auditaad.clientip <> 'IPADDR' ) -- optionally whitelisted static IP address
         AND ( o365investigations.auditaad.operation <> 'UserLoggedIn' )
--         AND ( NOT(( o365investigations.auditaad.userid LIKE '%@IGNORED.TLD' ))) -- optionally ignored TLD which is used only for aliases f.e.
          )
ORDER  BY o365investigations.auditaad.creationtime DESC 
