Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41351 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756894AbaDHR0p (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 8 Apr 2014 13:26:45 -0400
Date: Tue, 8 Apr 2014 19:26:36 +0200
From: Karel Zak <kzak@redhat.com>
To: Thomas =?iso-8859-1?Q?B=E4chler?= <thomas@archlinux.org>
Cc: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org
Subject: Re: [PATCH] fstrim: add systemd units
Message-ID: <20140408172636.GN22126@x2.net.home>
References: <1396561311-12825-1-git-send-email-thomas@archlinux.org>
 <20140407104304.GJ22126@x2.net.home>
 <201404081225.21563.sweet_f_a@gmx.de>
 <5343D600.7000507@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <5343D600.7000507@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 08, 2014 at 12:57:04PM +0200, Thomas Bächler wrote:
> > BTW fstrim.timer is missing in "make dist" tar ball.
> 
> Sorry, you are right. I'm a bit lost in this build system, Karel
> probably knows how to fix this.

 Fixed.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
