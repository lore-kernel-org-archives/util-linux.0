Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB4A78B73
	for <util-linux@vger.kernel.org>; Mon,  4 Mar 2024 19:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709580105; cv=none; b=gbu/zm8z4P867nASO/hK1cXgGLjWo/QGT9uohrNjgdjbsJQR70udt0Sw17Hg674CjroWs6YZWP0qqgM1CJEwoPfjhihVsMMNsjhSAdUgg7Jmhetv3iFeHl4NeqabTTCMqF7K7caghb4w1BzPaw23+ScalTV1dGTVMzuauDNTtOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709580105; c=relaxed/simple;
	bh=Vco9JHgKOIDzkNQiHsup2pzqBKb8JAfAVAvhQQpl2Uw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=sStISEH0eYY0yfTcdf3uUK5n9K7puETDB4OotZUlnwdhqifMKBzEUB7IRwc983Y/bo79Ipn6OBLhjSGGSQSb7Dzmirevr+AxvGcDit2pEMzwM+SFJah7b/k2dVm9s5GC9Lelc+xR4Wiq6NCH81krO0zGWacjEQwdZpKq37HvzqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/bA226A; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/bA226A"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1dccb2edc6dso40292605ad.3
        for <util-linux@vger.kernel.org>; Mon, 04 Mar 2024 11:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709580103; x=1710184903; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gV/49vakxf6v/AtIR1q1lFNdg0yOEVeyZr9gQ0uwhqM=;
        b=k/bA226AyznUekyeqA3neWgUVzLlwpUl2aCZ9ZQGepFJKR31IjAiBPe+9MUvyAbEag
         6k0fmR/Ysx2UOnkKvs4l0OMpKoyRC4pj1NG9Q3AdajF4hV1Z9apMVnP1FZNoRFYz6Vek
         tFffXqRyyjySfnPwDBeh36QwL0quGExqlTyRsIVmpt3nmy0QWl2pTACHg4NRKjDHiCll
         OtTmC0+d89NEEIF3cY/w2NZKuK/ahD+YiT391SBKoFwq8rM6OQCU1UBe8eME8ZZcgpo/
         G4c7sM95D6qYebPD3CXGh5mH3aACghrkmkkD2vHF9gJyGIpkWbvjTSzye15Tti3XQd5o
         N8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709580103; x=1710184903;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gV/49vakxf6v/AtIR1q1lFNdg0yOEVeyZr9gQ0uwhqM=;
        b=IXMUukdS59szrf9x0FV/coUDsHgS1sQIwglLe/3Z1L1zbKT6fsP14HjZvkBNOu28Le
         2Kjb6sH8p9l2cNjHFe/E0YoaTkm2GV2ucgTXQW8IDqAihg3e+vWa+oJetL1+qhyS/SHr
         UnopR3mJgyObIbC2SEAxlpt5oAUpJ/u0VMxggGJsWPqlfW4f8eBcB91mvbeKH0On4c6Q
         3Gf9IyWiB7r87xaZAY8wd59jw48/A9b9T1Kr0JefxyshZi/UoNiIZOeU+KzQy+8LqDRo
         GUoeCJI0yfgTL2L7S03caD9CEXCIEoTj7rXqjtuXKGx7WAj3C5oYVWzsGZhbuMaEv996
         ppIw==
X-Gm-Message-State: AOJu0YxioTNNghzAO4PpkhY1W3dCIeLLVRdP4AybjfX1X1OVG4LskVue
	Tf0CrwnSXPuAR1LzBkgTRZKgCbN0tV7Kudlgfh4qqeSDIAryIlPhYoypvZepgbM/ZQ==
X-Google-Smtp-Source: AGHT+IEwNTimIcrtMms2XQ/N1F5ij4iwnsPruyb8RQtoMBbCJSiaGymJxmgrfDtnsv1cr0MDV4EvAQ==
X-Received: by 2002:a17:902:f54a:b0:1dc:af71:29fc with SMTP id h10-20020a170902f54a00b001dcaf7129fcmr12630627plf.6.1709580103202;
        Mon, 04 Mar 2024 11:21:43 -0800 (PST)
Received: from ?IPV6:2405:201:4016:3f:8564:1b5:c24:d41c? ([2405:201:4016:3f:8564:1b5:c24:d41c])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902c3c500b001d71729ec9csm8904564plj.188.2024.03.04.11.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 11:21:42 -0800 (PST)
Message-ID: <479fd0b8-bf67-4370-8250-bfd136a08195@gmail.com>
Date: Tue, 5 Mar 2024 00:51:41 +0530
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: util-linux@vger.kernel.org
From: Tanish Yadav <devtany@gmail.com>
Subject: [PATCH] su: fix use after free in run_shell
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Do not free tmp for non login branch as basename may return a pointer to
some part of it.

Signed-off-by: Tanish Yadav <devtany@gmail.com>
---
  login-utils/su-common.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/login-utils/su-common.c b/login-utils/su-common.c
index 242b6ce4e..8cb54e1c1 100644
--- a/login-utils/su-common.c
+++ b/login-utils/su-common.c
@@ -851,10 +851,10 @@ static void run_shell(
		arg0[0] = '-';
		strcpy(arg0 + 1, shell_basename);
		args[0] = arg0;
+		free(tmp);
	} else {
-    args[0] = basename(tmp);
-  }
-  free(tmp);
+		args[0] = basename(tmp);
+	}

	if (su->fast_startup)
		args[argno++] = "-f";
--
2.44.0

