Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20151109084854.GO19508@ws.net.home>
References: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
	<1446319284-24778-9-git-send-email-kerolasa@iki.fi>
	<20151109084854.GO19508@ws.net.home>
Date: Sun, 22 Nov 2015 21:24:28 +0000
Message-ID: <CAG27Bk1OwvwEUGJVU54ORTHOsirDPS9Wqyg7K5npjtvtmX-rKQ@mail.gmail.com>
Subject: Re: [PATCH 08/12] mkfs.bfs: fix block device open race
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 9 November 2015 at 08:48, Karel Zak <kzak@redhat.com> wrote:
> On Sat, Oct 31, 2015 at 07:21:20PM +0000, Sami Kerola wrote:
>> This fix makes mkfs.bfs also to detect if block device is busy, and warn if
>> the device is misaligned.
>
>  It seems code assumes block devices only, why we need _or_file()
>  here?

Assumption file systems is only created to a block device does not
seem right. The following changes that.

https://github.com/kerolasa/lelux-utiliteetit/commit/98b4f74e1f8f5735e29b6ac37cf4d3dcd77be701

> It would be enough to check statbuf and fstat(fd) for inode
>  number if you want to avoid races.

Maybe yes to avoid races, but the open_blkdev_or_file() does couple
things one always wants when creating file systems, or doing similar
operations. 1) use open(3) flag O_EXCL when opening block device to
ensure nothing else has it open already 2) check for TOCTOU race 3)
warn if device is misaligned.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
