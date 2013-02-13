Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:19445 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932508Ab3BMMvd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 13 Feb 2013 07:51:33 -0500
Date: Wed, 13 Feb 2013 13:51:29 +0100
From: Karel Zak <kzak@redhat.com>
To: Cody Maloney <cmaloney@theoreticalchaos.com>
Cc: util-linux@vger.kernel.org, mitr@redhat.com
Subject: Re: [PATCH v3 1/4] chsh-chfn: Add flag for enabling/disabling
 libuser support.
Message-ID: <20130213125129.GB7799@x2.net.home>
References: <1360218141-4463-1-git-send-email-cmaloney@theoreticalchaos.com>
 <1360218141-4463-2-git-send-email-cmaloney@theoreticalchaos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1360218141-4463-2-git-send-email-cmaloney@theoreticalchaos.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Feb 06, 2013 at 11:22:18PM -0700, Cody Maloney wrote:
>  configure.ac              | 17 +++++++++++++++++
>  login-utils/Makemodule.am |  5 +++++
>  2 files changed, 22 insertions(+)

 Fixed and applied.

> +AC_ARG_WITH([libuser], AS_HELP_STRING([--without-libuser], [compile without libuser (remote chsh)]),
> +  [], with_user=auto
> +)

 you have to use the same "with_" variable name as you have in AC_ARG_WITH([libuser]

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
