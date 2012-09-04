Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35510 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757811Ab2IDTwV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 4 Sep 2012 15:52:21 -0400
Message-ID: <50465BEE.7070005@draigBrady.com>
Date: Tue, 04 Sep 2012 20:52:14 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux <util-linux@vger.kernel.org>,
        Ludwig Nussel <ludwig.nussel@suse.de>
Subject: Re: runuser(1) and su(1) -g/-G
References: <20120904151843.GA6389@x2.net.home>
In-Reply-To: <20120904151843.GA6389@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 09/04/2012 04:18 PM, Karel Zak wrote:
>
>   Hi,
>
> I did some changes to the su(1):
>
>    - add --group= option to specify the primary group
>    - add --supp-group= option to specify a supplemental group
>
> the both options are based on Fedora runuser(1) patch and it's
> available for root only (non-root cannot specify any groups).
>
>
> I have also added new command runuser(1) -- it's completely based on
> su(1) code. The difference is that runuser does not ask for password,
> has to be executed by root and it uses different PAM configuration
> (/etc/pam.d/runuser[-l]).

Thanks for doing all that Karel.
I've not time to look now,
but will note that many were looking for
a lightweight option that didn't need PAM.
Perhaps PAM support could be easily compiled out?

cheers,
Pádraig.

>
> The changes should be available in v2.23 (or easily backported to
> 2.22, I'll do that for Fedora).
>
> See master branch and "git whatchanged login-utils/".
>
>      Karel
>

