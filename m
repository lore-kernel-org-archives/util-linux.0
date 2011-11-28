Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59181 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751647Ab1K1JCG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 28 Nov 2011 04:02:06 -0500
Date: Mon, 28 Nov 2011 10:01:57 +0100
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: Paul Stone <Paul@stone.org>, util-linux@vger.kernel.org
Subject: Re: how can I compile mount and umount as shared object files?
Message-ID: <20111128090157.GA29168@nb.net.home>
References: <CA+zVqtWW+CknuW7NKyd2AZVsrDwj=J7gg+U2UYEBgbp++vaZgA@mail.gmail.com> <201111231358.16493.vapier@gentoo.org> <CA+zVqtWCj=zRaOeesLfaOABHiuBcQMqTZRfJwE84s_G=Z8qAAA@mail.gmail.com> <201111262010.03052.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201111262010.03052.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Nov 26, 2011 at 08:10:02PM -0500, Mike Frysinger wrote:
> On Saturday 26 November 2011 19:34:38 Paul Stone wrote:
> > Thanks Mike,
> 
> please don't top post
> 
> > Any idea why they are compiled as PIEs for CentOS (and presumably Red Hat)?
> 
> i vaguely recall that RedHat's policy is to build all set*id and network 
> daemons as PIEs as security precautions.  Karel would probably know more.

 Yes, copy & past from util-linux.spec:

    export SUID_CFLAGS="-fpie"
    export SUID_LDFLAGS="-pie"
    %configure \
      ....

 the SUID_* variable are supported by upstream, see
 Documentation/howto-compilation.txt

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
