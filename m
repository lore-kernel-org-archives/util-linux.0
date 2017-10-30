Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48572 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752078AbdJ3KoB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 30 Oct 2017 06:44:01 -0400
Date: Mon, 30 Oct 2017 11:43:57 +0100
From: Karel Zak <kzak@redhat.com>
To: Tobias Stoeckmann <tobias@stoeckmann.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] fsck.cramfs: Fix bus error on broken file system.
Message-ID: <20171030104357.lpl7a6vu5snvhznn@ws.net.home>
References: <20171026200117.GA14920@localhost>
 <20171027054743.GA1907@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171027054743.GA1907@localhost>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Oct 27, 2017 at 07:47:43AM +0200, Tobias Stoeckmann wrote:
> The utility fsck.cramfs is prone to a bus error on file systems for
> big endian systems with non-standard header sizes. While calculating
> the crc32 checksum, it does not properly handle a possible offset
> for bootcodes, resulting in out of boundary access of mmap'ed area.
> 
> You can trigger the issue with the following commands:
> 
> $ mkdir -p cramfs-poc/root/subdir
> $ cd cramfs-poc
> $ mkfs.cramfs -p -N big root cramfs
> $ echo -ne \\00\\x4c | dd of=cramfs bs=1 seek=518 count=2 conv=notrunc
> $ fsck.cramfs cramfs
> 
> Signed-off-by: Tobias Stoeckmann <tobias@stoeckmann.org>
> ---
> This is the second and much cleaner version of the initial patch.
> We can easily use the offset of mmap, which heavily reduces the
> manual buf + start calculation.
> ---
>  disk-utils/fsck.cramfs.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/disk-utils/fsck.cramfs.c b/disk-utils/fsck.cramfs.c
> index 50c7d33b9..cafa659af 100644
> --- a/disk-utils/fsck.cramfs.c
> +++ b/disk-utils/fsck.cramfs.c
> @@ -220,7 +220,7 @@ static void test_crc(int start)
>  	crc = crc32(0L, NULL, 0);
>  
>  	buf =
> -	    mmap(NULL, super.size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
> +	    mmap(NULL, super.size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, start);

mmap() offset should be aligned to PAGE_SIZE. The function test_super() 
is able to set "start" to PAD_SIZE (=512). It does not seem correct.

>  	if (buf == MAP_FAILED) {
>  		buf =
>  		    mmap(NULL, super.size, PROT_READ | PROT_WRITE,

on failed mmap() it tries to use open+read to get "buf" and it reads
it from the begin of the file. It seems incompatible with mmap() now.
I guess we need seek(start) there too.

> @@ -233,9 +233,8 @@ static void test_crc(int start)
>  		}
>  	}
>  	if (buf != MAP_FAILED) {
> -		((struct cramfs_super *)((unsigned char *) buf + start))->fsid.crc =
> -		    crc32(0L, NULL, 0);
> -		crc = crc32(crc, (unsigned char *) buf + start, super.size - start);
> +		((struct cramfs_super *) buf)->fsid.crc = crc32(0L, NULL, 0);
> +		crc = crc32(crc, buf, super.size);
>  		munmap(buf, super.size);
>  	} else {
>  		int retval;

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
