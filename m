Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49344 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752717AbaAIIy1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 9 Jan 2014 03:54:27 -0500
Date: Thu, 9 Jan 2014 09:54:13 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: Mike Frysinger <vapier@gentoo.org>, util-linux@vger.kernel.org,
        Thomas =?iso-8859-1?Q?B=E4chler?= <thomas@archlinux.org>
Subject: Re: [PATCH] uuidd: use pkg-config to find systemd-deamon support
Message-ID: <20140109085413.GC7516@x2.net.home>
References: <1389051548-1268-1-git-send-email-kerolasa@iki.fi>
 <20140108092116.GA7516@x2.net.home>
 <CAG27Bk2S5ert+sjnai8ybEhhoUruYmX6P+U7c1AaghfjQ_s2TA@mail.gmail.com>
 <201401081544.37516.vapier@gentoo.org>
 <1389220086-7475-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389220086-7475-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 08, 2014 at 10:28:06PM +0000, Sami Kerola wrote:
> So the change that's needed could be something like

It would be really better to have --disable-all-builds, then we can
support things like:

    --disable-all-builds --enable-unshare

how many utils are not covered by any enable_<name>= ? I think all we
need is to just add AC_ARG_ENABLE() to all utils. 

(Well, for stuff like schedutils we have AC_ARG_ENABLE([schedutils])
 and it's enough, it's unnecessary to have AC_ARG_ENABLE for taskset,
 ionice, ..) 

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
