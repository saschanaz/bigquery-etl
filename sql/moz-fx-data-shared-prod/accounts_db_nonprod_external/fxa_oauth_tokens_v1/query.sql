SELECT
  TO_HEX(clientId) AS clientId,
  TO_HEX(userId) AS userId,
  type,
  scope,
  createdAt,
  expiresAt,
  SAFE.TIMESTAMP_MILLIS(SAFE_CAST(profileChangedAt AS INT)) AS profileChangedAt,
FROM
  EXTERNAL_QUERY(
    "moz-fx-fxa-nonprod.us.fxa-oauth-nonprod-stage-fxa-oauth",
    """SELECT
         clientId,
         userId,
         type,
         scope,
         createdAt,
         expiresAt,
         profileChangedAt
       FROM
         fxa_oauth.tokens
    """
  )
