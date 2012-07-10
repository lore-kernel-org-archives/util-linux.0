Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57571 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752893Ab2GJJf5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 10 Jul 2012 05:35:57 -0400
Date: Tue, 10 Jul 2012 11:35:54 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [pull] few utmpdump fixes
Message-ID: <20120710093554.GB5281@x2.net.home>
References: <CAG27Bk3f3moSFyOzLiTiRE-1vSVJn+PFh0-K_s65cD=h8MdJgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk3f3moSFyOzLiTiRE-1vSVJn+PFh0-K_s65cD=h8MdJgg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jul 08, 2012 at 11:38:47PM +0200, Sami Kerola wrote:
> Sami Kerola (5):
>       docs: clean up utmpdump.1 manual
>       utmpdump: white space fix
>       utmpdump: fixes based on static analysis [cppcheck]

Applied, but without field width limits for integers, IMHO it's unnecessary.

>       utmpdump: use inotify to when following file
>       utmpdump: encourage users not to follow stdin

I thought about inotify too :-) The --follow feature is almost useless
for utmp (where utmp records are reused), but for wtmp is inotify nice
and more smart solution than the original sleep() + read().

Applied with some changes, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
