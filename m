Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49001 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755642AbdDRJeq (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 18 Apr 2017 05:34:46 -0400
Date: Tue, 18 Apr 2017 11:34:40 +0200
From: Karel Zak <kzak@redhat.com>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: util-linux@vger.kernel.org,
        Benno Schulenberg <bensberg@justemail.net>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>
Subject: Re: [PATCH] blkzone: Fix zone condition strings handling
Message-ID: <20170418093440.4d6haj4iqfguonwd@ws.net.home>
References: <20170412092032.7234-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170412092032.7234-1-damien.lemoal@wdc.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 12, 2017 at 06:20:32PM +0900, Damien Le Moal wrote:
> Fixed the condition strings for implicit open and explicit open to
> match the man page defined strings ("oi" and "oe"). Also while at it,
> correct the condition_str array entries adding the reserved "xC" case
> so that the read_only, full and offline conditions match the condition
> codes. This increases the array size to 16, so also fix the condition
> code masking when displaying the result.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  sys-utils/blkzone.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

Damien, what about to add ZONED column to the lsblk(8) command (also
from util-linux)? 

It would be nice to have zone model there. All lsblk is based on /sys,
so add the string from /sys/block/<disk>/queue/zoned should be easy
(just add COL_ZONED with sysfs_strdup() to set_scols_data()).

 lsblk -o+ZONED

will do all the magic for end users. Can you try it? I have no way to
test it.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
