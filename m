Return-Path: <SRS0=WlCG=Q2=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EEAC43381
	for <util-linux@archiver.kernel.org>; Tue, 19 Feb 2019 15:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBEC721738
	for <util-linux@archiver.kernel.org>; Tue, 19 Feb 2019 15:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbfBSPu3 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:50:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:50712 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbfBSPu3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 19 Feb 2019 10:50:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 27689B052;
        Tue, 19 Feb 2019 15:50:27 +0000 (UTC)
Subject: Re: [PATCH] mount: Do not call mnt_pretty_path() on net file systems.
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
References: <8a0a088e-2ed7-9233-438a-6fb04f08046f@suse.cz>
 <eddb321e-eb27-f08a-2b8b-4856eedfdc03@suse.cz>
 <20190206105847.gumbcel24gvc5zmn@ws.net.home>
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
 AJ958OvQedgG0gsRG1wX/HKXmRZ0dwCfUk0F4qeP5dCiETIHh3gxNIsx8YQ=
Organization: SUSE Linux, s. r. o.
Message-ID: <05bb1dd3-016d-9166-3e73-29bbc307907c@suse.cz>
Date:   Tue, 19 Feb 2019 16:50:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190206105847.gumbcel24gvc5zmn@ws.net.home>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Dne 06. 02. 19 v 11:58 Karel Zak napsal(a):
> On Wed, Feb 06, 2019 at 12:07:54AM +0100, Stanislav Brabec wrote:
>>  sys-utils/mount.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Applied, thanks!
> 
> Please, send also updates for the mnt_fstype_is_pseudofs().
> 

I started to inspect file systems available in SUSE, and I found that there is an another category of file systems: File systems that have a source (so they are not pseudo file systems), but information provided by the kernel is not sufficient to check whether a particular source is already mounted.

Some of them are completely undetectable (both source and FS type provide generic information only), some are detectable by source, but not by FS type, some are detectable by FS type, but source match cannot be used.

For these file systems, mount(8) cannot guarantee that the correct volume is mounted. Only some guesses are possible.

Maybe it should warn about it, or it should refuse such file systems in the fstab.


Examples of undetectable FUSE file systems:

xdg-document-portal is completely undetectable; it can be ran once per UID
/dev/fuse on /run/user/10027/doc type fuse (rw,nosuid,nodev,relatime,user_id=10027,group_id=100)
376 536 0:65 / /run/user/10027/doc rw,nosuid,nodev,relatime - fuse /dev/fuse rw,user_id=10027,group_id=100

curlftpfs undetectable by type, detectable by source
curlftpfs#ftp://ftp.suse.com/ on /home/sbrabec/T type fuse (rw,nosuid,nodev,relatime,user_id=10027,group_id=100)
544 510 0:47 / /sys/fs/fuse/connections rw,relatime master:282 - fusectl fusectl rw

encfs:
can be detected by type, source cannot be detected
encfs on /local/Encrypted type fuse.encfs (rw,nosuid,nodev,relatime,user_id=10027,group_id=100,default_permissions)
397 540 0:84 / /local/Encrypted rw,nosuid,nodev,relatime - fuse.encfs encfs rw,user_id=10027,group_id=100,default_permissions

gvfs:
can be detected by type, source cannot be detected
gvfsd-fuse on /run/user/10027/gvfs type fuse.gvfsd-fuse (rw,nosuid,nodev,relatime,user_id=10027,group_id=100)
562 536 0:48 / /run/user/10027/gvfs rw,nosuid,nodev,relatime master:291 - fuse.gvfsd-fuse gvfsd-fuse rw,user_id=10027,group_id=100

archivemount:
can be detected by type, source cannot be detected
archivemount on /home/sbrabec/T type fuse.archivemount (rw,nosuid,nodev,relatime,user_id=10027,group_id=100)
376 539 0:65 / /home/sbrabec/T rw,nosuid,nodev,relatime - fuse.archivemount archivemount rw,user_id=10027,group_id=100


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
