Return-Path: util-linux-owner@vger.kernel.org
Received: from ud10.udmedia.de ([194.117.254.50]:55911 "EHLO
	mail.ud10.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932908AbaDIPz7 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Apr 2014 11:55:59 -0400
Date: Wed, 9 Apr 2014 17:55:57 +0200
From: Markus Trippelsdorf <markus@trippelsdorf.de>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] fstrim: add systemd units
Message-ID: <20140409155557.GF26270@x4>
References: <1396561311-12825-1-git-send-email-thomas@archlinux.org>
 <20140409110251.GT22126@x2.net.home>
 <20140409140240.GA26270@x4>
 <201404091748.07452.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201404091748.07452.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 2014.04.09 at 17:48 +0200, Ruediger Meier wrote:
> On Wednesday 09 April 2014, Markus Trippelsdorf wrote:
> > On 2014.04.09 at 13:02 +0200, Karel Zak wrote:
> > > On Wed, Apr 09, 2014 at 12:07:56PM +0200, Ruediger Meier wrote:
> > > > Actually I think daily "fstrim -a" IS not a good idea for most of
> > > > my systems
> > >
> > > install service != enable (this is important detail, I'll never
> > > agree with automatically enabled services).
> > >
> > > BTW, why IS not a good idea for your systems?
> >
> > The fixed interval is problematic. There are SSD devices out there
> > that suffer (their flash cells die out faster) when they get trimmed
> > too often. A good rule of thumb is to trim once you have written the
> > same amount as you have free space on your device. Obviously, that
> > interval varies for every user (e.g. it's one week in my case).
> 
> Is "mount -o discard" instead of fstrim interval more or less bad 
> regarding lifetime?

It really depends on the specific SSD model. But a cron job with fstrim
should do a better job in general.

> And BTW does fstrim makes sense on non SSDs at all?

No. (There are huge storage solutions with thin provisioning, that offer
trim support.)

-- 
Markus
