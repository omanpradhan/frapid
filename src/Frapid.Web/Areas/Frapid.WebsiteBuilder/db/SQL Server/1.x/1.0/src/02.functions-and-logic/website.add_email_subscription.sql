IF OBJECT_ID('website.add_email_subscription') IS NOT NULL
DROP PROCEDURE website.add_email_subscription;

GO



CREATE PROCEDURE website.add_email_subscription
(
    @email                                  national character varying(500)
)
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS
    (
        SELECT * FROM website.email_subscriptions
        WHERE email = @email
    )
    BEGIN
        INSERT INTO website.email_subscriptions(email)
        SELECT @email;
        
        RETURN 1;
    END;

    RETURN 0;
END;

GO
