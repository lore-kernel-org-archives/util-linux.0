Return-Path: grovesaustin@gmail.com
MIME-Version: 1.0
Sender: grovesaustin@gmail.com
In-Reply-To: <1510793291-4771-1-git-send-email-jgroves@micron.com>
References: <1510793291-4771-1-git-send-email-jgroves@micron.com>
From: John Groves <John@groves.net>
Date: Wed, 15 Nov 2017 22:58:48 -0600
Message-ID: <CALz7SpVfjjLs2sFb5w6iNT9purqLYZBXptYpqYbNprewG=EUkQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] libblkid: recognize Micron mpool formatted devices
To: "jgroves@micron.com" <jgroves@micron.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <util-linux.vger.kernel.org>

Oops - trivial oversight.  Please ignore the v2 patch.  Will re-send
as v3 after deleting a couple of constants that are no longer used.

John

On Wed, Nov 15, 2017 at 6:48 PM,  <jgroves@micron.com> wrote:
> From: John Groves <jgroves@micron.com>
>
> This patch adds libblkid recognition of Micron mpool formatted devices.
> It also adds a very simple crc32c() function, for use by probe_mpool().
>
> If there are objections to adding crc32c, I can re-submit without it, or
> make it static for probe_mpool(). I would prefer not to go without crc32c
> validation, because the only remaining check would be the magic number.
>
> Review comments and/or questions still welcome.
>
> Changes since v1:
>
> * probe_mpool() no longer calls blkid_probe_set_value to set
>   VALID="yes"|"no".  This was debug code that I had failed to excise
>   previously.
>
> Thanks,
>
> John Groves (2):
>   Add simple crc32c() function
>   Add support for Micron mpool formatted drives
>
>  include/crc32c.h                       |   9 +++
>  lib/Makemodule.am                      |   1 +
>  lib/crc32c.c                           | 102 +++++++++++++++++++++++++++++++++
>  libblkid/src/Makemodule.am             |   1 +
>  libblkid/src/superblocks/mpool.c       |  69 ++++++++++++++++++++++
>  libblkid/src/superblocks/superblocks.c |   3 +-
>  libblkid/src/superblocks/superblocks.h |   1 +
>  7 files changed, 185 insertions(+), 1 deletion(-)
>  create mode 100644 include/crc32c.h
>  create mode 100644 lib/crc32c.c
>  create mode 100644 libblkid/src/superblocks/mpool.c
>
> --
> 2.9.3
>
