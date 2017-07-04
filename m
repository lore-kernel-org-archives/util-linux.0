Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:56658 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751960AbdGDIzY (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 4 Jul 2017 04:55:24 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Subject: Re: [PATCH 3/5] hwclock: final usage() strings slice
Date: Tue, 4 Jul 2017 10:55:05 +0200
Cc: Karel Zak <kzak@redhat.com>,
        J William Piggott <elseifthen@gmx.com>,
        util-linux@vger.kernel.org
References: <9cf88d57-3a45-cd47-ac96-3495e09d81c5@gmx.com> <20170704075833.eqhwwhpo36s2i63d@ws.net.home> <192a27a9-6e22-5483-0222-23cd992af8d2@bernhard-voelker.de>
In-Reply-To: <192a27a9-6e22-5483-0222-23cd992af8d2@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201707041055.05661.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 04 July 2017, Bernhard Voelker wrote:
> On 07/04/2017 09:58 AM, Karel Zak wrote:
> > I think the idea is to use the extra space only if you mix printf
> > and puts in the same code block. We have on many place only puts
> > (or fputs) -- in this case the extra space is unnecessary.
>
> What about putting the strings on an extra line regardless whether
> that is output via printf or fputf or ...; e.g.
>   http://git.savannah.gnu.org/cgit/coreutils.git/tree/src/du.c#n278
> ?

Yes this is nice because easy to count that no usage output is longer 
than 80 chars. But I guess there are too many different opinions about 
these stylish things. I'd also like to have just one string and only 
one printf command for all options (like mkfs.cramfs.c). But this may 
cause more work for translators each time we add a new option. Don't 
know if that would be a real problem.

cu,
Rudi
