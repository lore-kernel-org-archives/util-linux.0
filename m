Return-Path: util-linux-owner@vger.kernel.org
Received: from mail6.vodafone.ie ([213.233.128.184]:62467 "EHLO
	mail6.vodafone.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbaFJN5G (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 10 Jun 2014 09:57:06 -0400
Message-ID: <53970EAF.4010801@draigBrady.com>
Date: Tue, 10 Jun 2014 14:57:03 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Ruediger Meier <sweet_f_a@gmx.de>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH] build-sys: use gettext 0.18.3 if possible
References: <1402394931-20416-1-git-send-email-sweet_f_a@gmx.de> <1402394931-20416-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1402394931-20416-2-git-send-email-sweet_f_a@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 06/10/2014 11:08 AM, Ruediger Meier wrote:
> autopoint_fun ()
> +{
> +	# we have to deal with set -e ...
> +	rm -f configure.ac.autogenbak
> +	ret="0"
> +	GT_VER_MIN="0.18"
> +	GT_VER_DEF=$(sed -n 's/AM_GNU_GETTEXT_VERSION(\[\(.*\)\])/\1/p' configure.ac)
> +	GT_VER_HAVE="$(gettext --version | head -n 1 | sed 's/.* //g')"
> +
> +	tmp=$(echo -e "$GT_VER_MIN\n$GT_VER_HAVE" | sort -V | tail -n1)
> +	tmp=$(echo -e "$GT_VER_DEF\n$tmp" | sort -V | head -n1)

You seem to be relying on coreutils here, using sort -V and tail -n
Note echo is exceptionally non portable. Better to use printf instead.

thanks,
Pádraig.
