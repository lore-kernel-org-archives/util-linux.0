Return-Path: dave@gnu.org
Date: Wed, 23 May 2012 11:51:16 +0200
From: Davidlohr Bueso <dave@gnu.org>
Subject: Re: [PATCH 5/6] fdisk: introduce fdisk context
In-reply-to: <20120523094250.GA1297@x2.net.home>
To: Karel Zak <kzak@redhat.com>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Message-id: <1337766676.24092.3.camel@offworld>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
References: <1337530296.2677.16.camel@offbook>
 <20120521094054.GA14560@x2.net.home> <1337631275.2596.1.camel@offbook>
 <1337632083.2596.5.camel@offbook> <20120523094250.GA1297@x2.net.home>
List-ID: <util-linux.vger.kernel.org>

On Wed, 2012-05-23 at 11:42 +0200, Karel Zak wrote:
> On Mon, May 21, 2012 at 10:28:03PM +0200, Davidlohr Bueso wrote:
> > This is the first patch that adds the initial parts of the new fdisk
> > internal API. Two functions are created to both init and deinit the
> > fdisk context. Only the device's descriptor and path are added as a
> > start and these are replaced throughout fdisk.c and label specific
> > code.
> 
> Applied (and the rest of the patches too), thanks.

thanks.

> 
> > All logic that opens the file does it with
> > fdisk_new_context_from_filename(), and this enforces always opening
> > the device with rw
> 
> I have added 'readonly' option to the fdisk_new_context_from_filename().

Well I wanted to leave it open for new features like when no device is
passed (-l option IIRC) and read from /proc/partitions.

> 
> It would be better to minimize number of situation where we somewhere
> open devices read-write. For example udevd, udisks, ... are pretty
> sensitive to write operations (to detect new PT or new filesystem
> etc.).
> 
> Notes:
> 
> 1/ What about to rename fdisk_new_context_from_filename() to
>    fdisk_new_context()? I guess that the device name is mandatory option.
> 
> 2/ Please, don't use global 'cxt' if possible. See for example
> 

Totally agree. I plan to gradually modify current functions to pass cxt
as an argument instead of doing it globally - but it was kind of
invasive for this pachset.

>    get_geometry() -> get_topology()
> 
>    disk.c: In function ‘get_topology’:
>    fdisk.c:456:18: warning: unused parameter ‘fd’ [-Wunused-parameter]
> 
>   there is get_geometry(cxt->fd, ...), but get_topology() ignores the
>   parameter 'fd' and the function uses the global cxt->fd. This is
>   nasty :-)
> 
>   It would be better to rename global 'cxt' to something less generic
>   and everywhere in functions use 'cxt' parameter, for example:
> 
>      get_geometry(struct fdisk_context *cxt, struct geom *g);

Yep, that's my plan.

> 
>     Karel
> 
