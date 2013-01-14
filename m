Return-Path: util-linux-owner@vger.kernel.org
Received: from mx4-phx2.redhat.com ([209.132.183.25]:45527 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757040Ab3ANSQS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 14 Jan 2013 13:16:18 -0500
Date: Mon, 14 Jan 2013 13:16:17 -0500 (EST)
From: Miloslav Trmac <mitr@redhat.com>
To: Cody Maloney <cmaloney@theoreticalchaos.com>
Cc: util-linux@vger.kernel.org
Message-ID: <1628490120.7233795.1358187377636.JavaMail.root@redhat.com>
In-Reply-To: <1358068345-773-5-git-send-email-cmaloney@theoreticalchaos.com>
Subject: Re: [PATCH v2 3/4] chsh: Add libuser support
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,
----- Original Message -----
> diff --git a/login-utils/libuser.c b/login-utils/libuser.c
> new file mode 100644
> index 0000000..9a3e3b1
> --- /dev/null
> +++ b/login-utils/libuser.c
> +static int auth_lu(const char *service_name, struct lu_context *ctx,
> uid_t uid,
> +			const char *username) {
> +	if(!lu_uses_elevated_privileges(ctx)) {
> +		/* Drop privileges */
> +		if (setegid(getgid()) == -1) {
> +			errx(EXIT_FAILURE, _("Couldn't drop group privileges"));
> +			return FALSE;
> +		}
> +		if (seteuid(getuid()) == -1) {
> +			errx(EXIT_FAILURE, _("Couldn't drop group privileges"));
> +			return FALSE;
> +		}
> +		if (initgroups(username, 0)) {
> +			errx(EXIT_FAILURE, _("Couldn't drop group privileges"));
> +			return FALSE;
> +		}

I can't see how this can work: after seteuid() the program no longer has root privileges (CAP_SETGID) to change the groups.

(On second thought, if the program is setuid, the setuid execution mechanism doesn't change supplementary groups, so perhaps the call isn't strictly necessary; Still, initializing the groups makes the environment more deterministic.  And as long as initgroups() is called, it should be called in a way that works.)

> +	lu_ent_set_string(ent, attr, val);
> +	if (!lu_user_modify(ctx, ent, &error)) {
> +		lu_ent_free(ent);
> +		lu_end(ctx);
> +		err(EXIT_FAILURE, _("Shell not changed: %s\n"),
> lu_strerror(error));

This error message is fine for chsh, but not great for chfn.
    Mirek
