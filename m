Return-Path: util-linux-owner@vger.kernel.org
Received: from n26.netmark.pl ([94.124.9.61]:37057 "EHLO n26.netmark.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908Ab2DZHwt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Apr 2012 03:52:49 -0400
Received: from afnk230.neoplus.adsl.tpnet.pl ([178.42.88.230]:40548 helo=magazyn-ziarno)
	by n26.netmark.pl with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.77)
	(envelope-from <Marcin.Szewczyk@wodny.org>)
	id 1SNJVQ-002wQN-GG
	for util-linux@vger.kernel.org; Thu, 26 Apr 2012 09:52:48 +0200
Date: Thu, 26 Apr 2012 09:52:48 +0200
From: Marcin Szewczyk <Marcin.Szewczyk@wodny.org>
To: util-linux@vger.kernel.org
Subject: Re: Duplicate UUIDs, findmnt, /dev/disk/by-uuid
Message-ID: <20120426075248.GB2471@magazyn-ziarno.zbozowa>
References: <20120423154106.GD2437@magazyn-ziarno.zbozowa>
 <20120425075628.GD17370@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20120425075628.GD17370@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 25, 2012 at 09:56:28AM +0200, Karel Zak wrote:
>  Implemented (in upstream tree).
> 
>  $ findmnt 8:1
>  TARGET    SOURCE    FSTYPE OPTIONS
>  /boot/efi /dev/sda1 vfat   rw,relatime,fmask=0077,dmask=0077,codepage=cp437,ioch
> 
> 
>  (or with "--source 8:1" option to make it more explicit)

BTW, I've completely missed the MAJ:MIN functionality at first. I've
filed a bug report[1] to Debian mount package to mention the MAJ:MIN
column.

[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=670273

-- 
Marcin Szewczyk                       http://wodny.org
mailto:Marcin.Szewczyk@wodny.borg  <- remove b / usuń b
xmpp:wodny@ubuntu.pl                  xmpp:wodny@jabster.pl
