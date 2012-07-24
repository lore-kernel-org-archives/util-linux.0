Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:24961 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753239Ab2GXLgC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Jul 2012 07:36:02 -0400
Date: Tue, 24 Jul 2012 13:35:57 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 03/10] fdisk: API: add fdisk_label_change
Message-ID: <20120724113557.GC7057@x2.net.home>
References: <1342976704.2863.13.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342976704.2863.13.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jul 22, 2012 at 07:05:04PM +0200, Davidlohr Bueso wrote:
>  5 files changed, 43 insertions(+), 0 deletions(-)

 Not applied, it seems unnecessary.

 I have temporary added fdisk_create_default_disklabel, but the final
 code (the current master) contains your fdisk_create_disklabel()
 where NULL name means a default disk label.

 I have renamed many functions :-) It seems better to use

   fdisk_create_disklabel()   than  fdisk_label_create()
   fdisk_add_partition()      than  fdisk_label_partition_new()

.. etc.

> +	/* not really changing the label */
> +	if (!strncmp(name, cxt->label->name, strlen(name)))
> +		goto done;

 BTW, I don't see a problem with strings -- very probably we will use
 strings in user interface, and add extra layer to translate strings
 to IDs seems like unnecessary optimization and complexity.

> +	for (i = 0; i < ARRAY_SIZE(labels); i++) {
> +		if (strncmp(name, labels[i]->name, strlen(name)))
> +			continue;
> +	
> +		/* found the new label */
> +		memset(cxt->label, 0, sizeof(struct fdisk_label));
> +		memcpy(cxt->label, labels[i], sizeof(struct fdisk_label));
> +		DBG(LABEL, dbgprint("changing to a %s label\n", labels[i]->name));
> +		goto done;
> +	}

 Oh no, let's use labels[] as constant array and cxt->label as
 const struct pointer. The list of functions does not have to
 be modifiable, and

    cxt->label = labels[i];

 is definitely better than memcpy().

 Note that it's will probably necessary to add

    void *labeldata;

 to fdisk_context for label private data. (For example to kill
 MBRbuffer_changed or another DOS specific global variables.)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
