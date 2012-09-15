Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50766 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753153Ab2IOOnh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 15 Sep 2012 10:43:37 -0400
Message-ID: <50549411.9000302@draigBrady.com>
Date: Sat, 15 Sep 2012 15:43:29 +0100
From: =?ISO-8859-15?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Thomas_B=E4chler?= <thomas@archlinux.org>
CC: util-linux@vger.kernel.org, Dave Reisner <d@falconindy.com>,
        Tobias Powalowski <tpowa@archlinux.org>
Subject: Re: [su] New su utility messes with my PATH
References: <50547FE7.204@archlinux.org>
In-Reply-To: <50547FE7.204@archlinux.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 09/15/2012 02:17 PM, Thomas Bächler wrote:
> I found what I think is absolutely unexpected behaviour in the new su
> utility. It seems to have been introduced by commit a6fdd3f8.
>
> It is about /sbin and /usr/sbin being in the path: Whenever you switch
> to a non-root user, they are removed from the path, and when you switch
> to root, they are added. I find it completely unexpected that su (when
> not running with -l) messes with my environment at all.
>
> Commands like
>   PATH=... su -c "cmd" user
> do not work as expected.
>
> In my opinion, when you wish your path (or anything in the environment)
> to change you should a) use -l to start a login shell or b) configure
> your scripts to take care of it.
>
> I propose to revert the mentioned patch. Opinions?

Ouch, I agree.
su shouldn't be messing with PATH at all IMHO.

cheers,
Pádraig.
