Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:22541 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754567Ab3BFLXt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 6 Feb 2013 06:23:49 -0500
Date: Wed, 6 Feb 2013 12:23:45 +0100
From: Karel Zak <kzak@redhat.com>
To: Alejandro Martinez Ruiz <alex@nowcomputing.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] libblkid: add Flash-Friendly File System (f2fs)
 support
Message-ID: <20130206112345.GA7212@x2.net.home>
References: <1360083607-29885-1-git-send-email-alex@nowcomputing.com>
 <1360083607-29885-2-git-send-email-alex@nowcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1360083607-29885-2-git-send-email-alex@nowcomputing.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 05, 2013 at 06:00:06PM +0100, Alejandro Martinez Ruiz wrote:
> +static int probe_f2fs(blkid_probe pr, const struct blkid_idmag *mag)
> +{
> +	struct f2fs_super_block *sb;
> +	uint16_t major, minor;
> +
> +	sb = blkid_probe_get_sb(pr, mag, struct f2fs_super_block);
> +	if (!sb)
> +		return -1;
> +
> +	major = le16_to_cpu(sb->major_ver);
> +	minor = le16_to_cpu(sb->minor_ver);
> +
> +	/* For version 1.0 we cannot know the correct sb structure */
> +	if (major == 1 && minor == 0)
> +		return 0;
> +
> +	if (*((unsigned char *) sb->volume_name))
> +		blkid_probe_set_utf8label(pr, (unsigned char *) sb->volume_name,
> +						sizeof(sb->volume_name),
> +						BLKID_ENC_UTF16LE);
> +
> +	blkid_probe_set_uuid(pr, sb->uuid);
> +	blkid_probe_sprintf_version(pr, "%u.%u", major, minor);

    return 0;

> +}

 Fixed, applied. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
