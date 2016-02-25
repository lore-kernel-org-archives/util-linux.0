Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:42260 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933583AbcBYTbb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 25 Feb 2016 14:31:31 -0500
Subject: Re: [PATCH] tests: add test for loop option in fstab (my mistake, and
 two new bugs, one in kernel)
To: Karel Zak <kzak@redhat.com>
References: <56BCE4F4.6020409@suse.cz> <201602151242.10369.sweet_f_a@gmx.de>
 <20160216144918.iqmvz27qggxfnjng@ws.net.home> <56C75E7B.60407@suse.cz>
 <20160222101233.imyhujomel6ydin3@ws.net.home> <56CB3909.4080808@suse.cz>
 <56CDFD40.7020603@suse.cz> <56CE2199.6010509@suse.cz>
Cc: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org,
        David Sterba <dsterba@suse.cz>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56CF5691.5010006@suse.cz>
Date: Thu, 25 Feb 2016 20:31:29 +0100
MIME-Version: 1.0
In-Reply-To: <56CE2199.6010509@suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Feb 24, 2016 at 22:33 Stanislav Brabec wrote:

> => It looks like a kernel bug.
> Kernel is openSUSE Tumbleweed linux-4.4.1-1.

Analyzed and sent to LKML.
http://marc.info/?l=linux-kernel&m=145642818824430&w=2

It seems that problem reported here is triggered by multiple mounts 
using multiple loop devices pointing to the same file.

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
