Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47892 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932911AbbBBKYi (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Feb 2015 05:24:38 -0500
Date: Mon, 2 Feb 2015 11:24:30 +0100
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Brandon Vincent <Brandon.Vincent@asu.edu>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: whereis search path
Message-ID: <20150202102430.GE16162@ws.net.home>
References: <CAJm42388wcQx0TgFEVxNXJCjKQPywO+65osLagn9_Wm=+5FB8g@mail.gmail.com>
 <CAG27Bk07WVef-+xq3QdA6UeQgKkKzv-Oz9R-kqQdT34m996uag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAG27Bk07WVef-+xq3QdA6UeQgKkKzv-Oz9R-kqQdT34m996uag@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jan 27, 2015 at 09:56:04AM +0000, Sami Kerola wrote:
> > Was the inclusion of /usr/share/info ever considered?
> 
> As far I can tell inclusion of the info directory has not been
> considered. I recon the /usr/share/info is closest to manuals category
> from the three options, and it feels like reasonable addition.
> 
> Any other opinions? And should this change be done before or after
> release v2.25?

 Fixed.

 old version:

    $ whereis parted
    parted: /usr/sbin/parted /usr/share/man/man8/parted.8.gz

 new version:
    $ whereis parted
    parted: /usr/sbin/parted /usr/share/man/man8/parted.8.gz /usr/share/info/parted.info.gz



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
