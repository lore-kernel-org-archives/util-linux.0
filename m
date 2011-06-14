Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:4905 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780Ab1FNPEI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 14 Jun 2011 11:04:08 -0400
Date: Tue, 14 Jun 2011 17:04:05 +0200
From: Karel Zak <kzak@redhat.com>
To: John Lindgren <john.lindgren@tds.net>
Cc: util-linux@vger.kernel.org
Subject: Re: Typo in blkid manpage
Message-ID: <20110614150405.GM14293@nb.net.home>
References: <4DF5206F.1070308@tds.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4DF5206F.1070308@tds.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 12, 2011 at 04:24:15PM -0400, John Lindgren wrote:
> list", there is this example:
> 
>     blkid -p -u nominix /dev/sda1
> 
> This should be:
> 
>     blkid -p -n nominix /dev/sda1

 Already fixed in git tree.

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
