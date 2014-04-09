Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:55650 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933430AbaDIOEN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 9 Apr 2014 10:04:13 -0400
Received: from public by plane.gmane.org with local (Exim 4.69)
	(envelope-from <public@plane.gmane.org>)
	id 1WXt6q-0001CG-DH
	for util-linux@vger.kernel.org; Wed, 09 Apr 2014 16:04:12 +0200
Date: Wed, 9 Apr 2014 16:02:40 +0200
From: Markus Trippelsdorf <markus@trippelsdorf.de>
To: Karel Zak <public-kzak-H+wXaHxf7aLQT0dZR+AlfA@plane.gmane.org>
Cc: Ruediger Meier <public-sweet_f_a-Mmb7MZpHnFY@plane.gmane.org>,
        Thomas =?iso-8859-1?Q?B=E4chler?=
	<public-thomas-fd97jBR+K/6hPH1hqNUYSQ@plane.gmane.org>,
        public-util-linux-u79uwXL29TY76Z2rM5mHXA@plane.gmane.org
Subject: Re: [PATCH] fstrim: add systemd units
Message-ID: <20140409140240.GA26270@x4>
References: <1396561311-12825-1-git-send-email-thomas@archlinux.org>
 <201404081407.29362.sweet_f_a@gmx.de>
 <20140409075215.GP22126@x2.net.home>
 <201404091207.56691.sweet_f_a@gmx.de>
 <20140409110251.GT22126@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140409110251.GT22126@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>




On 2014.04.09 at 13:02 +0200, Karel Zak wrote:
> On Wed, Apr 09, 2014 at 12:07:56PM +0200, Ruediger Meier wrote:
> > Actually I think daily "fstrim -a" IS not a good idea for most of my 
> > systems
> 
> install service != enable (this is important detail, I'll never agree
> with automatically enabled services).
> 
> BTW, why IS not a good idea for your systems?

The fixed interval is problematic. There are SSD devices out there that
suffer (their flash cells die out faster) when they get trimmed too
often. A good rule of thumb is to trim once you have written the same
amount as you have free space on your device. Obviously, that interval
varies for every user (e.g. it's one week in my case).

-- 
Markus


