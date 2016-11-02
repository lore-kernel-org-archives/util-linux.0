Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60888 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757640AbcKBXIb (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 2 Nov 2016 19:08:31 -0400
Date: Thu, 3 Nov 2016 00:08:28 +0100
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org
Subject: Re: [PATCH] tests: wait for flock background process
Message-ID: <20161102230828.n2rlorlyf4rwjiqc@ws.net.home>
References: <1478097115-3203-1-git-send-email-sweet_f_a@gmx.de>
 <20161102155151.ode6abioi7kcvksq@ws.net.home>
 <13b5d77f-87e6-3303-bb5d-e311cb303cfd@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <13b5d77f-87e6-3303-bb5d-e311cb303cfd@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 02, 2016 at 11:11:42PM +0100, Bernhard Voelker wrote:
> On 11/02/2016 04:51 PM, Karel Zak wrote:
> >> +timeout 1s bash -c "while [ \$(ps --ppid $pid |wc -l) -lt 2 ]; do sleep 0.1 ;done" \
> >
> > is "0.1" portable? :-)
> 
> if one has timeout from coreutils, then it's likely that she also has sleep
> from there.  Thus said, I'd rather worry about portability of using timeout
> rather than the "0.1" (if sleep fails, then nobody will care anyway). ;-)

Good point... I have added check for "timeout".

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
