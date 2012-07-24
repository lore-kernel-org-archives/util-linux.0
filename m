Return-Path: mail@bernhard-voelker.de
Message-ID: <500E6F49.60406@bernhard-voelker.de>
Date: Tue, 24 Jul 2012 11:47:53 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: dave@gnu.org
CC: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 03/10] fdisk: API: add fdisk_label_change
References: <1342976704.2863.13.camel@offbook>
In-Reply-To: <1342976704.2863.13.camel@offbook>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>



On 07/22/2012 07:05 PM, Davidlohr Bueso wrote:
> --- a/fdisks/fdisksunlabel.c
> +++ b/fdisks/fdisksunlabel.c
> @@ -161,6 +161,7 @@ void create_sunlabel(struct fdisk_context *cxt)
>  
>  	init();
>  	fdisk_mbr_zeroize(cxt);
> +	fdisk_label_change(cxt, "sun");
>  

...

> +int fdisk_label_change(struct fdisk_context *cxt, const char *name)
> +{
> +	int i;
> +
> +	if (!cxt || !cxt->label || !name)
> +		return FDISK_ERROR_UNKNOWN;
> +
> +	/* not really changing the label */
> +	if (!strncmp(name, cxt->label->name, strlen(name)))
> +		goto done;
> +
> +	for (i = 0; i < ARRAY_SIZE(labels); i++) {
> +		if (strncmp(name, labels[i]->name, strlen(name)))
> +			continue;

Shouldn't we use something else than hardcoded "sun"|"dos"|"sgi"|...
strings here? (See also "[PATCH 08/10] fdisk: API: add create disklabel
to label operations".)

Have a nice day,
Berny
