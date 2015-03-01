Return-Path: kerolasa@gmail.com
Sender: Sami Kerola <kerolasa@gmail.com>
Date: Sun, 1 Mar 2015 12:24:36 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 09/13] rtcwake: do not overwrite device name
In-Reply-To: <20150224130002.GR19430@ws.net.home>
Message-ID: <alpine.LNX.2.03.1503011223460.822@iki.fi>
References: <1424616139-638-1-git-send-email-kerolasa@iki.fi> <1424616139-638-10-git-send-email-kerolasa@iki.fi> <20150224130002.GR19430@ws.net.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <util-linux.vger.kernel.org>

On Tue, 24 Feb 2015, Karel Zak wrote:

> On Sun, Feb 22, 2015 at 02:42:15PM +0000, Sami Kerola wrote:
> > This improves error messaging, and allows freeing path to device when it
> > is not needed.
> > 
> > Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> > ---
> >  sys-utils/rtcwake.c | 44 +++++++++++++++++++++++---------------------
> >  1 file changed, 23 insertions(+), 21 deletions(-)
> > 
> > diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
> > index f951c9c..7f1e351 100644
> > --- a/sys-utils/rtcwake.c
> > +++ b/sys-utils/rtcwake.c
> > @@ -49,7 +49,7 @@
> >  
> >  #define RTC_PATH		"/sys/class/rtc/%s/device/power/wakeup"
> 
> This is really bad name, what about SYS_WAKEUP_PATH_TEMPLATE ?
> 
> > +static int open_dev_rtc(const char *devname)
> > +{
> > +	int fd;
> > +	char *devpath;
> > +	size_t len = strlen(devname);
> > +
> > +	devpath = xmalloc(sizeof "/dev/" + len);
> > +	memcpy(devpath, "/dev/", sizeof "/dev/");
> > +	memcpy(devpath + strlen("/dev/"), devname, len + 1);
> 
>  if (startswith(devname, "/dev"))
>     devpath = devname;
>  else
>     xasprintf(&devpath, "/dev/%s", devname);  
> 
> > +#ifdef O_CLOEXEC
> > +	fd = open(devpath, O_RDONLY | O_CLOEXEC);
> > +#else
> > +	fd = open(devpath, O_RDONLY);
> > +#endif
> 
>  we use O_CLOEXEC everywhere, #ifdef is unecessary
> 
> > +	if (fd < 0)
> > +		err(EXIT_FAILURE, _("%s: unable to find device"), devpath);
> 
>  if (devname != devpath)
>     free(devpath);
> 
> > +	free(devpath);
> > +	return fd;
> > +}

Thanks Karel,

Updates are done according you proposals.

https://github.com/kerolasa/lelux-utiliteetit/commit/58cdd0c2880d616a7e3754fc629a5d28dd5256e7

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
