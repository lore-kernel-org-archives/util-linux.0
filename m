Return-Path: rodrigo@sdfg.com.ar
Date: Fri, 14 Feb 2014 13:07:53 +0000
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v3] fallocate: Add "--dig-holes" option
Message-ID: <20140214130752.GD7927@sdfg.com.ar>
References: <1390747439-14086-1-git-send-email-rodrigo@sdfg.com.ar>
 <1390748810-14517-1-git-send-email-rodrigo@sdfg.com.ar>
 <20140214104756.GA28125@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140214104756.GA28125@x2.net.home>
List-ID: <util-linux.vger.kernel.org>

On Fri, Feb 14, 2014 at 11:47:56AM +0100, Karel Zak wrote:
> On Sun, Jan 26, 2014 at 03:06:50PM +0000, Rodrigo Campos wrote:
> >  bash-completion/fallocate |   2 +-
> >  sys-utils/fallocate.1     |  19 +++++++-
> >  sys-utils/fallocate.c     | 114 ++++++++++++++++++++++++++++++++++++++++------
> >  3 files changed, 120 insertions(+), 15 deletions(-)
> 
>  Applied with some changes and I believe that the code still need some
>  improvements, see below

Thanks :)

> 
> > + */
> > +static int detect_holes(int fd, size_t hole_size)
> > +{
> > +	int ret = 0;
> > +	int err;
> > +
> > +	if (hole_size >= 100 * 1024 * 1024) {
> > +		size_t ram_mb = hole_size / 1024 / 1024;
> > +		printf("WARNING: %zu MB RAM will be used\n", ram_mb);
> > +		sleep(3);
> > +	}
> 
>  I have removed this thing... 
>  
>  I don't like all the detection algorithm. Do we really need to allocate 
>  all hole size and the buffer? 

No, not really. I just did it because it's easy and I thought you probably don't
use big sizes (as it will detect less holes) and probably some "small" size is
enough in practice, even for big files, and that size in RAM is probably not
significant.

> 
>  IMHO it would be enough to:
> 
>  * add posix_fadvise(... POSIX_FADV_SEQUENTIAL | POSIX_FADV_NOREUSE)
> 
>  * read the file in small chunks -- for example BUFSIZ and compare
>    this with small empty static buffer.

That's totally possible too, sure :)

> 
>  .. it's kernel business to read from FS/device in optimal way and I
>  don't think that context switches are so critical issue when all the
>  thing is about I/O.

context switches ? I'm not sure I follow you there...

> 
>  I didn't test it, so maybe I'm wrong, but the current code where we
>  eat RAM seems too crazy. Comments?

The default size is 32kb, so that's what you eat of RAM by default. And I don't
expect sizes bigger than, let's say 10MB but probably less, make sense... That
was my reasoning when I decided to allocate the whole buffer.

But it can be changed, of course :)

> 
> > +	/* Create a buffer of '\0's to compare against */
> > +	/* XXX: Use mmap() with MAP_PRIVATE so Linux can avoid this allocation */
> > +	void *zeros = mmap(NULL, hole_size, PROT_READ,
> > +	                   MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
> > +	if (zeros == MAP_FAILED) {
> > +		perror("mmap");
> 
>  we use err.h stuff, and it's usually good enough to exit after error
>  than waste time with memory deallocation and another clean ups. The
>  kernel is smart enough to clean up after exit().

Sorry, I didn't know this was prefered. And you already changed it, thanks!

> 
> > +	off_t end = lseek(fd, 0, SEEK_END);
>     ^^^^^^^^^^^^^^
> > +	if (end == -1) {
> > +		perror("lseek");
> > +		ret = -1;
> > +		goto out;
> > +	}
> > +
> > +	for (off_t offset = 0; offset + hole_size <= end; offset += buf_len) {
>          ^^^^^^^^^^^
> 
>  Yes it's expected by C standards, but it sucks. Don't use it, it's
>  reader's nightmare.

Ohh, I didn't know. Can I ask why ?

And what type should I use ? loff_t ? Why is this better ?

(just curious, I want to understand :))



Thanks a lot,
Rodrigo
