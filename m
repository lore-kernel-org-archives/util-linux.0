Return-Path: rodrigo@sdfg.com.ar
Date: Fri, 14 Feb 2014 13:16:22 +0000
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v3] fallocate: Add "--dig-holes" option
Message-ID: <20140214131622.GE7927@sdfg.com.ar>
References: <1390747439-14086-1-git-send-email-rodrigo@sdfg.com.ar>
 <1390748810-14517-1-git-send-email-rodrigo@sdfg.com.ar>
 <20140214104756.GA28125@x2.net.home>
 <20140214113432.GB28125@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140214113432.GB28125@x2.net.home>
List-ID: <util-linux.vger.kernel.org>

On Fri, Feb 14, 2014 at 12:34:32PM +0100, Karel Zak wrote:
> On Fri, Feb 14, 2014 at 11:47:56AM +0100, Karel Zak wrote:
> >  I don't like all the detection algorithm. Do we really need to allocate 
> >  all hole size and the buffer? 
> > 
> >  IMHO it would be enough to:
> > 
> >  * add posix_fadvise(... POSIX_FADV_SEQUENTIAL | POSIX_FADV_NOREUSE)
> > 
> >  * read the file in small chunks -- for example BUFSIZ and compare
> >    this with small empty static buffer.
> > 
> >  .. it's kernel business to read from FS/device in optimal way and I
> >  don't think that context switches are so critical issue when all the
> >  thing is about I/O.
> > 
> >  I didn't test it, so maybe I'm wrong, but the current code where we
> >  eat RAM seems too crazy. Comments?
> 
>  .. and another issue, the current code assumes that the holes are
>  aligned to hole_size that we read from the file. If the hole starts
>  within the buffer and continues in the next chunk than it's ignored.

Yes, that was for simplicity too. And also, if the hole size is "small" compared
to the size of the chunks of '\0's, you will create a hole for most of the space
anyways.

There are, of course, pathological cases. But I'm not sure they happen in real
life, I think they are probably more theoretical and in practice only little
space that was '\0's where not holed. And if they do happen, we can improve it
later.

What do you think ?



Thanks a lot,
Rodrigo
