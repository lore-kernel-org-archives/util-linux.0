Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2FC4EB48
	for <util-linux@vger.kernel.org>; Fri, 24 Jan 2025 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737729448; cv=none; b=cPPn/coHvmXlFaiPBzDbYcXRr5ZMyeEVBFMrY9AlPvXK/9tbpA+7B50Xk9S4QiL3nJNJo5l44skYIliRRByWMXlkmZAwU8lZqKeqyveD5TDFiQUi5xozEbiZOt0hU9AvL7v0WTAhvAd9Ou6ejPOfkAe0uKF/Bk9Vmxcu+4IFkkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737729448; c=relaxed/simple;
	bh=NT+Ef7GOnrYT0wlP18sYhSXubutf9TA85EOXjE8pEKM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Bv7odHYAIM2oX8luI03EyrhFPgW3O6DZGunCBHz64vWY05D3iOUHYwDtBOnISqsv6YNJbsWJw+iLP0k8sOEHCY7w4ExsP9sjvZWn0GE0vOJAE0Nf3WleJH6jAnXgsUle870+XD5ZIlcT0dfbxH86JwH10dwXRlMnZNYCQoDfifw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PbdeyQpj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PbdeyQpj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737729445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WBNy967nCZN7n6LNJiiRG5q2pUY8pvuMqIpojjJ7cJo=;
	b=PbdeyQpj++tONM/aCvPo3Vf6iSdW9aLs+twWWFYhjn9+MIyorEUl4sYPgbEeJEeeTyu9ca
	MDnkT9JCiTj6DTF/eizOqD88jhHsrb0lT1WTg0aezDG5OE3bTMiWKGvqySoPyieNM/8VQM
	N55R3neogM8mTWBak9gcv+vz05cWDYw=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-G01hIzjbPW2cWNNTGZMA3w-1; Fri, 24 Jan 2025 09:37:16 -0500
X-MC-Unique: G01hIzjbPW2cWNNTGZMA3w-1
X-Mimecast-MFC-AGG-ID: G01hIzjbPW2cWNNTGZMA3w
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7e4bfae54so18800865ab.0
        for <util-linux@vger.kernel.org>; Fri, 24 Jan 2025 06:37:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737729433; x=1738334233;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WBNy967nCZN7n6LNJiiRG5q2pUY8pvuMqIpojjJ7cJo=;
        b=hidIY2iy0EDlXPP7qsgRd1onwCaqcA79r5u/lYw7EFagyyqFW84lgzEuxnFxLykZkN
         l5HiNIL+MQK7Gdpz/8Ev/c1qAWegSA+Ttv/eKzITXG8FFdSvdI+uoYjPqaNxNTOsA3+A
         Y2B9mM9n78OeVNfQIrrZ+8VPtrFnSHQoMxbEmm6zVzIdsAtGc1NPtuJk8AlNFqxQ7z/T
         oj9gA7tyjniq4qLbDL+B+1D7pF/r6HAtv7WNH75cQuejrUyDcu2LOKONpV1BNHfA6XB7
         8waXefyNSLah+WLz7zR4n7EPo814tFMn5IvqnCOax0b8u3NfJkEeue5OF5fsxLvajvAR
         a78Q==
X-Gm-Message-State: AOJu0YyVX8jLHM2Wh/7iH5EwG3rPmXt9GXkmh8DIJXZk3doxztB54xsP
	3l7i7gg3V+JOaN2eQpbQSRxU54g8SovSaYZsZ6u69aaJqdfgxCRC5sgfdGjFURK2XaJgArb1Paz
	vV9mvTTYLm+u/PoNf7RVAx4k4y6lYUxFLFvk1y1y2viQkNO6MssLmfD8Iuh0Zt+wVKekb1/Ct6i
	e0JjIVw+7xPXLcm4b+fOwQvyEiKVPZR5/KVX4iCRtRl3sGsjI=
X-Gm-Gg: ASbGncvqI/v78w/9/+4lvIXF6VsSACFJw6zhc0zYrLJ/LaRkDcmK7UFN0JDQc8ZRr4s
	mlXNZvKQCqg+9ykJbF66uUFgn5y1D51bHL2gII4AMpqr94CnRmvifi7SjhREuN8khSrZKqb2SLV
	RfQEvyTwDskQO+QXMizyLYxrZa888cHrCmSEEuZGyW+kYAKh2K3omP/wQpEiDZoajluYzBtby8W
	fLaHMtOrUJ6pm9YAEgd4aoNvUAEmJ3gaVIwm4bCukdBL8cuGvZgcCbVBhtCBr5ba1iDAW7j7Pv+
	elrVty+iWoUrbYtY/skPIe5ATxKiRnczDQ==
X-Received: by 2002:a92:ca45:0:b0:3ce:7cca:db24 with SMTP id e9e14a558f8ab-3cf7441aad1mr226007055ab.13.1737729433655;
        Fri, 24 Jan 2025 06:37:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESwvSbtBK+nUnicBJUqiSi/txq2fDtVxfzvDqeztyO48e/1/TlIUrYG3aFWRymtyEQAQ1jVw==
X-Received: by 2002:a92:ca45:0:b0:3ce:7cca:db24 with SMTP id e9e14a558f8ab-3cf7441aad1mr226006805ab.13.1737729433252;
        Fri, 24 Jan 2025 06:37:13 -0800 (PST)
Received: from [10.0.0.48] (97-116-180-154.mpls.qwest.net. [97.116.180.154])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec1db85509sm629111173.113.2025.01.24.06.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 06:37:12 -0800 (PST)
Message-ID: <e0eb2d1f-48fd-4d2b-b087-20a87b396218@redhat.com>
Date: Fri, 24 Jan 2025 08:37:12 -0600
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH V2] blkid: allow up to 64k erofs block sizes
From: Eric Sandeen <sandeen@redhat.com>
To: util-linux@vger.kernel.org
Cc: xiang@kernel.org, Karel Zak <kzak@redhat.com>
References: <71d43b45-9d53-48a1-8751-7080e50937e9@redhat.com>
Content-Language: en-US
In-Reply-To: <71d43b45-9d53-48a1-8751-7080e50937e9@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Today, mkfs.erofs defaults to page size for block size, but blkid
does not recognize this. Increase the limit to 64k.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

V2: Test for too-small blocksize, and simplify too-large blocksize
test.  (the prior > 31 || <shift test> was probably just avoiding
a shift overflow but there's really no reason, so just look directly
at blkszbits)

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
+	if (sb->blkszbits < 9 || sb->blkszbits > 16)
 		return BLKID_PROBE_NONE;
 
 	if (!erofs_verify_checksum(pr, mag, sb))

