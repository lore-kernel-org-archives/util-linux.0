Return-Path: util-linux-owner@vger.kernel.org
Received: from a-painless.mh.aa.net.uk ([81.187.30.51]:54209 "EHLO
        a-painless.mh.aa.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754388AbdLTRDi (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 20 Dec 2017 12:03:38 -0500
Received: from cartman.offog.org ([2001:8b0:83b:b53f::a])
        by a-painless.mh.aa.net.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ats@offog.org>)
        id 1eRhFZ-0004tB-QF
        for util-linux@vger.kernel.org; Wed, 20 Dec 2017 16:29:45 +0000
Received: from ats by cartman.offog.org with local (Exim 4.89_1)
        (envelope-from <ats@offog.org>)
        id 1eRhFX-0005Uv-Uc
        for util-linux@vger.kernel.org; Wed, 20 Dec 2017 16:29:43 +0000
From: Adam Sampson <ats@offog.org>
To: util-linux@vger.kernel.org
Subject: Re: v2.32 cal(1)
References: <20171219132906.74xm7nm4r3trr4qq@ws.net.home>
Date: Wed, 20 Dec 2017 16:29:43 +0000
In-Reply-To: <20171219132906.74xm7nm4r3trr4qq@ws.net.home> (Karel Zak's
        message of "Tue, 19 Dec 2017 14:29:06 +0100")
Message-ID: <y2amv2ds6q0.fsf@offog.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak <kzak@redhat.com> writes:

> The problem is that year 1752 is very specific to British Empire and
> for example Catholic Europe moved to the Gregorian calendar in year
> 1582.
...
> * later (after warning in release notes) we can make --gregorian as
>   the default

The date of cal's switch is specified in POSIX as 1752, though:
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/cal.html
(with a note that future versions may make this depend on the locale).

So if the default is changed, it would be worth noting the deviation
from POSIX in the man page, and maybe even defaulting to the old
behaviour if POSIXLY_CORRECT is defined, as, e.g., coreutils does for
other bits of dubious but mandated behaviour.

I wonder if it might be more helpful just to report an error if cal is
run for a year prior to 1926 without explicitly specifying which
calendar to use?

Thanks,

-- 
Adam Sampson <ats@offog.org>                         <http://offog.org/>
