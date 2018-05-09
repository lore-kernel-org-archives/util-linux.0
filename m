Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:47335 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965533AbeEIQ0S (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 9 May 2018 12:26:18 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9AD36ACDB
        for <util-linux@vger.kernel.org>; Wed,  9 May 2018 16:26:16 +0000 (UTC)
Subject: Re: [PATCH] Avoid use of the old CPU macros
To: Michael Matz <matz@suse.de>
Cc: util-linux@vger.kernel.org
References: <2985b3d2-facd-13f1-10f7-bc265edfed6d@suse.cz>
 <alpine.LSU.2.21.1805091812050.12477@wotan.suse.de>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <e77e06a7-12a5-2e53-42ff-78e337bb6d14@suse.cz>
Date: Wed, 9 May 2018 18:26:16 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.1805091812050.12477@wotan.suse.de>
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Michael Matz wrote:
> On Wed, 9 May 2018, Stanislav Brabec wrote:
>>  	for (cpu = 0; cpu < setsize; cpu++) {
>> -		if (!CPU_ISSET(cpu, cpu_set))
>> +		if (!CPU_ISSET_S(cpu, setsize, cpu_set))
> 
> Careful, the _S macros count the size in _bytes_, the above loop iterates 
> in nr-of-cpus (i.e. bits), or alternatively if the caller really gives a 
> byte size then the loop iterations don't catch all CPUs.  More instances 
> follow.

setsize passed to the function is CPU_ALLOC_SIZE(maxcpus).

Do I understand correctly that the new !CPU_ISSET_S is correct, but the
loop limit should be maxcpus?

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
