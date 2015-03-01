Return-Path: kerolasa@gmail.com
Sender: Sami Kerola <kerolasa@gmail.com>
Date: Sun, 1 Mar 2015 12:09:46 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 12/16] tailf: count last lines correctly at initial print
 out
In-Reply-To: <20150224121241.GN19430@ws.net.home>
Message-ID: <alpine.LNX.2.03.1503011159140.822@iki.fi>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi> <1424616106-580-13-git-send-email-kerolasa@iki.fi> <20150224121241.GN19430@ws.net.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <util-linux.vger.kernel.org>

On Tue, 24 Feb 2015, Karel Zak wrote:

> On Sun, Feb 22, 2015 at 02:41:42PM +0000, Sami Kerola wrote:
> > When last lines happen to be greater than string buffer size for fgets()
> > the number of printed lines resulted to too few.
> 
>  Maybe add a note about mmap() to commit message ?!

Thanks Karel,

Done.

https://github.com/kerolasa/lelux-utiliteetit/commit/537f3b197f3c6af307997ebd103becbf44f529c1

> > -	if (!(str = fopen(filename, "r")))
> > +	if (!(fd = open(filename, O_RDONLY)))
> >  		err(EXIT_FAILURE, _("cannot open %s"), filename);
> > -
> > -	buf = xmalloc((lines ? lines : 1) * BUFSIZ);
> > -	p = buf;
> > -	while (fgets(p, BUFSIZ, str)) {
> > -		if (++tail >= lines) {
> > -			tail = 0;
> > -			head = 1;
> > +	data = mmap(0, old->st_size, PROT_READ, MAP_SHARED, fd, 0);
> 
>  It would be nice to compare this it with original implementation on
>  large files. I guess mmap will be more effective and faster.

My motivation to do this change had less to do with speed than correcness. 
Earlier version did not print requested number or lines when tail read 
buffer was insufficient. That probably did not happen too often as 8K is a 
lot of text.

The reason I chose mmap() is simple. It provides easy interface to read a 
file backwards. And a potential speed gain is a nice side effect.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
