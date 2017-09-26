Return-Path: sbrabec@suse.cz
Subject: Re: [PATCH] losetup: Add support for logical block size
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
 Hannes Reinecke <hare@suse.com>, Omar Sandoval <osandov@fb.com>,
 Jens Axboe <axboe@kernel.dk>
References: <ea2d1f7c-ca7b-331f-06c6-54e122a74382@suse.cz>
 <20170926145712.qvfd4fta6u24x565@ws.net.home>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <d7fb6e59-c7cd-2a58-ce0a-064e1398fd8b@suse.cz>
Date: Tue, 26 Sep 2017 17:25:00 +0200
MIME-Version: 1.0
In-Reply-To: <20170926145712.qvfd4fta6u24x565@ws.net.home>
Content-Type: text/plain; charset=iso-8859-2
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Tue, Sep 26, 2017 at 04:14:51PM +0200, Stanislav Brabec wrote:

>> References:
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/block/loop.c?id=89e4fdecb51cf5535867026274bc97de9480ade5
> 
> This kernel change has been reverted (1e6ec9ea89d30739b9447c1860fcb07fc29f3aef) after
> discussion on LKML.

No, it was not. The reverted one is the previous implementation from
Hannes Reinecke. It introduced new flag LO_FLAGS_BLOCKSIZE.

The link refers to the new implementation introducing new ioctl()
LOOP_SET_BLOCK_SIZE written by Omar Sandoval. I hope that this will stay
in the kernel.

This losetup patch already uses the new implementation with the new
ioctl(,LOOP_SET_BLOCK_SIZE,), including syntax changes caused by the new
implementation. (The old implementation did not make possible "losetup
--logical-blocksize=4096 /dev/loop0", the new one does.)

The previous SUSE patch can be found here:
https://build.opensuse.org/package/view_file/openSUSE:Factory/util-linux/util-linux-losetup-Add-support-for-setting-logical-blocksize.patch?expand=1


Just an additional off topic note:
I reserved 4 characters for the blocksize. I am not sure, whether it is
sufficient, or whether kernel allows much larger logical blocks. (But
actually, the real column width is determined by width of string
"BLOCKSIZE").

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Køi¾íkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
