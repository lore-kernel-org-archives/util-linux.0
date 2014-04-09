Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:64255 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932847AbaDIPsK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 9 Apr 2014 11:48:10 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: [PATCH] fstrim: add systemd units
Date: Wed, 9 Apr 2014 17:48:07 +0200
Cc: util-linux@vger.kernel.org
References: <1396561311-12825-1-git-send-email-thomas@archlinux.org> <20140409110251.GT22126@x2.net.home> <20140409140240.GA26270@x4>
In-Reply-To: <20140409140240.GA26270@x4>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201404091748.07452.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 09 April 2014, Markus Trippelsdorf wrote:
> On 2014.04.09 at 13:02 +0200, Karel Zak wrote:
> > On Wed, Apr 09, 2014 at 12:07:56PM +0200, Ruediger Meier wrote:
> > > Actually I think daily "fstrim -a" IS not a good idea for most of
> > > my systems
> >
> > install service != enable (this is important detail, I'll never
> > agree with automatically enabled services).
> >
> > BTW, why IS not a good idea for your systems?
>
> The fixed interval is problematic. There are SSD devices out there
> that suffer (their flash cells die out faster) when they get trimmed
> too often. A good rule of thumb is to trim once you have written the
> same amount as you have free space on your device. Obviously, that
> interval varies for every user (e.g. it's one week in my case).

Is "mount -o discard" instead of fstrim interval more or less bad 
regarding lifetime?
And BTW does fstrim makes sense on non SSDs at all?

cu,
Rudi
