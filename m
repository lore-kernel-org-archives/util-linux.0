Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:40467 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753408AbcHCNSE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 3 Aug 2016 09:18:04 -0400
Subject: Re: [PATCH 5/8] Prevent AUTOCLEAR detach race
To: Karel Zak <kzak@redhat.com>
References: <c83ba048-2d5e-da62-4a99-2d05f75add4a@suse.cz>
 <20160803092858.ed7zill5wfni6mfq@ws.net.home>
Cc: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <06c61b6b-4f1a-e11a-ab6a-a3217a93eb08@suse.cz>
Date: Wed, 3 Aug 2016 15:18:00 +0200
MIME-Version: 1.0
In-Reply-To: <20160803092858.ed7zill5wfni6mfq@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Tue, Aug 02, 2016 at 07:58:29PM +0200, Stanislav Brabec wrote:
>> +				lc.info.lo_flags &= !LO_FLAGS_AUTOCLEAR;
>
> This is strange, what if the device we want to reuse has been created
> by mount(8) and AUTOCLEAR flag is wanted.

I think that once we use losetup, we do not want AUTOCLEAR, but we 
change to explicit losetup -d.

Without this patch, the testsuite test losetup-loop/find-race-condition 
will fail, because "losetup -d /dev/loop0" actually does not free the 
device immediately, but only sets AUTOCLEAR flag. The device still 
exists for a fraction of second, and consequent losetup is able to find 
it and return it. But the device continues in release process and 
disappear before it is used.

To discriminate between AUTOCLEAR device used by mount and AUTOCLEAR 
device just dying, that will disappear soon, we would check for use count.

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Křižíkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
