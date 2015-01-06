Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35900 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752753AbbAFKfS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 6 Jan 2015 05:35:18 -0500
Date: Tue, 6 Jan 2015 11:35:14 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>,
        Util-Linux <util-linux@vger.kernel.org>
Subject: Re: setarch cannot set all listed architectures
Message-ID: <20150106103514.GC18528@x2.net.home>
References: <1419438949.242820.206484249.1D540D03@webmail.messagingengine.com>
 <20141231083046.GF3906@vapier.wh0rd.info>
 <1420017348.3190622.208236865.6FAABC76@webmail.messagingengine.com>
 <20141231092354.GG3906@vapier.wh0rd.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141231092354.GG3906@vapier.wh0rd.info>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Dec 31, 2014 at 04:23:54AM -0500, Mike Frysinger wrote:
> On 31 Dec 2014 10:15, Benno Schulenberg wrote:
> > $ file ./setarch 
> > ./setarch: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.24, BuildID[sha1]=0x830fc9635dbe83defa4db7b0b5db241093d4c86d, not stripped
> > 
> > So... setarch --list shouldn't be mentioning x86_64 nor ia64 here?
> 
> maybe, but is it really worth the effort ?
> 
> if you took that exact 32bit binary and booted a 64bit kernel, i imagine it'd 
> work fine.

 Exactly. I think it would be enough to add a note into man page that 
 things are not perfect and supported features depends on kernel.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
