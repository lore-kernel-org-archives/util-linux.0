Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:37975 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030593AbbD1SaJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 28 Apr 2015 14:30:09 -0400
Message-ID: <553FD1AD.4050609@suse.cz>
Date: Tue, 28 Apr 2015 20:30:05 +0200
From: Stanislav Brabec <sbrabec@suse.cz>
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
        Vitezslav Cizek <vcizek@suse.cz>
Subject: Re: [PATCH] fsck: implement fsck -r {fd}
References: <553E53D7.8020800@suse.cz> <20150428115210.GW27969@ws.net.home> <20150428141558.GA2569@thunk.org> <553FAD98.5070202@suse.cz> <20150428171302.GA11351@thunk.org>
In-Reply-To: <20150428171302.GA11351@thunk.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Theodore Ts'o wrote:

> Actually, what of the one-line statistics do you need?  Is it just
> "we're done checking /dev/sdXX", so you can activate quotas for
> /dev/sdXX?

Yes, I think that it is only the device name.

> If so, one of the other patches which Frank Mayhar (one of
> my collegaues) implemented the ability for fsck to run a "completion
> handler" which was a program/shell script that would get executed for
> each file system the check was completed -- and which would pass the
> exit status for each specific file system along to the completion
> handler.  That allowed us to take specific action on a per-file system
> basis if a file system couldn't be repaired, without having to parse
> any of the log outputs to determine which file system had
> uncorrectable file system problems.
>
> I wonder if something like that would be useful for SuSE?
>

This sounds interesting.


>From the systemd perspective, I can imagine a completely different 
solution. systemd does not use a completion handlers, but it uses 
dependencies: When one task has fulfilled all its dependencies, then it 
could be run.

- fsck depends on presence of device
- mount depends on presence of the device, presence of mount point and
   fsck being complete.


There can be one fsck service per volume instead of one central fsck 
service.

But it is not a task for util-linux developers.


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
