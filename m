Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33921 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933763Ab3BMMxn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 13 Feb 2013 07:53:43 -0500
Date: Wed, 13 Feb 2013 13:53:39 +0100
From: Karel Zak <kzak@redhat.com>
To: Cody Maloney <cmaloney@theoreticalchaos.com>
Cc: util-linux@vger.kernel.org, mitr@redhat.com
Subject: Re: [PATCH v3 2/4] chsh-chfn: Move pam auth to its own function,
 factoring out common code
Message-ID: <20130213125339.GC7799@x2.net.home>
References: <1360218141-4463-1-git-send-email-cmaloney@theoreticalchaos.com>
 <1360218141-4463-3-git-send-email-cmaloney@theoreticalchaos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1360218141-4463-3-git-send-email-cmaloney@theoreticalchaos.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Feb 06, 2013 at 11:22:19PM -0700, Cody Maloney wrote:
>  login-utils/Makemodule.am |  2 ++
>  login-utils/auth.c        | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  login-utils/auth.h        | 13 +++++++++++++
>  login-utils/chfn.c        | 33 +++------------------------------
>  login-utils/chsh.c        | 33 +++------------------------------
>  5 files changed, 68 insertions(+), 60 deletions(-)
>  create mode 100644 login-utils/auth.c
>  create mode 100644 login-utils/auth.h

 Fixed and applied.

> +int auth_pam(const char *service_name, uid_t uid, const char *username) {
> +#ifdef REQUIRE_PASSWORD
> +	if (uid != 0) {
> +		pam_handle_t *pamh = NULL;
> +		struct pam_conv conv = { misc_conv, NULL };
> +		int retcode;
> +
> +		retcode = pam_start(service_name, username, &conv, &pamh);
> +		if (pam_fail_check(pamh, retcode))
> +			return FALSE;
> +
> +		retcode = pam_authenticate(pamh, 0);
> +		if (pam_fail_check(pamh, retcode))
> +			return FALSE;
> +
> +		retcode = pam_acct_mgmt(pamh, 0);
> +		if (retcode == PAM_NEW_AUTHTOK_REQD)
> +			retcode =
> +			    pam_chauthtok(pamh, PAM_CHANGE_EXPIRED_AUTHTOK);
> +		if (pam_fail_check(pamh, retcode))
> +			return FALSE;
> +
> +		retcode = pam_setcred(pamh, 0);
> +		if (pam_fail_check(pamh, retcode))
> +			return FALSE;
> +
> +		pam_end(pamh, 0);
> +		/* no need to establish a session; this isn't a
> +		 * session-oriented activity...  */
> +	}
> +	return TRUE;
> +#endif	/* REQUIRE_PASSWORD */
> +}

 what happen if REQUIRE_PASSWORD is not defined? 

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
