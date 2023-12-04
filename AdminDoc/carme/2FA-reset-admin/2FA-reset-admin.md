# How to reset the 2FA as admin

When a user's 2FA token doesn't work or is lost, the user cannot longer access to Carme. To solve this, the administrator has to reset the token.  The steps are given as follow:

1. Login to https://gpu-cluster.itwm.fraunhofer.de/admin/ to access the Admin Portal. Use `demo-admin`, unless your account has admin rights.
	
2. In the Admin Portal, click on the table `TOTP devices` (left column). A list of users with 2FA tokens appears on the right column. In this example we choose the user `ortiz`, see Fig. 1.

	![2fa-totp-devices.png](images/2fa-totp-devices.png)

	<p>Fig. 1: TOTP devices.</p><br>
	
3. Scroll down to the bottom of the page and click on `Delete`, see Fig. 2.

	![2fa-totp-devices-delete.png](images/2fa-totp-devices-delete.png)

	<p>Fig. 2: Delete TOTP device.</p><br>

4. Click on the table `Static devices` (left column). A list of users with static tokens appears on the right column. In this example we click on `backup (ortiz)`. If a user does not have static tokens, then he or she won't be listed in this table (static tokens are optional).

	![2fa-totp-static.png](images/2fa-totp-static.png)

	<p>Fig. 3: Static devices.</p><br>

5. Scroll down to the bottom of the page and click on `Delete`, see Fig. 4

	![2fa-static-devices-delete.png](images/2fa-static-devices-delete.png)
	
	<p>Fig. 4: Delete static devices</p><br>
	

**Note:** *The next time the user tries to log in, he/she will be requested to set up a 2FA.*




