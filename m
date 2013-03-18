Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vc0-f180.google.com ([209.85.220.180]:55173 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518Ab3CRUJz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 18 Mar 2013 16:09:55 -0400
Received: by mail-vc0-f180.google.com with SMTP id m17so3263841vca.39
        for <util-linux@vger.kernel.org>; Mon, 18 Mar 2013 13:09:55 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20130318154225.GF2172@x2.net.home>
References: <20130318154225.GF2172@x2.net.home>
Date: Mon, 18 Mar 2013 20:09:54 +0000
Message-ID: <CAG27Bk1=0EVWCsqiOQUEzz8pR_sQZqSTSKMRFX8gWHtG+KUxcg@mail.gmail.com>
Subject: Re: newgrp(1) and sg(1)
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 18, 2013 at 3:42 PM, Karel Zak <kzak@redhat.com> wrote:
> Do we really need passwords for groups [newgrp(1) and /etc/gshadow]?
> Seems like a nice over-engineering.
>
> By the way, I have fixed newgrp(1) in util-linux and shadow-utils 5
> years ago. The password verification was pretty useless for years...
>
> IMHO it would be better to mark whole /etc/gshadow as deprecated and
> reuse "su --group <group> [--supp-group <group> ...]" code to switch
> between groups, then we don't have to maintain separate newgrp code.
>
> Note that newgrp(1) is available in shadow-utils and util-linux, sg(1)
> is alias in shadow-utils. We have been successful with login(1), now
> I'd like to consolidate newgrp(1) :-)
>
> Comments?

Usefulness of gshadow was discussed earlier[1]. I have not heard
anyone using gshadow. Neither Open Group or Linux Standard Base
recognize gshadow file, so keeping it a live seems to be voluntary.
There is also quite long history with confusion how the gshadow should
work[2]. So maybe it is time to get rid of this legacy experiment.

Maybe it is worthwhile to mention that Open Group defines newgrp[3]
command, so one of the projects should probably deliver it. The
shadow-utils version seems to be more complete (it has built in syslog
for example), so perhaps it should be the chosen one.

Having 'su --group', or similar, as newgrp alternative sounds fair.

[1] https://groups.google.com/d/msg/fa.linux.kernel/Zg987XcLy2U/wlV3Z9h66d0J
[2] https://groups.google.com/forum/#!search/gshadow/comp.os.linux.admin/QptNuTMTMio/lDoeuy7KwOkJ
[3] http://pubs.opengroup.org/onlinepubs/000095399/utilities/newgrp.html

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
