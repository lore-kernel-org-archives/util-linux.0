Return-Path: rodrigo@sdfg.com.ar
Date: Mon, 17 Feb 2014 15:42:21 +0000
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v3] fallocate: Add "--dig-holes" option
Message-ID: <20140217154221.GA565@sdfg.com.ar>
References: <1390747439-14086-1-git-send-email-rodrigo@sdfg.com.ar>
 <1390748810-14517-1-git-send-email-rodrigo@sdfg.com.ar>
 <20140214104756.GA28125@x2.net.home>
 <20140217103248.GA2254@x2.net.home>
 <20140217141529.GA29685@sdfg.com.ar>
 <20140217144907.GJ2254@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20140217144907.GJ2254@x2.net.home>
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 17, 2014 at 03:49:07PM +0100, Karel Zak wrote:
> On Mon, Feb 17, 2014 at 02:15:29PM +0000, Rodrigo Campos wrote:
> > On Mon, Feb 17, 2014 at 11:32:48AM +0100, Karel Zak wrote:
> > > On Fri, Feb 14, 2014 at 11:47:56AM +0100, Karel Zak wrote:
> > > > On Sun, Jan 26, 2014 at 03:06:50PM +0000, Rodrigo Campos wrote:
> > > > >  bash-completion/fallocate |   2 +-
> > > > >  sys-utils/fallocate.1     |  19 +++++++-
> > > > >  sys-utils/fallocate.c     | 114 ++++++++++++++++++++++++++++++++++++++++------
> > > > >  3 files changed, 120 insertions(+), 15 deletions(-)
> > > > 
> > > >  Applied with some changes and I believe that the code still need some
> > > >  improvements, see below
> > > 
> > > 
> > >  OK, I did some changes to the code:
> > > 
> > >  The minimal hole size is based on filesystem blocksize (st_blksize) and 
> > >  --length is no more used for this thing. I think it's better to use
> > 
> > This was not updated in the manpage, where it shows the run modes. It still
> > says on the top "fallocate -d [-l length] filename"
> 
>  Oh.. synopsis. Thanks, fixed now.

Np :)

> 
> > > 28K -rw-rw-r-- 1 kzak kzak 1.0G Feb 17 11:10 yyy
> > > ^^^
> > 
> > How did you create the file ? With fallocate ? Is it all zeros ? If it's all
> > zeros, 28K used seems like a bug maybe ?
> 
>  It's file with 6 holes with different sizes (1024, 10240, 102400 ....etc).

Ok, 28K may be okay then :)

> 
> > Any comparisson to see how much it took before (to see the improvement or the
> 
> old version:
> 
>         $ ls -lash yyy
>         1.1G -rw-rw-r-- 1 kzak kzak 1.0G Feb 17 15:39 yyy
> 
>         $ time ./fallocate --dig-holes
>         yyy
> 
>         real    0m0.525s
>         user    0m0.057s
>         sys     0m0.463s
> 
>         $ ls -lash yyy
>         164K -rw-rw-r-- 1 kzak kzak 1.0G Feb 17 15:39 yyy
> 
>  The 164K is because the small holes are ignored due to 32K buffer size.
> 
>  The speed improvement is probably because new code calls fallocate()
>  only when end of the hole is detected. The another possibility is
>  posix_fadvise(), but I have doubts that kernel readahead is so good.

Yeah, is probably avoiding the syscall IMHO too.

> > I can't test it in my new laptop because it fails to compile (autogen and
> > configure run fine). It throws:
> > 
> > 	rm -f ca.gmo && : -c --statistics --verbose -o ca.gmo ca.po
> > 	mv: cannot stat ‘t-ca.gmo’: No such file or directory
> > 	make[3]: *** [ca.gmo] Error 1
> > 
> > 
> > is this a known issue ?
> 
>  hmm... try git clean -xdf; ./autogen.sh ....

It's pretty much a fresh clone. I tried that and didn't help, also tried a
completely new clone, and fails the same way (same error). I'm using a Debian
testing/unstable in a 64bit machine now... (but doesn't seem 64bit related)

Will try to investigate later, when I have some spare time




Thanks,
Rodrigo
