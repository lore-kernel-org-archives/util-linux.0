Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:60177 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753516AbdGUSmr (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 21 Jul 2017 14:42:47 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 40BFFABC3
        for <util-linux@vger.kernel.org>; Fri, 21 Jul 2017 18:42:46 +0000 (UTC)
Subject: Re: [PATCH] libmount: if ENOMEDIUM and tray is open, close tray and
 retry
From: Stanislav Brabec <sbrabec@suse.cz>
To: util-linux@vger.kernel.org
References: <0e40cb41-a64a-93b1-0c06-620cca40a575@suse.cz>
Message-ID: <f29ab5ef-753d-2ea8-e348-d53cdf4262cf@suse.cz>
Date: Fri, 21 Jul 2017 20:42:45 +0200
MIME-Version: 1.0
In-Reply-To: <0e40cb41-a64a-93b1-0c06-620cca40a575@suse.cz>
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Stanislav Brabec wrote:
> In past, d50c5917 introduced an interesting behavior: If mount was called on a
> CDROM with open tray, the tray was closed and mount was retried. But the
> implementation caused 15 seconds delay, so ca55a451 reverted it.
> 
> This is another attempt to implement that:
> If tray is closed: No change, no delay, no retry, simply fail.
> If tray is open: Close tray and retry after 3 seconds.

I was just pointed to an improvement: There are drives that are not
capable to close tray. In such case, fail.

I am sending new version of the patch.

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Køi¾íkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
