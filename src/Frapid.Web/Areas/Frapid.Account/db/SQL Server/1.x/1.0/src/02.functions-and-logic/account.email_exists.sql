IF OBJECT_ID('account.email_exists') IS NOT NULL
DROP FUNCTION account.email_exists;

GO


CREATE FUNCTION account.email_exists(@email national character varying(100))
RETURNS bit
AS
BEGIN
    DECLARE @count integer;

    SELECT @count = count(*)  
    FROM account.users WHERE email = @email;

    IF(COALESCE(@count, 0) = 0)
    BEGIN
        SELECT @count = count(*)  
        FROM account.registrations WHERE email = @email;
    END;
    
    IF COALESCE(@count, 0) > 0
    BEGIN
		RETURN 1;
	END;
	
	RETURN 0;
END;


GO