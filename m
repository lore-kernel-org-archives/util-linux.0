Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51120 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753311AbdFMUAG (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 13 Jun 2017 16:00:06 -0400
Date: Tue, 13 Jun 2017 22:00:00 +0200
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?R=FCdiger?= Meier <sweet_f_a@gmx.de>
Cc: kerolasa@gmail.com, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 01/11] misc: fallthrough fixes
Message-ID: <20170613200000.ravhgjs7kvqnhihq@ws.net.home>
References: <201706091314.08008.sweet_f_a@gmx.de>
 <968790d0-c49c-538b-d034-ffcda9c20efc@gmx.de>
 <CAG27Bk3OEBrnGbrD+2tuxu-UGUjQXLB+TrsFLiQRvOtcns8FsQ@mail.gmail.com>
 <55d88bf2-3c67-4d79-984e-b16d6b835702@gmx.de>
 <CAG27Bk03PW7GWHdm5G0Xcu1LXbAXwebQyyvk3HoHx7hP8e-Bgg@mail.gmail.com>
 <4ae98acb-325d-39dd-faa9-2cdf8ce62c3e@gmx.de>
 <20170613125115.yq7a63ngzpk2hiod@ws.net.home>
 <b8cf693f-a1d9-ba25-642a-056ed6fc717b@gmx.de>
 <20170613134115.2bko6uejkrna65j6@ws.net.home>
 <35f6001e-ab3e-e96d-c872-67869ec8c3d6@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <35f6001e-ab3e-e96d-c872-67869ec8c3d6@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 13, 2017 at 04:52:20PM +0200, Rüdiger Meier wrote:
> > sounds all we need is to add  -Wimplicit-fallthrough=3 to ./configur
> No, -Wimplicit-fallthrough=3 is what we have already now by default.
> Just tested. Without doing anything "/* fallthrough */" disables the
> warning. But Sami fixed also other comments and places without comments.
> 
> So we could simply use "/* fallthrough */" everythere.

Yes, that's what I mean (don't use the macro at all).

Sami, can you update the patch and replace __ul_fallthrough with 
/* fallthrough */ ?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
