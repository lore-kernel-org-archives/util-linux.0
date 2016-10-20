Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56668 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933639AbcJTJRs (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 20 Oct 2016 05:17:48 -0400
Date: Thu, 20 Oct 2016 11:17:45 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.29-rc2
Message-ID: <20161020091745.drjshipye5wwn2dv@ws.net.home>
References: <20161019132505.cumn37cmgazlumcu@ws.net.home>
 <201610200803.04150.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201610200803.04150.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Oct 20, 2016 at 08:03:03AM +0200, Ruediger Meier wrote:
> On Wednesday 19 October 2016, Karel Zak wrote:
> > The util-linux release v2.29-rc1 is available at
> >
> >   http://ftp.kernel.org/pub/linux/utils/util-linux/v2.29/
> >
> > Feedback and bug reports, as always, are welcomed.
> >
> >     Karel
> 
> Looks like ncurses(w) detection does not work anymore without pkgconfig 
> files, for example on openSUSE <=13.1, SLE 12 and openSUSE Leap.

Ah, I have thought that people already use pkg-config for ncurses on
all current distributions. For example we have .pc for ncurses on
old CentOS/RHEL 6 (year 2011).

I can add the fallback, but it makes configure messy. Do we really
need it? :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
