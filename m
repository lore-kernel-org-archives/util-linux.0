Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:51347 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187AbcBKTdM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 11 Feb 2016 14:33:12 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 0BC3FAB02
	for <util-linux@vger.kernel.org>; Thu, 11 Feb 2016 19:33:11 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: tests: strange redirection
Message-ID: <56BCE1F6.9000805@suse.cz>
Date: Thu, 11 Feb 2016 20:33:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I just found
2>&1 >> $TS_OUTPUT
in many tests.

I am not sure, whether it does what is expected:

2>&1 >> $TS_OUTPUT
which does:
Redirect stdout to $TS_OUTPUT and redirect stderr to stdout.

I guess that it is most probably intended to be:
>> $TS_OUTPUT 2>&1
which does:
Redirect stdout and stderr to $TS_OUTPUT.

Here is a global fix:
cd tests/ts
sed -i 's:2>\&1 >> \$TS_OUTPUT:>> $TS_OUTPUT 2>\&1:g' $(fgrep -rl '2>&1 >> $TS_OUTPUT' .)

I ran a check, and it seems, that there could be some minor issues in:

MD raid1 (whole-disks)
mount-by-uuid
mount-flags
x-mount.mkdir
fstab-label
fstab-uuid

The current version of redirection can cause false positive result of
the test.

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
