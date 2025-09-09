Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1953A30595F
	for <util-linux@vger.kernel.org>; Tue,  9 Sep 2025 10:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757414907; cv=none; b=N8Wmi97+n6cbSz6SIm3+puizbMkBOxtGH4rWgl2+5rsmEhTAFM6hqEWlqBnA/1jlTuOsP0c4O4Ru4vRj1gfahPgImtny/ISzU9G1rN4VmWP3mHzRwoUUr1wbMTM8KfEyuIM/FZ7q5TVDxC3DzPpsKVEwpzFKVk6eWJrbiudcs0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757414907; c=relaxed/simple;
	bh=HP9yIYuNkembouhtXwIIHIjiEM0WTh9sWw+tzGTYfjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNmp0bk4hYIuVHteWAq2yuM4FIHLnP8RyZKb8FCVzwFfcgRGx1/s2Q0PZ6Gi3tg87KOHjqyVjnONstgvt8vxqHDQ+y24mSAEqiursSfcCucaPfd5LxsR6uSPjzmkCWVYs0KWLcYrSWSsnFZrEX3yVUmLA3N56sBnB98xyO288hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FAT4znwx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAT4znwx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757414905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qOHATRTly7UsN+0YSyWS7rcpK0n0Uj7REEfm2O6xACo=;
	b=FAT4znwxPEZiyImR+hV0CnGg2ibjueDGJE7SkX5oow4OUKsBlR2GnPXnJk9Z3T7jK96++b
	aW5gR9P3bcRZTIkZcExuJ2FTaBRql30iUPvjfbpNv2lJySUonj7mXocxh7mlVNcVp6wBeX
	6Z82vFGVNpiOC46VO7IlxL87fh6U38s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-THuQAP6UOzaVtCIjGqLg_g-1; Tue,
 09 Sep 2025 06:48:21 -0400
X-MC-Unique: THuQAP6UOzaVtCIjGqLg_g-1
X-Mimecast-MFC-AGG-ID: THuQAP6UOzaVtCIjGqLg_g_1757414900
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0EEE21800451;
	Tue,  9 Sep 2025 10:48:20 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.53])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD1BB1800446;
	Tue,  9 Sep 2025 10:48:18 +0000 (UTC)
Date: Tue, 9 Sep 2025 12:48:15 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org, 
	Mario =?utf-8?Q?Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Subject: Re: [PATCH] sfdisk: (man) do not use the common 'include' for --help
 and --version
Message-ID: <ummxyo4yd5djychbmh3ctrlmbg2leaf3xz2curz4bxy4frow5b@xlmxm2vswour>
References: <20250909085609.5049-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250909085609.5049-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Sep 09, 2025 at 10:56:09AM +0200, Benno Schulenberg wrote:
> Anomalously, `sfdisk` uses -v for --version instead of the standard
> uppercase -V.  In `sfdisk` -V means --verify.
> 
> This reverts commit 82d0bfe59a from last week.
> 
> CC: Mario Blättermann <mario.blaettermann@gmail.com>
> Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
> ---
>  disk-utils/sfdisk.8.adoc | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/disk-utils/sfdisk.8.adoc b/disk-utils/sfdisk.8.adoc
> index 01bcfbfff..99849a638 100644
> --- a/disk-utils/sfdisk.8.adoc
> +++ b/disk-utils/sfdisk.8.adoc
> @@ -239,7 +239,11 @@ Wipe filesystem, RAID and partition-table signatures from the device, in order t
>  *-W*, *--wipe-partitions* _when_::
>  Wipe filesystem, RAID and partition-table signatures from a newly created partition, in order to avoid possible collisions. The argument _when_ can be *auto*, *never* or *always*. When this option is not given, the default is *auto*, in which case signatures are wiped only when in interactive mode and after confirmation by user. In all cases detected signatures are reported by warning messages after a new partition is created. See also *wipefs*(8) command.
>  
> -include::man-common/help-version.adoc[]

It would be helpful to add a comment there to prevent this mistake in
the future, such as:

// Do not use man-common/help-version.adoc; -V is incompatible.

> +*-h*, *--help*::
> +Display help text and exit.
> +
> +*-v*, *--version*::
> +Display version and exit.

Benno, can you update the patch? Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

