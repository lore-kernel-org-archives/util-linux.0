Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.134]:49347 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932875AbcKBWLt (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 2 Nov 2016 18:11:49 -0400
Subject: Re: [PATCH] tests: wait for flock background process
To: Karel Zak <kzak@redhat.com>, Ruediger Meier <sweet_f_a@gmx.de>
References: <1478097115-3203-1-git-send-email-sweet_f_a@gmx.de>
 <20161102155151.ode6abioi7kcvksq@ws.net.home>
Cc: util-linux@vger.kernel.org
From: Bernhard Voelker <mail@bernhard-voelker.de>
Message-ID: <13b5d77f-87e6-3303-bb5d-e311cb303cfd@bernhard-voelker.de>
Date: Wed, 2 Nov 2016 23:11:42 +0100
MIME-Version: 1.0
In-Reply-To: <20161102155151.ode6abioi7kcvksq@ws.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 11/02/2016 04:51 PM, Karel Zak wrote:
>> +timeout 1s bash -c "while [ \$(ps --ppid $pid |wc -l) -lt 2 ]; do sleep 0.1 ;done" \
>
> is "0.1" portable? :-)

if one has timeout from coreutils, then it's likely that she also has sleep
from there.  Thus said, I'd rather worry about portability of using timeout
rather than the "0.1" (if sleep fails, then nobody will care anyway). ;-)

Have a nice day,
Berny
