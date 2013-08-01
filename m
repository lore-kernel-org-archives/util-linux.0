Return-Path: dg@treblig.org
Date: Thu, 1 Aug 2013 13:57:03 +0100
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Karel Zak <kzak@redhat.com>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, util-linux@vger.kernel.org,
        rleigh@debian.org
Subject: Re: [PATCH] get_line fixes for wide characters and overflows
Message-ID: <20130801125703.GA7815@gallifrey>
References: <20130716232033.GD9944@gallifrey>
 <20130719223501.GA13613@gallifrey>
 <20130801110159.GA2484@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130801110159.GA2484@x2.net.home>
List-ID: <util-linux.vger.kernel.org>

* Karel Zak (kzak@redhat.com) wrote:
> On Fri, Jul 19, 2013 at 11:35:01PM +0100, Dr. David Alan Gilbert wrote:
> >   This is a fix for the bug I reported with 'more' crashing:
> > http://marc.info/?l=util-linux-ng&m=137401887913346&w=2
> 
>  It seems that bug has been introduced 4 years ago by my commit
>  1ac300932deab8dea2c43050921bbbdb36d62ff1.
> 
>  The original code used static buffer Line[LINSIZ+2] -- yes, +2 for \n\0.
> 
>  I have applied the patch below. Please, test it (I'm not able to
>  reproduce the problem with the file from Suse bugzilla).

Hi Karel,
  Thanks for the reply.  I'll give it a go over the weekend,
but I don't think it can handle the wchar problems I described and fixed
in my follow up patch. If a 4byte wchar hapens to land at the end of the buffer
how do you guarantee the space?

Dave

> 
>  Thanks!
> 
>     Karel
> 
> >From 1ef2db5a5672e09fa1337099b7d9d6ab61c19bdc Mon Sep 17 00:00:00 2001
> From: Karel Zak <kzak@redhat.com>
> Date: Thu, 1 Aug 2013 12:58:22 +0200
> Subject: [PATCH] more: fix buffer overflow
> 
> The bug has been probably introduced by commit
> 1ac300932deab8dea2c43050921bbbdb36d62ff1.
> 
> Reported-by: "Dr. David Alan Gilbert" <dave@treblig.org>
> References: https://bugzilla.novell.com/show_bug.cgi?id=829720
> Signed-off-by: Karel Zak <kzak@redhat.com>
> ---
>  text-utils/more.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/text-utils/more.c b/text-utils/more.c
> index 3bbeede..3377118 100644
> --- a/text-utils/more.c
> +++ b/text-utils/more.c
> @@ -835,7 +835,8 @@ void prepare_line_buffer(void)
>  	if (nsz < LINSIZ)
>  		nsz = LINSIZ;
>  
> -	nline = xrealloc(Line, nsz);
> +	/* alloc nsz and extra space for \n\0 */
> +	nline = xrealloc(Line, nsz + 2);
>  	Line = nline;
>  	LineLen = nsz;
>  }
> -- 
> 1.8.1.4
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\ gro.gilbert @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
