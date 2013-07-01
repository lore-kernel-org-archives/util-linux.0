Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44444 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752738Ab3GAJgz (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 1 Jul 2013 05:36:55 -0400
Date: Mon, 1 Jul 2013 11:36:45 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 08/15] dmesg: convert time format bitfield to enum
Message-ID: <20130701093645.GC28709@x2.net.home>
References: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
 <1371408836-16663-9-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1371408836-16663-9-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 16, 2013 at 07:53:49PM +0100, Sami Kerola wrote:
> +#define is_timefmt(c, f) (c->time_fmt == (DMESG_TIMEFTM_ ##f))

[...]

> +#undef is_timefmt
> +#define is_timefmt(c, f) (c.time_fmt == (DMESG_TIMEFTM_ ##f))

 Don't be lazy to use &ctl in code. You want to write readable and
 maintainable code ;-)

 Fixed.

    Karel

 Always code as if the person who ends up maintaining your code is a
 violent psychopath who knows where you live.
                         http://c2.com/cgi/wiki?CodeForTheMaintainer
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
