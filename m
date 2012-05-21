Return-Path: dave@gnu.org
Date: Mon, 21 May 2012 12:44:45 +0200
From: Davidlohr Bueso <dave@gnu.org>
Subject: Re: [PATCH 5/6] fdisk: introduce fdisk context
In-reply-to: <20120521094054.GA14560@x2.net.home>
To: Karel Zak <kzak@redhat.com>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Message-id: <1337597085.4538.8.camel@offworld>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
References: <1337530296.2677.16.camel@offbook>
 <20120521094054.GA14560@x2.net.home>
List-ID: <util-linux.vger.kernel.org>

On Mon, 2012-05-21 at 11:40 +0200, Karel Zak wrote:
> On Sun, May 20, 2012 at 06:11:36PM +0200, Davidlohr Bueso wrote:
> > +struct fdisk_context *fdisk_new_context_from_filename(const char *fname)
> > +{
> > +	int fd;
> > +	struct fdisk_context *cxt = NULL;
> > +
> > +	/*
> > +	 * Attempt to open the device with r-w permissions
> > +	 * by default, otherwise try read-only.
> > +	 */
> > +	if ((fd = open(fname, O_RDWR)) < 0)
> > +		if ((fd = open(fname, O_RDONLY)) < 0)
> > +			goto ret;
> 
>             return NULL;
> 
> > +	cxt = calloc(1, sizeof(*cxt));
> > +	if (!cxt)
> > +		goto ret;
> > +
> > +	cxt->dev_fd = fd;
> > +	cxt->dev_path = strdup(fname);
> > +	if (!cxt->dev_path)
> > +		return NULL;
> 
>         goto fail;
> 
>  Please, think about it as about library, it meas without memory and
>  fd leaks :-)
> 
> > +ret:
> > +	return cxt;
> > +}
> > +
> 
>    return cxt;
> 
> fail:
>    errsv = errno;
Hmm I hadn't considered saving errno stuff...

>    fdisk_free_context(cxt);

Yes, we need to plug that descriptor leak! fdisk_free_context() also
frees cxt->dev_path, so we should really just call close(fd).

Thanks,
Davidlohr

>    errno = errsv;
>    return NULL;
> 
> 
>     Karel
> 
