Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55127 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751514AbaLaJPt (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 31 Dec 2014 04:15:49 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id DC1F120A52
	for <util-linux@vger.kernel.org>; Wed, 31 Dec 2014 04:15:48 -0500 (EST)
Message-Id: <1420017348.3190622.208236865.6FAABC76@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Mike Frysinger <vapier@gentoo.org>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <20141231083046.GF3906@vapier.wh0rd.info>
References: <1419438949.242820.206484249.1D540D03@webmail.messagingengine.com>
 <20141231083046.GF3906@vapier.wh0rd.info>
Subject: Re: setarch cannot set all listed architectures
Date: Wed, 31 Dec 2014 10:15:48 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Wed, Dec 31, 2014, at 09:30, Mike Frysinger wrote:
> On 24 Dec 2014 17:35, Benno Schulenberg wrote:
> > The man page of setarch says for the option --list: "List the architectures
> > that can be set."  However...
> > 
> > $ ./setarch --list   
> > [...]
> > i686
> > athlon
> > x86_64
> > ia64
> > 
> > $ ./setarch x86_64 uname -m
> > setarch: x86_64: Unrecognized architecture
> > 
> > [...]
> > 
> > Maybe --list should not be listing x86_64 and ia64 on this machine?
> > Or maybe the error message in these cases should say "Cannot set
> > the requested architecture" instead?
> 
> are you running a 32bit or 64bit kernel ?  is your compiled setarch 32bit or 
> 64bit ?  i'm going to guess both are 32bit.

You guessed correctly.  :)

$ getconf LONG_BIT
32

$ grep " lm" /proc/cpuinfo || echo no
no

$ file ./setarch 
./setarch: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.24, BuildID[sha1]=0x830fc9635dbe83defa4db7b0b5db241093d4c86d, not stripped

So... setarch --list shouldn't be mentioning x86_64 nor ia64 here?

Benno

-- 
http://www.fastmail.com - A no graphics, no pop-ups email service

