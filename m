Return-Path: util-linux-owner@vger.kernel.org
Received: from mx4-phx2.redhat.com ([209.132.183.25]:57131 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476Ab3ACQeN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 3 Jan 2013 11:34:13 -0500
Date: Thu, 3 Jan 2013 11:34:11 -0500 (EST)
From: Miloslav Trmac <mitr@redhat.com>
To: Cody Maloney <cmaloney@theoreticalchaos.com>
Cc: util-linux@vger.kernel.org
Message-ID: <805019865.52854570.1357230851238.JavaMail.root@redhat.com>
In-Reply-To: <1357183321-24637-4-git-send-email-cmaloney@theoreticalchaos.com>
Subject: Re: [PATCH 3/3] chsh: Add libuser support
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,
----- Original Message -----
> @@ -148,9 +170,11 @@ int main(int argc, char **argv)
>  
>  	printf(_("Changing shell for %s.\n"), pw->pw_name);
>  
> +#ifndef HAVE_LIBUSER
>  	if(!auth_pam(uid, pw)) {
>  		return EXIT_FAILURE;
>  	}
> +#endif
>  
>  	if (!shell) {
>  		shell = prompt(_("New shell"), oldshell);
> @@ -163,15 +187,72 @@ int main(int argc, char **argv)
>  
>  	if (strcmp(oldshell, shell) == 0)
>  		errx(EXIT_SUCCESS, _("Shell not changed."));
> +
> +#ifdef HAVE_LIBUSER
> +	ctx = lu_start(pw->pw_name, lu_user, NULL, NULL, NULL, NULL,
> &error);
AFAICS the "prompter" argument must not be NULL for LDAP to work.  lu_prompt_console_quiet (not lu_prompt_console) is a good value.


> +	memset(&val, 0, sizeof(val));
> +	g_value_init(&val, G_TYPE_STRING);
> +	g_value_set_string(&val, shell);
> +
> +	lu_ent_clear(ent, LU_LOGINSHELL);
> +	lu_ent_add(ent, LU_LOGINSHELL, &val);
If you don't mind depending on libuser >= 0.58, all of the above can be replaced with
> lu_ent_set_string(ent, LU_LOGINSHELL, shell);
and you can drop the "g_value_unset" calls as well.


> +#ifdef HAVE_LIBUSER
> +static int auth_lu(struct lu_context *ctx, uid_t uid, struct passwd
> *pw) {
> +	if(!lu_uses_elevated_privileges(ctx)) {
> +		/* Drop privileges */

"initgroups" needs to be called here to drop supplementar group memberships.

> +		if (setegid(getgid()) == -1) {
> +			errx(EXIT_FAILURE, _("Couldn't drop group privileges"));
> +			return FALSE;
> +		}
> +		if (seteuid(getuid()) == -1) {
> +			errx(EXIT_FAILURE, _("Couldn't drop group privileges"));
> +			return FALSE;
> +		}
> +		return TRUE;
> +	}
> +
> +	return auth_pam(uid, pw);
> +}
> +#endif
