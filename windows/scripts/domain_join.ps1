############ CONFIG ############
$secrets_manager_secret_id = "create.alt.delete"
################################

$secret_manager = Get-SECSecretValue -SecretId $secrets_manager_secret_id
$secret = $secret_manager.SecretString | ConvertFrom-Json

$username = $secret.Domain.ToUpper() + "\" + $secret.Username
$password = $secret.Password | ConvertTo-SecureString -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($username, $password)

$instanceID = Invoke-RestMethod -Uri http://169.254.169.254/latest/meta-data/instance-id

Add-Computer -DomainName "$domain_name.$domain_tld" -NewName "$instanceID" -Credential $credential -Passthru -Verbose -Force -Restart