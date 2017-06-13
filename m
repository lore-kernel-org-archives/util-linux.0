Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752480AbdFMMvV (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 13 Jun 2017 08:51:21 -0400
Date: Tue, 13 Jun 2017 14:51:15 +0200
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?R=FCdiger?= Meier <sweet_f_a@gmx.de>
Cc: kerolasa@gmail.com, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 01/11] misc: fallthrough fixes
Message-ID: <20170613125115.yq7a63ngzpk2hiod@ws.net.home>
References: <20170608195215.1702-1-kerolasa@iki.fi>
 <20170608195215.1702-2-kerolasa@iki.fi>
 <201706091314.08008.sweet_f_a@gmx.de>
 <968790d0-c49c-538b-d034-ffcda9c20efc@gmx.de>
 <CAG27Bk3OEBrnGbrD+2tuxu-UGUjQXLB+TrsFLiQRvOtcns8FsQ@mail.gmail.com>
 <55d88bf2-3c67-4d79-984e-b16d6b835702@gmx.de>
 <CAG27Bk03PW7GWHdm5G0Xcu1LXbAXwebQyyvk3HoHx7hP8e-Bgg@mail.gmail.com>
 <4ae98acb-325d-39dd-faa9-2cdf8ce62c3e@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <4ae98acb-325d-39dd-faa9-2cdf8ce62c3e@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 13, 2017 at 01:16:57AM +0200, Rüdiger Meier wrote:
> > > BTW just for cosmetics. Maybe we should rename UL_FALLTHROUGH to
> > > __ul_fallthrough
> > > like we have already __ul_calloc_size. IMO it would look more obvious to the
> > > reader.
> > 
> > I don't have strong opinion about that, changed to one you proposed.
> 
> Thanks, let's see whether Karel likes this attribute at all ;)

Hmm...

 I don't like "meta-programming" where language keywords are
 replaced by local macros, for example we have fallback (in c.h) for all
 __attribute__ rather than define local macro for all attributes. 

   __attribute__((fallthrough))

 should be fine on non-__GNUC__ as in this case __attribute__ is empty
 macro (see c.h).

 Yes, __ul_fallthrough seems better, and __attribute__((fallthrough))
 would be the best :-)

 It's strange if clang will use a different syntax for the same
 things. IMHO it would be better to ignore clang for this attribute.

 And I'm not sure if the change is compatible with coverity-scan where 
 comment line /* fallthrough */ is required, but this not so important
 (coverity is maintained, so attribute will be supported one day...).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
