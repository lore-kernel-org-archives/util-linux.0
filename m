Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39553 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757645AbaDILDA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 9 Apr 2014 07:03:00 -0400
Date: Wed, 9 Apr 2014 13:02:51 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Thomas =?iso-8859-1?Q?B=E4chler?= <thomas@archlinux.org>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH] fstrim: add systemd units
Message-ID: <20140409110251.GT22126@x2.net.home>
References: <1396561311-12825-1-git-send-email-thomas@archlinux.org>
 <201404081407.29362.sweet_f_a@gmx.de>
 <20140409075215.GP22126@x2.net.home>
 <201404091207.56691.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201404091207.56691.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 09, 2014 at 12:07:56PM +0200, Ruediger Meier wrote:
> Actually I think daily "fstrim -a" IS not a good idea for most of my 
> systems

install service != enable (this is important detail, I'll never agree
with automatically enabled services).

BTW, why IS not a good idea for your systems?

> but I feel no need to discuss this here on util-linux because 
> the decision whether, how, when and on which devices fstrim should be 
> called should not be made here at all.

well, "fstrim -a" contains heruistic to select the right filestems (it
really does not call trim for all devices), it has been implemented to
*avoid* sysadmins creativity. If you don't like it, you can use
"fstrim <device>" (for example from crontab).

> If we add scripts with one generic use case for fstrim. Why don't we add 
> the generic boot and maintenance scripts how and when to mount or fsck 
> all filesystems, to activate swap, to get and set hwclock or whatever?

I really don't want to follow this insane direction of the discussion.

> Moreover the portability issue. Why adding scripts for systemd only 
> allthough the same could be done without systemd in a more portable 
> way.

is there any other unified, distribution independent and distribution
supported way to install, but no enable the stuff?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
