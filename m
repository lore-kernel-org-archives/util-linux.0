Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39530 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032AbcGNKBq (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Jul 2016 06:01:46 -0400
Date: Thu, 14 Jul 2016 12:01:43 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: Ruediger Meier <sweet_f_a@gmx.de>, kerolasa@gmail.com,
        J William Piggott <elseifthen@gmx.com>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] hwclock: remove UTC-0 localization hack
Message-ID: <20160714100143.gc4ozcmah5i5stgz@ws.net.home>
References: <20160710200242.2706-1-kerolasa@iki.fi>
 <201607121623.04891.sweet_f_a@gmx.de>
 <CAG27Bk3po26Bsb=E0A1UXDrTrkwPH1pEvqEKXFZ_n4PVOcxt8A@mail.gmail.com>
 <201607122338.40458.sweet_f_a@gmx.de>
 <alpine.LNX.2.20.1607122241300.11890@imuri>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.20.1607122241300.11890@imuri>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 12, 2016 at 10:42:33PM +0100, Sami Kerola wrote:
>  lib/portability.c      | 28 ++++++++++++++++++++++++++++

We already care about portability and we have many fallbacks, so why
we need lib/portability.c now? It would better to use timeutils.c (or
inline function in c.h).

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
