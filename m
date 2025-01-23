Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973F117993
	for <util-linux@vger.kernel.org>; Thu, 23 Jan 2025 19:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737659837; cv=none; b=utUx32NCeVW5PA/rrlbOd8N4MNhJ83IVOC4nsQSPyBHFSSqd27AVIKalmQkpFQB8ro7+QQzTD4pfQR54TR3nj4t3zVHgUj1LXSXDZuMDzacoAxtgUXN/DeZTXCX06A4BvK6lTPBuCMzmSVyI8MvpCP3fYpjOJs52x5XWcmRKBjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737659837; c=relaxed/simple;
	bh=Laky1FJMU1E0zFK6+Wb0/SMtoggo5mI/sTNhtgLgz48=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Cu7T9GxyFbil6p5YbOkfPZmCMtLHWge1D6Acq6nXjdht76Vf7uJ4VTDXZGU9ezdf6KGjSofzhTCuUa59I9QNnLJY2TNCKuSZXkBeWJf1sTfeqPcdRWktBNRtdSC71m0cNl9fNJ++uCf6x7c5++RfTYtvuFL4jUwWJ3HZWZOja1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CjCauag1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjCauag1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737659834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ou4bhezzc22NYM6em0rMg7TUYPKVaHIVx/e4UFlyhII=;
	b=CjCauag16UAD24IVXvAxIUP+bDW+ISLUvUWBnjTU3nUnyL9fd18rmvF9tf4T+7TZ83bGZx
	aoOtmCt8z0YNwPEzJBIi6gLqZWVi2JSgUXUVE9w4+WJRIlEfiL6EydbTi5TPz8Ie804A59
	Vxs/vmJmIyFPQziqHEyn1l2LWJsjZA8=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-FxzMYhYBM42brnuRT6WTdQ-1; Thu, 23 Jan 2025 14:17:12 -0500
X-MC-Unique: FxzMYhYBM42brnuRT6WTdQ-1
X-Mimecast-MFC-AGG-ID: FxzMYhYBM42brnuRT6WTdQ
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ce51b2fcc6so21044045ab.1
        for <util-linux@vger.kernel.org>; Thu, 23 Jan 2025 11:17:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737659832; x=1738264632;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ou4bhezzc22NYM6em0rMg7TUYPKVaHIVx/e4UFlyhII=;
        b=pHbwJ1bE1Yu3u66UaVbnkI/qzQFIcULgOT5eLVO9XvE/tjNT9ghRaxselwU5h/73Tk
         tmZkwsQTcuRMwWBI4PRUMEWceDXjbIE1DSRcyOcSkKUGb5fXuMSRN8e4j4vWGD2r0O+a
         EuO50QkxSZTQ0lvTIiUlDjYRQgaxpSXSHNv5KQwKte54TZz82b6CgUQjDn56BtN36oKn
         Ikhc68m5tLVR8IB5M21qivxRGALS/uStTDiN5Vph8Xf85C+CERX2lZY5NWVR3VWMGUQU
         txGCtHsl6O5TX3ghdpd1I0qeTDKib2pvTDOMeMoMw626L8Qeep5QgztygqsGThJQqBi5
         7+SQ==
X-Gm-Message-State: AOJu0YwSY81JsW/9G3Q85PoJ8HJI/LPOyHnV/ryqVNNo4ajbloZxVXaF
	Y3alk8EHjgHOt+JnHut2Y+Lc+7YOBSFE/C1wJNZDK/zTOhHWWKhvJsclu5tU50NkAXJCgTnZRUa
	kHy/nZ3c2rP4tewqraEcS5kWAZRL4BZ0ZkHkNDhgVG83BvfALWA/DeYmPhqRmRB1VZrfXLyWD3z
	6z48FEwwRwaNbEs4Nwf2qeY5uq+wFC3gcJ0CFyjZrOwu+Bps4=
X-Gm-Gg: ASbGncsCiINKRMpIi0xz4JcO635OUI0cWOYXwAIPgYNWn5WrYd9B6SICXBM/dn5Rpaw
	4acdBvUWDXOorq1VHTsQA580m00N5FIusTVJaT/6jRrwWNLYABFpya0Voe/oul6jv7YKix4srEp
	9EdCw0s+YzQcD3yJbwaJT5/hNFn58Cn005RJtCFBqBvu/geDk7GeknOoxUVcZ6gP0rBirF2apVv
	R5Nz5IZfrB/tUnE8PRovilBI8fGCv/5uZS3Mhkbrxv4BV7gGUfKxfUtd92oHySQjQV4N6f2QiuN
	Bnu2PJPi4/2xhUVZ3ka75TU9K309m+savg==
X-Received: by 2002:a05:6e02:368f:b0:3cf:c743:3754 with SMTP id e9e14a558f8ab-3cfc743385amr7009165ab.14.1737659832018;
        Thu, 23 Jan 2025 11:17:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRL6jP12uNWukI/6NyqRdq4JHL1pvCP7PA4mAGB6clM0F8KMWlxfG1fEIjvXAJctS5XAjXNA==
X-Received: by 2002:a05:6e02:368f:b0:3cf:c743:3754 with SMTP id e9e14a558f8ab-3cfc743385amr7009005ab.14.1737659831654;
        Thu, 23 Jan 2025 11:17:11 -0800 (PST)
Received: from [10.0.0.48] (97-116-180-154.mpls.qwest.net. [97.116.180.154])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3cfc74337a1sm1214455ab.19.2025.01.23.11.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 11:17:11 -0800 (PST)
Message-ID: <71d43b45-9d53-48a1-8751-7080e50937e9@redhat.com>
Date: Thu, 23 Jan 2025 13:17:10 -0600
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: util-linux@vger.kernel.org
Cc: xiang@kernel.org, Karel Zak <kzak@redhat.com>
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] blkid: allow up to 64k erofs block sizes
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Today, mkfs.erofs defaults to page size for block size, but blkid
does not recognize this. Increase the limit to 64k.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

(There might be strange arches out there > 64k but I don't know if
erofs really works with blocks that big, so for now let's just
limit it to 64k?)

diff --git a/libblkid/src/superblocks/erofs.c b/libblkid/src/superblocks/erofs.c
index 05822460b..89620db47 100644
--- a/libblkid/src/superblocks/erofs.c
+++ b/libblkid/src/superblocks/erofs.c
@@ -73,8 +73,8 @@ static int probe_erofs(blkid_probe pr, const struct blkid_idmag *mag)
 	if (!sb)
 		return errno ? -errno : BLKID_PROBE_NONE;
 
-	/* EROFS is restricted to 4KiB block size */
-	if (sb->blkszbits > 31 || (1U << sb->blkszbits) > 4096)
+	/* block size must be between 512 and 64k */
+	if (sb->blkszbits > 31 || (1U << sb->blkszbits) > 65536)
 		return BLKID_PROBE_NONE;
 
 	if (!erofs_verify_checksum(pr, mag, sb))

