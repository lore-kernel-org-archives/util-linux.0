Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35950 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964806Ab3BNNYT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Feb 2013 08:24:19 -0500
Date: Thu, 14 Feb 2013 14:24:15 +0100
From: Karel Zak <kzak@redhat.com>
To: "Zeeshan Ali (Khattak)" <zeeshanak@gnome.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] libblkid: Expose more ISO9660 headers
Message-ID: <20130214132415.GB19379@x2.net.home>
References: <1360617732-4770-1-git-send-email-zeeshanak@gnome.org>
 <1360617732-4770-2-git-send-email-zeeshanak@gnome.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1360617732-4770-2-git-send-email-zeeshanak@gnome.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 11, 2013 at 11:22:12PM +0200, Zeeshan Ali (Khattak) wrote:
>  libblkid/src/superblocks/iso9660.c     | 112 +++++++++++++++++++++++++++++++--
>  libblkid/src/superblocks/superblocks.c |  40 ++++++++++++
>  libblkid/src/superblocks/superblocks.h |   5 +-
>  3 files changed, 151 insertions(+), 6 deletions(-)

 Applied.

> +#define strstrip(string, len) strchomp(strchug(string, len), len)

 I have removed this code, we already have blkid_rtrim_whitespace() so
 it seems better to add blkid_ltrim_whitespace() and use it together.

> +static char *
> +strchug (char *string, size_t len)
> +{
> +	size_t i;
> +
> +	for (i = 0;  i < len && isspace(string[i]); i++);
> +
> +	memmove (string, string + i, len - i);
> +
> +	return string;
> +}
> +
> +static char *
> +strchomp (char *string, size_t len)
> +{
> +	size_t i = len;
> +	while (i--) {
> +		if (isspace((unsigned char) string[i]))
> +			string[i] = '\0';
> +		else
> +			break;
> +}

 BTW, I didn't test it, but it seems that strstrip code will not work as expected
 for input like

    "    ABC "
 
 the result will be very probably

    "ABC ABC\0"

> +   if (! is_str_empty(iso->system_id, sizeof(iso->system_id))) {
> +		unsigned char system_id[32];
> +
> +		memcpy(system_id, iso->system_id, sizeof(system_id));
> +		strstrip(system_id, sizeof(system_id));
> +		blkid_probe_set_system_id(pr, system_id, sizeof(system_id));
> +	}

 the another change to the patch -- it seems better to add
 blkid_probe_set_id_label() and use for all the _IDs. Note that we
 have to terminate the labels by \0.

> +	/* Joliet Extension and Boot Record */
>  	off = ISO_VD_OFFSET;
>  	for (i = 0; i < ISO_VD_MAX; i++) {
> -		iso = (struct iso_volume_descriptor *)
> +		struct boot_record *boot= (struct boot_record *)
>  			blkid_probe_get_buffer(pr,
>  					off,
> -					sizeof(struct iso_volume_descriptor));
> +					sizeof(struct boot_record));

 This is bug, size of struct boot_record is smaller than the size of
 iso_volume_descriptor, so then you can not cast:

> +		/* Not a Boot record, lets see if its supplemntary volume descriptor */
> +		iso = (struct iso_volume_descriptor *) boot;

 ;-)

 Note that "blkid <image>" without -p uses high-level libblkid cache.
 For udev we always bypass the cache and the _ID stuff should not be
 stored in the cache. I have fixed this issue, you have to use -p to
 see your new IDs.

 Thanks, it's definitely good step to use libblkid and udev for the
 ISO stuff.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
