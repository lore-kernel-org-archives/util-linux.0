Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43624 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544AbaAPJ7a (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 16 Jan 2014 04:59:30 -0500
Date: Thu, 16 Jan 2014 10:59:27 +0100
From: Karel Zak <kzak@redhat.com>
To: Felix Miata <mrmazda@earthlink.net>
Cc: util-linux@vger.kernel.org
Subject: Re: global fdisk colors disable
Message-ID: <20140116095927.GO12700@x2.net.home>
References: <52D62F0C.9060308@earthlink.net>
 <20140115082708.GH12700@x2.net.home>
 <52D696CB.5060606@earthlink.net>
 <201401151021.22057.vapier@gentoo.org>
 <52D7A542.70805@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52D7A542.70805@earthlink.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jan 16, 2014 at 04:24:18AM -0500, Felix Miata wrote:
> On 2014-01-15 10:21 (GMT-0500) Mike Frysinger composed:
> 
> >On Wednesday 15 January 2014 09:10:19 Felix Miata wrote:
> 
> >>I have many logins on many installations. In what global config file (e.g.
> >>Debian, Fedora, Gentoo, Knoppix, Mageia, openSUSE, Slackware, etc.) can I
> >>make never the default for all users?
> 
> >/etc/profile
> 
> That always seems to have a rather recent date, even though I never touch
> it. Are you sure you don't mean /etc/profile.local?

For example Fedora uses /etc/profile where is:

for i in /etc/profile.d/*.sh ; do
    if [ -r "$i" ]; then
        if [ "${-#*i}" != "$-" ]; then 
            . "$i"
        else
            . "$i" >/dev/null
        fi
    fi
done


and in the /etc/profile.d/ directory are many scripts, for example
/etc/profile.d/colorls.sh with --color=auto alias for ls(1).

It's pretty common that people and packages add/modify the stuff in 
the /etc/profile.d/ directory.

IMHO it's elegant way how to maintain global configuration for shells.

The files like ~/.bash_profile are users' playground and I don't think
that good admin touches these ~/ files.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
