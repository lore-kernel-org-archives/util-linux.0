Return-Path: <SRS0=Bpzm=QL=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E7EC282C4
	for <util-linux@archiver.kernel.org>; Mon,  4 Feb 2019 16:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D3220823
	for <util-linux@archiver.kernel.org>; Mon,  4 Feb 2019 16:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbfBDQi7 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:38:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:44998 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728834AbfBDQi7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 4 Feb 2019 11:38:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6BC95AC98;
        Mon,  4 Feb 2019 16:38:57 +0000 (UTC)
Subject: Re: [RFC] refactor mnt_fstype_is_pseudofs()?
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
References: <dff8fba8-3a22-dd4a-1b75-6e636d15b2c9@suse.cz>
 <20190204140301.6oqezi7p26y2rewe@ws.net.home>
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
Message-ID: <fefe499e-cef4-58f0-3620-59a7f5ee7324@suse.cz>
Date:   Mon, 4 Feb 2019 17:38:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190204140301.6oqezi7p26y2rewe@ws.net.home>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Karel Zak wrote:
> On Fri, Feb 01, 2019 at 12:07:12AM +0100, Stanislav Brabec wrote:
>> Hi.
>>
>> I got a but report about a dumpfs FUSE filesystem reporting bad mount output.
>>
>> The same problem affects other pseudo file systems not listed in mnt_fstype_is_pseudofs():
>> # mount | grep encfs
>> encfs on /Encrypted type fuse.encfs (rw,nosuid,nodev,relatime,user_id=10027,group_id=100,default_permissions)
>> # mkdir encfs
>> # mount | grep encfs
>> /root/encfs on /Encrypted type fuse.encfs (rw,nosuid,nodev,relatime,user_id=10027,group_id=100,default_permissions)
>> ^^^^^^^^^^^
>>
>> Debugging shows two reasons why it happens:
>> 1) encfs is not listed in mnt_fstype_is_pseudofs()
>> 2) mnt_resolve_path() calls canonicalize_path_and_cache() on the kernel output, which makes only a little sense
> 
> Where? It should be easy to check by mnt_fs_is_kernel().

This canonicalize_path_and_cache() mangles the mount output.

If fs is not listed as a pseudofs, it tries to canonicalize the string, e. g. "encfs". If a directory called "encfs" exists in the current directory, it is expanded to path of $PWD/encfs.

char *mnt_resolve_path(const char *path, struct libmnt_cache *cache)
{
	char *p = NULL;

	/*DBG(CACHE, ul_debugobj(cache, "resolving path %s", path));*/

	if (!path)
		return NULL;
	if (cache)
		p = (char *) cache_find_path(cache, path);
	if (!p)
->		p = canonicalize_path_and_cache(path, cache);

	return p;
}

>> Currently I am aware of three file systems affected at least (i. e. not listed): gvfs (subtype was renamed from gvfs-fuse-daemon to gvfsd-fuse), encfs, dumpfs.
>>
>> Easy fix would be adding all of them to the list. But probably much more exists.
> 
> It would be nice to have such easy bugfix, so we can backport it to
> old version etc. :-)

OK, I will send it.

> If we will keep the fstype lists in the code than we can use it as
> the first attempt, if the name is not in the list than use your
> heuristic.

It makes sense.

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
