Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.135]:55579 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751986AbdGDIei (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 4 Jul 2017 04:34:38 -0400
Subject: Re: [PATCH 3/5] hwclock: final usage() strings slice
To: Karel Zak <kzak@redhat.com>, J William Piggott <elseifthen@gmx.com>
Cc: Ruediger Meier <ruediger.meier@ga-group.nl>,
        util-linux@vger.kernel.org
References: <9cf88d57-3a45-cd47-ac96-3495e09d81c5@gmx.com>
 <40df38f4-6bf5-1959-74af-6ee481b88a12@gmx.com>
 <201707031051.27992.ruediger.meier@ga-group.nl>
 <05bbcea5-5f5a-4767-7d98-6b0a4e6575a6@gmx.com>
 <20170704075833.eqhwwhpo36s2i63d@ws.net.home>
From: Bernhard Voelker <mail@bernhard-voelker.de>
Message-ID: <192a27a9-6e22-5483-0222-23cd992af8d2@bernhard-voelker.de>
Date: Tue, 4 Jul 2017 10:34:02 +0200
MIME-Version: 1.0
In-Reply-To: <20170704075833.eqhwwhpo36s2i63d@ws.net.home>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 07/04/2017 09:58 AM, Karel Zak wrote:
> I think the idea is to use the extra space only if you mix printf and
> puts in the same code block. We have on many place only puts (or
> fputs) -- in this case the extra space is unnecessary.

What about putting the strings on an extra line regardless whether
that is output via printf or fputf or ...; e.g.
  http://git.savannah.gnu.org/cgit/coreutils.git/tree/src/du.c#n278
?

Have a nice day,
Berny
