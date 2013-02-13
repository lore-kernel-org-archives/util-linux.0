Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42993 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932508Ab3BMMz2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 13 Feb 2013 07:55:28 -0500
Date: Wed, 13 Feb 2013 13:55:25 +0100
From: Karel Zak <kzak@redhat.com>
To: Cody Maloney <cmaloney@theoreticalchaos.com>
Cc: util-linux@vger.kernel.org, mitr@redhat.com
Subject: Re: [PATCH v3 3/4] chsh: Add libuser support
Message-ID: <20130213125525.GD7799@x2.net.home>
References: <1360218141-4463-1-git-send-email-cmaloney@theoreticalchaos.com>
 <1360218141-4463-4-git-send-email-cmaloney@theoreticalchaos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1360218141-4463-4-git-send-email-cmaloney@theoreticalchaos.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Feb 06, 2013 at 11:22:20PM -0700, Cody Maloney wrote:
>  login-utils/Makemodule.am |  3 ++
>  login-utils/chsh.c        | 22 ++++++++++++-
>  login-utils/libuser.c     | 80 +++++++++++++++++++++++++++++++++++++++++++++++
>  login-utils/libuser.h     | 14 +++++++++
>  4 files changed, 118 insertions(+), 1 deletion(-)
>  create mode 100644 login-utils/libuser.c
>  create mode 100644 login-utils/libuser.h

 Fixed and applied.

> +static int auth_lu(const char *service_name, struct lu_context *ctx, uid_t uid,
> +			const char *username) {
> +	if(!lu_uses_elevated_privileges(ctx)) {
> +		/* Drop privileges */
> +		if (setegid(getgid()) == -1) {
> +			errx(EXIT_FAILURE, _("Couldn't drop group privileges"));
> +			return FALSE;
> +		}

 errx() and err() are no-return functions ;-)

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
