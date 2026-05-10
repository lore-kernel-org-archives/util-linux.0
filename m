Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED5F64
	for <util-linux@vger.kernel.org>; Sun, 10 May 2026 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778422734; cv=none; b=RayhNMP87oRjuIiMDjKkniyiss/fUsTSjH4TpQLNlGSp3IwCUXCgGtYplVHj+86AWtqwaVepZ0qiV9U+WA0w9nUUs/q4U21LVr0x2dpelGKBQ7lmblAGY54lCgWdX/1yEqQgkNY1PY26v4jcRaJXyjzaoOJvwx0Jvpw1FfwDxyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778422734; c=relaxed/simple;
	bh=f9yczBz1ZZoJhFdBv+Bxyv9no/7NdwTg5o+BbZwFMFM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hl/bZtt0uCA5hxPR2x9duN/ZnwZHo3pp5WPI6MMLsTUKjFWRt7gCETjEczTOyoIulh50lQBjpc2yPdGHjER4lEqdBQr9v1fXeh3p5BN+UDNrWg6bgD7LT03RS6FW1CqlVsgMY/W+tpfuWKW+05toOvg2DhJNpFqdnPgIQSyhk94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGzBGPU+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGzBGPU+"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891b0786beso22867185e9.1
        for <util-linux@vger.kernel.org>; Sun, 10 May 2026 07:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778422732; x=1779027532; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e2ib6PFjqIHwJYL1F3+NOJlRNgIMpvUINO8S82Ad1lo=;
        b=BGzBGPU+uJdAl0wgHSujZlFsM33KAZqnOKSZHz9eZEMwKh8ugww6gqD48kVB/lbpPp
         11Jvz+7Io3Kyxt1oOaCKQyUMa5ruDGUxTS9rmXc0vcAc1d2zo25kQpxWLLHgsFN/9xNU
         Qe6GLPVn6Q5uCK/09C4FNPRn8uN0zyfcukj8wsCBJzVqN4un7+LO/ouCj9+D4rb42RpD
         QM9WhjoVsbEdMHkf2FV7KhJnQ0y0Uu5pS+DadYwIE+7D8FmPE4Ws4hHt5n/Kj8ccEyF7
         CKsD+JkDHEdxT5d/nQ/UzSF/OkMWA56ieIKJF7KIsbHbxIratKY5m31PQiOpVEvAhbLB
         4OKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778422732; x=1779027532;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e2ib6PFjqIHwJYL1F3+NOJlRNgIMpvUINO8S82Ad1lo=;
        b=i1CEtkpJh1sfaV8dsrMP6rC0xNLF0jQ7UnIZ6XfHrzHY0LPmmz38d/lQftxQB/EyMn
         0ux0G1Dno/QFkDW3rcS1JC/Rnr5hiTzD1netUHpK37kcbyEClKizRximqCPpLxTyknYS
         ci1r7bQ38p6ncfYMTH5BKFN9ZpAi0W+IETMEn9MFhC7DMtqMceOH3t3oOmK84ynBMTr7
         vCq2lEItmzzTAo47KH+zFY1041id77OGLvw5H4pDssCgMFixo5/dCaA/PJjBQj5zWqMe
         VqtI7m/zFhFfqTNjL6El7FjPvn4XuQvZOyClPpZ115xO/+w/k6tXoA0ScZt6tiIHPPAE
         Qyjg==
X-Gm-Message-State: AOJu0YxW4eE9pRnJtnePp00+/KVCVD69hV//Rv7be093YTyGcVKyz7Df
	+lc2cfuWOpCqm/XndDGgO93rhJeC74mTtS67awH3Qy3nr8NFttddy77XTt7eTQ==
X-Gm-Gg: Acq92OFPJDhdx7td2RC/swntz2LLynJENeW1N7hc6uZkhK52UpT0UTHGJXGzZLuh0sL
	sbEVBcwXSDggWQbpfBZCcRhYD+H7eBgQ3z8i4cxfWDCRmpimzyIcrijQCKyg5I7A9EmxV8Xik/V
	4aCznZQnrq6qlLGhtNX6YinJyUf/cMnxdhhcp+beoQGiJAZ92M6nuLH3hagSvtKMF2KLcS3Qwkb
	mpBqHIrJrhBGr+azVzRaBO2rfKcXK3lOJ26P0OM7Ln8zU26nzWRXy9edqjqddJV6Cws90G4f/fT
	7vX8N9tycTE8vEyf4Xn0ZBal5osSLxYt4VoFbd64My2Kvl454eL6fxwQWQs9nMiyXHNUgiiZxZu
	ntcPyIykoEQzV/BkdVsxXlbm+dVEALOCp/eztvjt/bUwnZsEkYj/EWjvynD5srqHzkihgY0ur5P
	hVhG9asg9k8krHcrTlYPuqCX5fsbX0QgGQcVbNmDz2
X-Received: by 2002:a05:600c:12d4:b0:488:9439:881a with SMTP id 5b1f17b1804b1-48e51e0bba9mr196076365e9.2.1778422731950;
        Sun, 10 May 2026 07:18:51 -0700 (PDT)
Received: from gmail.com ([2a02:587:5fa9:5400:83b7:c0de:eaf1:f398])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d8e4f0dsm44080255e9.11.2026.05.10.07.18.50
        for <util-linux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 07:18:51 -0700 (PDT)
Date: Sun, 10 May 2026 14:18:49 +0000
From: Eleftherios Kourmpalidis <lefteriskourbal@gmail.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] mount: (man) Fix grammar mistake on conv option
Message-ID: <agCTyY-3T0pB4S2m@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Signed-off-by: Eleftherios Kourmpalidis <lefteriskourbal@gmail.com>
---
 sys-utils/mount.8.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/mount.8.adoc b/sys-utils/mount.8.adoc
index 55f522750..44eb97f38 100644
--- a/sys-utils/mount.8.adoc
+++ b/sys-utils/mount.8.adoc
@@ -1102,7 +1102,7 @@ Set the umask (the bit mask of the permissions that are *not* present). The defa
 Convert all files names to lowercase, or leave them. (Default: *case=lower*.)
 
 **conv=**__mode__::
-This option is obsolete and may fail or being ignored.
+This option is obsolete and may fail or be ignored.
 
 *nocheck*::
 Do not abort mounting when certain consistency checks fail.
@@ -1140,7 +1140,7 @@ Also show hidden and associated files. (If the ordinary files and the associated
 Set the block size to the indicated value. (Default: *block=1024*.)
 
 **conv=**__mode__::
-This option is obsolete and may fail or being ignored.
+This option is obsolete and may fail or be ignored.
 
 *cruft*::
 If the high byte of the file length contains other garbage, set this mount option to ignore the high order bits of the file length. This implies that a file cannot be larger than 16 MB.
-- 
2.54.0
