Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:55742 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968222AbcHBRzG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Aug 2016 13:55:06 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 5CD83AB07
	for <util-linux@vger.kernel.org>; Tue,  2 Aug 2016 17:55:03 +0000 (UTC)
To: util-linux <util-linux@vger.kernel.org>
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 0/8] losetup: re-use loop device
Message-ID: <aaabe320-5552-8963-4143-989e63ae3833@suse.cz>
Date: Tue, 2 Aug 2016 19:55:03 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Here is a patch set that is based on a "safe implementation of loop
reuse" patch set sent three weeks ago.

It addresses the same loop device issues in losetup.

Issues not addressed:
Calling losetup twice still fails (and it is probably correct):
losetup /dev/loop0 loop.img
losetup /dev/loop0 loop.img

"[PATCH 6/8] losetup: Prevent rare detach race" needs a careful review,
as I don't have a test case for it. It is even possible to skip it. It
addresses a theoretical race problem:

LOOPDEV=$(losetup -f --show loop.img)
losetup -d $LOOPDEV
sleep {a very special amount of time}
losetup -f --show loop.img

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
