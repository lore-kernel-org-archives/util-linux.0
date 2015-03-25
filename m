Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:34495 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752012AbbCYBKX convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 24 Mar 2015 21:10:23 -0400
Date: Wed, 25 Mar 2015 02:10:07 +0100
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: Re: [PATCH] Fix fsck -C {fd} parsing
To: Dave Reisner <d@falconindy.com>
Cc: util-linux@vger.kernel.org
References: <5511C286.90500@suse.cz> <20150324221615.GB513@rampage>
In-Reply-To: <20150324221615.GB513@rampage>
Message-Id: <1427245807.4476.0@utx>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; DelSp=Yes; Format=Flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Dne 24.3.2015 23:16:15 napsal Dave Reisner:
> On Tue, Mar 24, 2015 at 09:01:10PM +0100, Stanislav Brabec wrote:
> > Both fsck(8) and fsck --help documents progress bar redirection as
> > -C {fd}
> >
> > This did not work, and only -C{fd} and "-C {fd}" worked.
> 
> Perhaps rather than break the existing behavior it might be better to
> make the documentation match reality.

It does not break the existing behavior. It just fixes the documented
behavior.

The existing parser was apparently broken: When parsing e. g. -C 3, it
detected the -C standing alone, and then attempts to interpret "-C" as
number instead of parsing of next argument. It fails, so the next
argument is interpreted as stand-alone argument.

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                  fax: +420 284 084 001
Czech Republic                                    http://www.suse.cz/