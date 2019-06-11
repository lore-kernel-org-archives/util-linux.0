Return-Path: <SRS0=jsgS=UK=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68583C43218
	for <util-linux@archiver.kernel.org>; Tue, 11 Jun 2019 13:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4150C2089E
	for <util-linux@archiver.kernel.org>; Tue, 11 Jun 2019 13:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387764AbfFKNX2 convert rfc822-to-8bit (ORCPT
        <rfc822;util-linux@archiver.kernel.org>);
        Tue, 11 Jun 2019 09:23:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:60886 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387578AbfFKNX2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 11 Jun 2019 09:23:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A4D6DAE36;
        Tue, 11 Jun 2019 13:23:27 +0000 (UTC)
Subject: Re: [PATCH 3/3] fstrim -a/-A: Skip read-only volumes
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
References: <a46df663-bdfd-6f53-45e9-c4547e4ee108@suse.cz>
 <20190611081513.gvwpgg74qup2yg6w@ws.net.home>
From:   Stanislav Brabec <sbrabec@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=sbrabec@suse.cz; prefer-encrypt=mutual; keydata=
 mQGiBD6v2X0RBAD3rKn9S5s4iKX9KwKPIE1GCEG0qE1UomcIxYhey5oKEVoQoHtJkKvZpOVH
 zXNoPIMdwegZI++89UqY1jz6gI1pyBYRs4qmdnltXToO7NXdCr+LC5XNCStewoCE46gJIsb+
 8DpgK+wPoK/k1bF4HbnImTmkWaRLZKjaFsU4dR3+zwCgxqZXdZMiAYA+1mIjiGRZubOctQUE
 AIZ51+tT+FPkpR8ld+qjHNh1F42y0nCj4dL1oHjWpcq2tzuK+BHzpePsM4rM9ZeYqDSsZIFC
 5ol61NYmKaKDMRjwY5KK+tABm/ha+OCl4twcxtHCoLOcK1N/8/kqZ75x3/NLJwL/BRwaoE0Y
 NsD+BxCW0Rjbiztg2KwkdDWFcCVmBADc/Ka7mKdimHzY6XJ3gIHgFS9fa2rcxKaleajH+dXh
 SPRW8Qil2n/FaAdUIBWL/woF78BAgDfaOGt7Ize+pRVia0e6KD9aUBjRz3ZXmvG17xv83UmW
 ZRP0fpVqA28ou+NvjRNKJtd144OUeMLyEhy82YlkGPwn7r6WhaWo6UIpSLQsU3RhbmlzbGF2
 IEJyYWJlYyAoU3VTRSBDUikgPHNicmFiZWNAc3VzZS5jej6IXwQTEQIAHwQLBwMCAxUCAwMW
 AgECHgECF4AFAlHS/kkFCSE/csAACgkQcXwgn6BPzXZY/gCghbxE4uexFHVP7qho9TDNxGGR
 xxgAoKCipPrJQrnXKhFG4RDeRcVE0PoBuQENBD6v2YIQBACt62O2lXle2CPxw2LpdT557Rvr
 UdoYJ1AeLAn1iDy67rDsGumxJxW254x9CKVsU3609PG58gDKSQ7CvHzErtOdz9xsJLfCCxbk
 6LsOhBdCWgYs7HV2xYCkUvKSVQGZN95skfv1aSsO6dXzXISXen4KqY5AnFa+pXDAqMJTGLwp
 GwADBgQAkZ2/zz99L224sNcFgM+6TuGIQ57fNhKJxYG2HbBqh3oBiiZI9224dKLNCv/2aoV8
 qd9QUMKQCO7kQKkSH7+Ti1KnCyaDi3SoeFcsV4Z99Xb1bN2EBS1C4qohNUbouTsYEG5qsZPe
 uRDKekFTiilRRVyiXWDt+zY2aNNMknKBACeIRgQYEQIABgUCPq/ZggAKCRBxfCCfoE/Ndi+t
 AKCrirgQ963gLN3DlBRlvFPIOZ01WACglN5nhY7wyyhIjQP3k4eVfBY+WV4=
Organization: SUSE Linux, s. r. o.
Message-ID: <af664c12-6f98-104d-75b1-45d24553c499@suse.cz>
Date:   Tue, 11 Jun 2019 15:23:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190611081513.gvwpgg74qup2yg6w@ws.net.home>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Dne 11. 06. 19 v 10:15 Karel Zak napsal(a):
> On Mon, Jun 10, 2019 at 09:59:45PM +0200, Stanislav Brabec wrote:
>> Calling TRIM on some read-only volumes can fail with:
>> fstrim: /win: FITRIM ioctl failed: Bad file descriptor
> Did you try it with the current version from git? ... because we
> interpret EBADF as "the discard operation is not supported" warning
> rather than an error.

No. The bug was reported by one of users on a read-only /windows, and I
was not able to reproduce it. The patch was done as my best guess.

https://bugzilla.opensuse.org/show_bug.cgi?id=1106214

Reported for openSUSE Leap 15.0, i. e. util-linux-2.31.1.

I tried the same, but I found a possible bug in the ntfs:

mount -r /dev/nvme0n1p3 /windows
fuse: mount failed: Device or resource busy


-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Køi¾íkova 148/34 (Corso IIa)                    tel: +420 284 084 060
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76


