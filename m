Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55748 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181Ab3IPIYS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Sep 2013 04:24:18 -0400
Date: Mon, 16 Sep 2013 10:24:13 +0200
From: Karel Zak <kzak@redhat.com>
To: Gabriel de Perthuis <g2p.code@gmail.com>
Cc: Rolf Fokkens <rolf@rolffokkens.nl>, util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] libblkid: Abort after an incorrect checksum
Message-ID: <20130916082413.GA6752@x2.net.home>
References: <1378491089-1135-1-git-send-email-g2p.code@gmail.com>
 <1378491089-1135-2-git-send-email-g2p.code@gmail.com>
 <523487DC.1070704@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <523487DC.1070704@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Sep 14, 2013 at 05:59:24PM +0200, Gabriel de Perthuis wrote:
> > Log incorrect checksums and stop the superblock probing loop when
> > one is encountered.
> > This is to avoid exposing backend devices that are supposed
> > to be used through a stacked device (like raid or bcache).
> 
> Sorry, but some of the changes you made when applying break the patch.
> The intent is to stop the probing loop when a bad container is encountered;
> the contents shouldn't be scanned.

 Why? This is unwanted behaviour. If there is incomplete (broken)
 superblock we continue with probing to check for another superblock.
 This is very basic libblkid feature.

 It's pretty common that there is old obsolete superblock, but user
 expects a new superblock after mkfs. Unfortunately not all mkfs-like
 programs wipe devices.


 Do you think that the content in the bad bcache could be interpreted
 as regular filesystem? I don't think so.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
