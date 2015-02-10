Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:56600 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751664AbbBJVah (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 10 Feb 2015 16:30:37 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id D8BBCAC34
	for <util-linux@vger.kernel.org>; Tue, 10 Feb 2015 21:30:35 +0000 (UTC)
Message-ID: <54DA787B.4090205@suse.cz>
Date: Tue, 10 Feb 2015 22:30:35 +0100
From: Stanislav Brabec <sbrabec@suse.cz>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH 0/3] script: no logging for non-interactive shells
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Many people use script in their shell initialization files. It has some 
unwanted consequences, e. g. logging commands from cron (and starting 
them in a pseudo-terminal and interactive shell). It could also result 
in a seemingly hanging applications:

For example:

echo -e './script\nTERM=linux mutt' | \
   at $(date -d "+1 minute 5 seconds" +%H:%M)

mutt will "hang" inside at, because it thinks that it is running in an 
interactive shell and waits for input.

That is why I wrote --interactive command line option. If it is set, 
script called from a non-interactive session will not log anything, just 
(optionally) execute -c argument and silently exit.

Note that similar behavior existed between f50473e and 3822032, but the 
new proposed behavior does not generate error.

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
