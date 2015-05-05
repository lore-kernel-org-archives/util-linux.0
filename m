Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34461 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965617AbbEEIfj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 5 May 2015 04:35:39 -0400
Date: Tue, 5 May 2015 10:35:33 +0200
From: Karel Zak <kzak@redhat.com>
To: "Jean-Loup 'clippix' Bogalho" <clippix@lse.epita.fr>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v1] fdisk: add the 'i'nfo command
Message-ID: <20150505083533.GB27969@ws.net.home>
References: <20150505070218.GA15800@clippix.lab.lse.epita.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150505070218.GA15800@clippix.lab.lse.epita.fr>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 05, 2015 at 09:02:19AM +0200, Jean-Loup 'clippix' Bogalho wrote:
> diff --git a/libfdisk/src/libfdisk.h.in b/libfdisk/src/libfdisk.h.in
> index 5f75ecd..26150e2 100644
> --- a/libfdisk/src/libfdisk.h.in
> +++ b/libfdisk/src/libfdisk.h.in
> @@ -378,6 +378,9 @@ extern int fdisk_partition_is_wholedisk(struct fdisk_partition *pa);
>  extern int fdisk_partition_to_string(struct fdisk_partition *pa,
>  				     struct fdisk_context *cxt,
>  				     int id, char **data);
> +extern int fdisk_get_partition_infos(struct fdisk_context *cxt,
> +				     struct fdisk_partition *pa,
> +				     char **data);

I don't think this belongs to libifdisk.

> +int fdisk_get_partition_infos(
> +			struct fdisk_context *cxt,
> +			struct fdisk_partition *pa,
> +			char **data)
> +{
> +	size_t i;
> +	char *p = NULL;
> +	int rc = 0;
> +	static int info_ids[NB_INFO_FIELDS] = {
> +		FDISK_FIELD_START, FDISK_FIELD_SIZE, FDISK_FIELD_NAME,
> +		FDISK_FIELD_UUID, FDISK_FIELD_TYPE, FDISK_FIELD_CYLINDERS,
> +		FDISK_FIELD_SECTORS
> +	};
> +	char *infos[NB_INFO_FIELDS] = {
> +		NULL
> +	};
> +
> +	if (!pa || !cxt || !data)
> +		return -EINVAL;
> +
> +	for (i = 0; i < NB_INFO_FIELDS; ++i) {
> +		rc = fdisk_partition_to_string(pa, cxt, info_ids[i], infos + i);
> +
> +		if (rc < 0)
> +			goto clean_infos;
> +		if (!infos[i])
> +			infos[i] = strdup("N/A");
> +	}
> +
> +	rc = asprintf(&p, "name: \t%s\nstart: \t%s\nsize: \t%s\nuuid: \t%s\n"
> +		      "type: \t%s\nC/H/S: \t%s/%s/%s", infos[2], infos[0],
> +		      infos[1], infos[3], infos[4], infos[5], "1", infos[6]);

 It would be better to avoid any output formatting in the library.
 This is why we have a generic fdisk_partition_to_string() function. 

 All you need is to move code from fdisk_get_partition_infos() to
 print_partition_infos() -- you can also avoid asprintf(), just use
 fdisk_info() to print non-NULL results after  fdisk_partition_to_string().

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
