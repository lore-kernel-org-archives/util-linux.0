Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52170 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753626AbdBNQ3S (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 14 Feb 2017 11:29:18 -0500
Date: Tue, 14 Feb 2017 17:29:12 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: kerolasa@gmail.com, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 0/3] hwclock: remove date(1)
Message-ID: <20170214162912.2lntkyscwrar7a2v@ws.net.home>
References: <bbd64daa-5431-8c7d-580b-3382a33edccd@gmx.com>
 <CAG27Bk2kJ0P3i82vRK=cREtDhjO0VDBzXXpKpMBTvpnBCWefdA@mail.gmail.com>
 <20170213130408.psp6qoyaa6htl6aa@ws.net.home>
 <cf262dfa-c897-b7b7-c361-5e42676e87a7@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cf262dfa-c897-b7b7-c361-5e42676e87a7@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 13, 2017 at 09:42:23AM -0500, J William Piggott wrote:
> Would you consider a single file: sys-utils/hwclock-parse-datetime.c?
> I don't want to waste time rewriting it if the answer is no.

Would be possible to extend our parse_timestamp() from
lib/timeutils.c? Anyway, sys-utils/hwclock-date.c would be a better
name :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
