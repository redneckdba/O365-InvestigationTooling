SELECT   Count(0)                                               AS count(*),
         o365investigations.auditaad.userid                     AS userid,
         o365investigations.auditaad.clientip                   AS clientip,
         o365investigations.auditaad.resultstatus               AS resultstatus,
         cast(o365investigations.auditaad.creationtime AS date) AS date, (
         CASE o365investigations.auditaad.organizationid
                  WHEN 'TENANT1-UUID' THEN 'tenant1.onmicrosoft.com'
                  WHEN 'TENANT2-UUID' THEN 'tenant2.onmicrosoft.com'
                  ELSE 'UNKNOWN'
         end ) AS tenant_name -- this gives you a readable list of tenants where the data came from
FROM     o365investigations.auditaad
WHERE 
--( ( o365investigations.auditaad.clientip <> 'IPADDR' ) AND ( o365investigations.auditaad.userid <> 'someuser@TENANT.onmicrosoft.com' ) ) -- optionally whitelisted static IP address and user
GROUP BY o365investigations.auditaad.userid,
         o365investigations.auditaad.clientip,
         o365investigations.auditaad.resultstatus,
         cast(o365investigations.auditaad.creationtime AS date),
         o365investigations.auditaad.organizationid
ORDER BY cast(o365investigations.auditaad.creationtime AS date) DESC
