Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33739 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753124AbbEGKBy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 7 May 2015 06:01:54 -0400
Date: Thu, 7 May 2015 12:01:47 +0200
From: Karel Zak <kzak@redhat.com>
To: "Jean-Loup 'clippix' Bogalho" <clippix@lse.epita.fr>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2] fdisk: add the 'i'nfo command
Message-ID: <20150507100147.GI27969@ws.net.home>
References: <20150506142143.GA27359@clippix.lab.lse.epita.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150506142143.GA27359@clippix.lab.lse.epita.fr>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, May 06, 2015 at 04:21:43PM +0200, Jean-Loup 'clippix' Bogalho wrote:
> +#define NB_INFO_FIELDS	6

This is bad manner (as it makes code fragile), the better solution is:

    int foo[] = { 10, 9, 8 };

and then

    for (i = 0; i < ARRAY_SIZE(foo); i++) {
       ...
    }

> +int print_partition_infos(struct fdisk_context *cxt)
> +{
> +	struct fdisk_partition *pa = NULL;
> +	char *data = NULL;
> +	int rc = 0;
> +	size_t i;
> +	static int info_ids[NB_INFO_FIELDS] = {
> +		FDISK_FIELD_NAME, FDISK_FIELD_START, FDISK_FIELD_SIZE,
> +		FDISK_FIELD_UUID, FDISK_FIELD_TYPE, FDISK_FIELD_CYLINDERS
> +	};

 FDISK_FIELD_CYLINDERS means size in cylinders, IMHO it's unnecessary

 FDISK_FIELD_SADDR is start address and FDISK_FIELD_EADDR is end
 address in CHS notation

 Anyway, you don't have to hardcode the IDs, see function

   fdisk_label_get_fields_ids()

 it returns (allocated) array with the IDs, you need something like:

   size_t nfields;
   int *fields = NULL;
   int details;
   struct fdisk_label *lb = fdisk_get_label(cxt);

   details = fdisk_is_details(cxt);
   fdisk_enable_details(cxt, 1);
   fdisk_label_get_fields_ids(lb, cxt, &fields, &nfields);
   fdisk_enable_details(cxt, details);

 for more see code in disk-utils/fdisk-list.c

> +	static char *fields[NB_INFO_FIELDS] = {
> +		"name", "start", "size", "uuid", "type", "C/H/S"
> +	};

 This is unnecessary, libfdisk already contains the names of the
 fields. See below.

> +
> +	if ((rc = fdisk_ask_partnum(cxt, &i, FALSE)))
> +		return rc;
> +
> +	if ((rc = fdisk_get_partition(cxt, i, &pa))) {
> +		fdisk_warnx(cxt, _("Partition %zu does not exist yet!"), i + 1);
> +		return rc;
> +	}
> +	for (i = 0; i < NB_INFO_FIELDS - 1; ++i) {

        int id = info_ids[i];
        struct fdisk_field *field = fdisk_label_get_field(lb, id);

        if (!field)
            continue;   /* not supported by the current label */

> +		rc = fdisk_partition_to_string(pa, cxt, info_ids[i], &data);
> +		if (rc < 0)
> +			goto clean_data;
> +		fdisk_info(cxt, _("%s:\t%s"), fields[i], data);

        fdisk_info(cxt, "%15s: %s\n", fdisk_field_get_name(fd), data);

> +		free(data);
> +	}
> +	if ((rc = fdisk_partition_to_string(pa, cxt, info_ids[i], &data)) < 0)
> +		goto clean_data;
> +	fdisk_info(cxt, _("%s:\t%s/%d/%s"), fields[i], data, 1, data);

 _SADDR and _EADDR returns complete CHS, you don't have to compose it here.

 The stuff in the for() should be enough.

> +
> +clean_data:
> +	fdisk_unref_partition(pa);
> +	free(data);
> +	return rc;
> +}

 Thanks, the next version will be perfect :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
