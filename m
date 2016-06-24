Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58812 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751487AbcFXIcD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 24 Jun 2016 04:32:03 -0400
Date: Fri, 24 Jun 2016 10:32:00 +0200
From: Karel Zak <kzak@redhat.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: util-linux@vger.kernel.org
Subject: Re: udf LABEL= handling broken
Message-ID: <20160624083200.gptz2k3sdamoldnq@ws.net.home>
References: <20160606084348.GA26722@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160606084348.GA26722@aepfle.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 06, 2016 at 10:43:48AM +0200, Olaf Hering wrote:
> (Assuming util-linux is used to create broken /dev/disk/by-label/*)
> 
> It seems Win7 handles only up to 11 chars as volume name for a disk
> partition. According to this diff of xxd -a output it puts the length
> after the actual string block. blkid ignores the lenght and uses
> whatever is in the string block as LABEL=. For some reason the string is
> stored twice in the metadata.  The first attempt was volume name 'abcd',
> the second uses the full 11 chars.

It's so tricky with UDF.. it depends if there is also iso9660, what
identifier is set etc. See

 https://github.com/karelzak/util-linux/blob/master/libblkid/src/superblocks/udf.c#L126

it would be nice to have more information, at least blkid -p output.
Maybe also try another udf tools.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
