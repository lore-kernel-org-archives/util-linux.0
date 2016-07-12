Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:60473 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754130AbcGLOXK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 12 Jul 2016 10:23:10 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: kerolasa@gmail.com
Subject: Re: [PATCH] hwclock: remove UTC-0 localization hack
Date: Tue, 12 Jul 2016 16:23:04 +0200
Cc: J William Piggott <elseifthen@gmx.com>,
        "util-linux" <util-linux@vger.kernel.org>
References: <20160710200242.2706-1-kerolasa@iki.fi> <3421b4a5-023c-304b-3768-fa6f219d6300@gmx.com> <CAG27Bk2oLozR-Va_vcnNS9faDZKi5Q1tC+y2F6Ws9Ye7fGu_tw@mail.gmail.com>
In-Reply-To: <CAG27Bk2oLozR-Va_vcnNS9faDZKi5Q1tC+y2F6Ws9Ye7fGu_tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201607121623.04891.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 12 July 2016, Sami Kerola wrote:
> On 11 July 2016 at 21:23, J William Piggott <elseifthen@gmx.com> 
wrote:
> > We use mktime(3) for portability.
> >
> > http://www.gnu.org/software/libc/manual/html_mono/libc.html#index-t
> >imegm
> >
> > Portability note: mktime is essentially universally available.
> > timegm is rather rare. For the most portable conversion from a UTC
> > broken-down time to a simple time, set the TZ environment variable
> > to UTC, call mktime, then set TZ back.
>
> I don't think hwclock(8) is portable. It has ioctl(2) calls, and
> such.

But there are non-gnu libc's for Linux.

cu,
Rudi
