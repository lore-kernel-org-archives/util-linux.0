Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751934AbcKCMBB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 3 Nov 2016 08:01:01 -0400
Date: Thu, 3 Nov 2016 13:00:59 +0100
From: Karel Zak <kzak@redhat.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: util-linux@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH 2/4] lsmem: new tool
Message-ID: <20161103120059.75nflzf5wvepafzu@ws.net.home>
References: <20161012120047.60732-1-heiko.carstens@de.ibm.com>
 <20161012120047.60732-3-heiko.carstens@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161012120047.60732-3-heiko.carstens@de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 12, 2016 at 02:00:45PM +0200, Heiko Carstens wrote:
> RANGE                                 SIZE STATE   REMOVABLE BLOCK
> 0x0000000000000000-0x000000005fffffff 1,5G online  yes       0-5
> 0x0000000060000000-0x000000007fffffff 512M online  no        6-7
> 0x0000000080000000-0x000000013fffffff   3G online  yes       8-19
> 0x0000000140000000-0x000000014fffffff 256M offline -         20
> 0x0000000150000000-0x000000017fffffff 768M online  no        21-23
> 
> Memory block size   :     256M
> Total online memory :     5,8G
> Total offline memory:     256M

It seems that for backward compatibility we need the summary lines at
the end. Maybe we can add --no-summary and --summary-only for people
who want to use it in the scripts.
 
> The lsmem tool also has "--extendend" and "--parsable" option which
> can be used to customize the output, e.g.  limit the output to
> specified columns. This is quite similar to what the lscpu tool does.

Frankly, I don't like these lscpu options :-) For new tools we have
--pairs/export (NAME=value), --raw, --json and --output=<list>. 

You do not need to re-submit the patches, I'll cleanup the stuff.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
