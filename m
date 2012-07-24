Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcagg.dreamhost.com ([208.97.132.66]:43351 "EHLO
	homiemail-a60.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752089Ab2GXKlx (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Jul 2012 06:41:53 -0400
Subject: Re: [PATCH 03/10] fdisk: API: add fdisk_label_change
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
In-Reply-To: <20120724095254.GC2086@foxbat.suse.cz>
References: <1342976704.2863.13.camel@offbook>
	 <20120724095254.GC2086@foxbat.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 24 Jul 2012 12:41:50 +0200
Message-ID: <1343126510.2686.7.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, 2012-07-24 at 11:52 +0200, Petr Uzel wrote:
> On Sun, Jul 22, 2012 at 07:05:04PM +0200, Davidlohr Bueso wrote:
> > From: Davidlohr Bueso <dave@gnu.org>
> > 
> > A new fdisk_label_change() function is added for situations when the disk label is
> > changed (ie: creating a new sun label). This function only updates the label pointer
> > in the context to use the newly specified label type.
> 
> Why can't we just call __probe_labels() after creating new label, e.g.
> in soon-to-be introduced fdisk_label_create()?

Because this way we give users extra functionality in the API. There
should be a way of changing label types on the fly, and since we don't
export __probe_labels(), this is the other option.

Thanks,
Davidlohr

> 
> > 
> > Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> > ---
> >  fdisks/fdisk.h         |    2 ++
> >  fdisks/fdiskdoslabel.c |    1 +
> >  fdisks/fdisksgilabel.c |    2 ++
> >  fdisks/fdisksunlabel.c |    1 +
> >  fdisks/utils.c         |   37 +++++++++++++++++++++++++++++++++++++
> >  5 files changed, 43 insertions(+), 0 deletions(-)
> > 
> > diff --git a/fdisks/fdisk.h b/fdisks/fdisk.h
> > index d716824..d7e85f5 100644
> > --- a/fdisks/fdisk.h
> > +++ b/fdisks/fdisk.h
> > @@ -104,6 +104,7 @@ enum fdisk_error {
> >  	FDISK_ERROR_WRITE,
> >  	FDISK_ERROR_IOCTL,
> >  	FDISK_ERROR_PROBE,
> > +	FDISK_ERROR_NOLABEL,
> >  	FDISK_ERROR_UNKNOWN
> >  };
> >  
> > @@ -164,6 +165,7 @@ extern void fdisk_mbr_zeroize(struct fdisk_context *cxt);
> >  extern void fdisk_geom_set_cyls(struct fdisk_context *cxt);
> >  extern const char *fdisk_error_name(enum fdisk_error errcode);
> >  extern void fdisk_error_fatal(struct fdisk_context *cxt, enum fdisk_error errcode);
> > +extern int fdisk_label_change(struct fdisk_context *cxt, const char *name);
> >  
> >  /* prototypes for fdisk.c */
> >  extern char *disk_device, *line_ptr;
> > diff --git a/fdisks/fdiskdoslabel.c b/fdisks/fdiskdoslabel.c
> > index 535afdc..9b9b23a 100644
> > --- a/fdisks/fdiskdoslabel.c
> > +++ b/fdisks/fdiskdoslabel.c
> > @@ -230,6 +230,7 @@ void create_doslabel(struct fdisk_context *cxt)
> >  
> >  	dos_init(cxt);
> >  	fdisk_mbr_zeroize(cxt);
> > +	fdisk_label_change(cxt, "dos");
> >  	set_all_unchanged();
> >  	set_changed(0);
> >  
> > diff --git a/fdisks/fdisksgilabel.c b/fdisks/fdisksgilabel.c
> > index e38d98f..6001038 100644
> > --- a/fdisks/fdisksgilabel.c
> > +++ b/fdisks/fdisksgilabel.c
> > @@ -780,6 +780,8 @@ create_sgilabel(struct fdisk_context *cxt)
> >  		}
> >  
> >  	fdisk_mbr_zeroize(cxt);
> > +	fdisk_label_change(cxt, "sgi");
> > +
> >  	sgilabel->magic = SSWAP32(SGI_LABEL_MAGIC);
> >  	sgilabel->boot_part = SSWAP16(0);
> >  	sgilabel->swap_part = SSWAP16(1);
> > diff --git a/fdisks/fdisksunlabel.c b/fdisks/fdisksunlabel.c
> > index 4123806..b63335c 100644
> > --- a/fdisks/fdisksunlabel.c
> > +++ b/fdisks/fdisksunlabel.c
> > @@ -161,6 +161,7 @@ void create_sunlabel(struct fdisk_context *cxt)
> >  
> >  	init();
> >  	fdisk_mbr_zeroize(cxt);
> > +	fdisk_label_change(cxt, "sun");
> >  
> >  	sunlabel->magic = SSWAP16(SUN_LABEL_MAGIC);
> >  	sunlabel->sanity = SSWAP32(SUN_LABEL_SANE);
> > diff --git a/fdisks/utils.c b/fdisks/utils.c
> > index cf9484c..48dedfb 100644
> > --- a/fdisks/utils.c
> > +++ b/fdisks/utils.c
> > @@ -44,6 +44,43 @@ static const struct fdisk_label *labels[] =
> >  	&mac_label,
> >  };
> >  
> > +/**
> > + * fdisk_label_change:
> > + * @cxt: fdisk context
> > + * @name: new label name
> > + *
> > + * Updates the disk label type to the one specified by @name.
> > + *
> > + * Returns 0 on success, otherwise, a corresponding error.
> > + */
> > +int fdisk_label_change(struct fdisk_context *cxt, const char *name)
> > +{
> > +	int i;
> > +
> > +	if (!cxt || !cxt->label || !name)
> > +		return FDISK_ERROR_UNKNOWN;
> > +
> > +	/* not really changing the label */
> > +	if (!strncmp(name, cxt->label->name, strlen(name)))
> > +		goto done;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(labels); i++) {
> > +		if (strncmp(name, labels[i]->name, strlen(name)))
> > +			continue;
> > +	
> > +		/* found the new label */
> > +		memset(cxt->label, 0, sizeof(struct fdisk_label));
> > +		memcpy(cxt->label, labels[i], sizeof(struct fdisk_label));
> > +		DBG(LABEL, dbgprint("changing to a %s label\n", labels[i]->name));
> > +		goto done;
> > +	}
> > +
> > +	/* couldn't find the requested label type */
> > +	return FDISK_ERROR_NOLABEL;
> > +done:
> > +	return 0;
> > +}
> > +
> >  static int __probe_labels(struct fdisk_context *cxt)
> >  {
> >  	int i, rc = 0;
> > -- 
> > 1.7.4.1
> > 
> > 
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe util-linux" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> Petr
> 


