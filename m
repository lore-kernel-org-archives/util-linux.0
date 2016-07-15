Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:61144 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327AbcGOSrY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 15 Jul 2016 14:47:24 -0400
Subject: Re: [PATCH] hwclock: remove UTC-0 localization hack
To: Karel Zak <kzak@redhat.com>, Sami Kerola <kerolasa@iki.fi>
References: <20160710200242.2706-1-kerolasa@iki.fi>
 <201607121623.04891.sweet_f_a@gmx.de>
 <CAG27Bk3po26Bsb=E0A1UXDrTrkwPH1pEvqEKXFZ_n4PVOcxt8A@mail.gmail.com>
 <201607122338.40458.sweet_f_a@gmx.de>
 <alpine.LNX.2.20.1607122241300.11890@imuri>
 <20160714100143.gc4ozcmah5i5stgz@ws.net.home>
Cc: Ruediger Meier <sweet_f_a@gmx.de>, kerolasa@gmail.com,
        util-linux <util-linux@vger.kernel.org>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <55e0d593-85e7-accc-84bd-c853a9d2951c@gmx.com>
Date: Fri, 15 Jul 2016 14:46:48 -0400
MIME-Version: 1.0
In-Reply-To: <20160714100143.gc4ozcmah5i5stgz@ws.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 07/14/2016 06:01 AM, Karel Zak wrote:
> On Tue, Jul 12, 2016 at 10:42:33PM +0100, Sami Kerola wrote:
>>  lib/portability.c      | 28 ++++++++++++++++++++++++++++
> 
> We already care about portability and we have many fallbacks, so why
> we need lib/portability.c now? It would better to use timeutils.c (or
> inline function in c.h).
> 
>     Karel
> 
>

What is this projects position on POSIX compatibility? A few comments in
the *-ReleaseNotes is all I found in /Documentation. Just curious, because
mktime() is and timegm() is not POSIX.

