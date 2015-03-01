Return-Path: kerolasa@gmail.com
Sender: Sami Kerola <kerolasa@gmail.com>
Date: Sun, 1 Mar 2015 12:20:12 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 14/16] tailf: ensure file argument really is a file
In-Reply-To: <20150224121800.GO19430@ws.net.home>
Message-ID: <alpine.LNX.2.03.1503011212470.822@iki.fi>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi> <1424616106-580-15-git-send-email-kerolasa@iki.fi> <20150224121800.GO19430@ws.net.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <util-linux.vger.kernel.org>

On Tue, 24 Feb 2015, Karel Zak wrote:

> On Sun, Feb 22, 2015 at 02:41:44PM +0000, Sami Kerola wrote:
> >  text-utils/tailf.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/text-utils/tailf.c b/text-utils/tailf.c
> > index d856203..7f053a4 100644
> > --- a/text-utils/tailf.c
> > +++ b/text-utils/tailf.c
> > @@ -233,6 +233,28 @@ static long old_style_option(int *argc, char **argv, unsigned long *lines)
> >  	return ret;
> >  }
> >  
> > +static int is_file(const char *filename, const struct stat sb)
> > +{
> > +	switch (sb.st_mode & S_IFMT) {
> > +	case S_IFREG:
> > +		return 0;
> > +	case S_IFLNK:
> > +		{
> > +			char *resolved_path = NULL;
> > +			struct stat follow;
> > +			int ret;
> > +
> > +			if (realpath(filename, resolved_path)) {
> > +				stat(resolved_path, &follow);
> > +				ret = is_file(resolved_path, follow);
> > +				free(resolved_path);
> > +				return ret;
> > +			}
> > +		}
> 
>  but you use stat() and no lstat(), so you don't have to care about
>  symlinks, right? :-)
> 
> >  	if (stat(filename, &old) != 0)
> >  		err(EXIT_FAILURE, _("stat of %s failed"), filename);
> 
>  if (IS_REG(old.st_mode))
>         errx(EXIT_FAILURE, _("%s: is not a file"), filename);

Thanks Karel,

Change is made a lot nicer, and I found what got side lined;

((st.st_mode & S_IFMT) == S_IFREG) != S_ISREG(st.st_mode)

Let's hope I will never forget that in future.

https://github.com/kerolasa/lelux-utiliteetit/commit/a7a3440221e74408ef7727b6c3c83ed68e6e4936

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
