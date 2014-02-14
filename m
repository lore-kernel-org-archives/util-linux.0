Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:25365 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932AbaBNKsG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 14 Feb 2014 05:48:06 -0500
Date: Fri, 14 Feb 2014 11:47:56 +0100
From: Karel Zak <kzak@redhat.com>
To: Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v3] fallocate: Add "--dig-holes" option
Message-ID: <20140214104756.GA28125@x2.net.home>
References: <1390747439-14086-1-git-send-email-rodrigo@sdfg.com.ar>
 <1390748810-14517-1-git-send-email-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1390748810-14517-1-git-send-email-rodrigo@sdfg.com.ar>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jan 26, 2014 at 03:06:50PM +0000, Rodrigo Campos wrote:
>  bash-completion/fallocate |   2 +-
>  sys-utils/fallocate.1     |  19 +++++++-
>  sys-utils/fallocate.c     | 114 ++++++++++++++++++++++++++++++++++++++++------
>  3 files changed, 120 insertions(+), 15 deletions(-)

 Applied with some changes and I believe that the code still need some
 improvements, see below

> + */
> +static int detect_holes(int fd, size_t hole_size)
> +{
> +	int ret = 0;
> +	int err;
> +
> +	if (hole_size >= 100 * 1024 * 1024) {
> +		size_t ram_mb = hole_size / 1024 / 1024;
> +		printf("WARNING: %zu MB RAM will be used\n", ram_mb);
> +		sleep(3);
> +	}

 I have removed this thing... 
 
 I don't like all the detection algorithm. Do we really need to allocate 
 all hole size and the buffer? 

 IMHO it would be enough to:

 * add posix_fadvise(... POSIX_FADV_SEQUENTIAL | POSIX_FADV_NOREUSE)

 * read the file in small chunks -- for example BUFSIZ and compare
   this with small empty static buffer.

 .. it's kernel business to read from FS/device in optimal way and I
 don't think that context switches are so critical issue when all the
 thing is about I/O.

 I didn't test it, so maybe I'm wrong, but the current code where we
 eat RAM seems too crazy. Comments?

> +	/* Create a buffer of '\0's to compare against */
> +	/* XXX: Use mmap() with MAP_PRIVATE so Linux can avoid this allocation */
> +	void *zeros = mmap(NULL, hole_size, PROT_READ,
> +	                   MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
> +	if (zeros == MAP_FAILED) {
> +		perror("mmap");

 we use err.h stuff, and it's usually good enough to exit after error
 than waste time with memory deallocation and another clean ups. The
 kernel is smart enough to clean up after exit().

> +	off_t end = lseek(fd, 0, SEEK_END);
    ^^^^^^^^^^^^^^
> +	if (end == -1) {
> +		perror("lseek");
> +		ret = -1;
> +		goto out;
> +	}
> +
> +	for (off_t offset = 0; offset + hole_size <= end; offset += buf_len) {
         ^^^^^^^^^^^

 Yes it's expected by C standards, but it sucks. Don't use it, it's
 reader's nightmare.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
