Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:56592 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754161AbaEMNgW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 13 May 2014 09:36:22 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: bugs on exotic archs
Date: Tue, 13 May 2014 15:36:15 +0200
Cc: util-linux@vger.kernel.org
References: <201405122045.18801.sweet_f_a@gmx.de> <20140513082349.GL8951@x2.net.home>
In-Reply-To: <20140513082349.GL8951@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201405131536.15870.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 13 May 2014, Karel Zak wrote:
> On Mon, May 12, 2014 at 08:45:18PM +0200, Ruediger Meier wrote:

> > %ifarch ppc ppc64
> >   hexdump
>
>  this is not a bug, but the hexdump test disadvantage -- the output
>  may be different on big-endian if the output is composed from more
> input bytes.

I've fixed the hexdump test partially
https://github.com/karelzak/util-linux/pull/76

cu,
Rudi
