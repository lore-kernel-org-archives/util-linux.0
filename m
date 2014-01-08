Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:36707 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752274AbaAHRzp (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 8 Jan 2014 12:55:45 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id E634EAC35
	for <util-linux@vger.kernel.org>; Wed,  8 Jan 2014 17:55:43 +0000 (UTC)
Message-ID: <1389203741.8841.31.camel@oct.suse.cz>
Subject: mount: "nofail" and already mounted devices?
From: Stanislav Brabec <sbrabec@suse.cz>
To: util-linux@vger.kernel.org
Date: Wed, 08 Jan 2014 18:55:41 +0100
Content-Type: text/plain; charset="ISO-8859-2"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Attempting to mount of already mounted devices is a common situation in
many scripts. There is no easy way to detect it in the current mount
implementation.

One of our users complains that this situation is not covered by
"nofail" mount option. ("nofail" does exactly what the documentation
describes and nothing more.)

Would be acceptable a patch that adds "already mounted" to "nofail"?

If not, what would be the best way of enabling this feature for mounting
a single device? (It already exists in mount, but it is usable only with
"mount -a".)

- Add another mount option, e. g. mountednofail or mountedok
- Make possible to use "-a" with further arguments.
- Add new option, e. g. "-A".
and/or
- New result code, e. g. 33 instead of 32. (As it can not suppress the
error message, it is well usable only as an addition to above.)

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

