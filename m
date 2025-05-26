Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FA11F09A1
	for <util-linux@vger.kernel.org>; Mon, 26 May 2025 09:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748252314; cv=none; b=Dx2UU0ZPUbxznEoP1+8w19QDVq2vHr7F5HZeASuJR97SIkMF33qcRTmaYYhVRzgQA2UmWAzRo6SI+rN3YYK1vmlixGDQ4/OGzPiO5W2h8+eN/fBqzn0kDE8T8iPXc5qGHPpMSM63MjRoo4NtcrS0c4dscZs3IiPLIjWEeDB5wwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748252314; c=relaxed/simple;
	bh=EOzQGVPFZ6icnnqSdLEQqDGAl56OqVEkKBD0LEMAYyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Aqu5ud3V04uaTSTx/N5xl5mlVLbbjaV0Mh9JNfFcD+WsmHf62nBJIvptvlytXPuI+Cp/9YM940+AuCrPndfYK4hptBOxwogOpm7915OF8PQu+ppiiUkm2Gi/q1HA6cNgsIXXaWwfvQpGYp54juK0VogtzLFRzdFwMmaBrzDHs14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OGW6u5Aq; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OGW6u5Aq"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b2c377d8982so469809a12.3
        for <util-linux@vger.kernel.org>; Mon, 26 May 2025 02:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748252311; x=1748857111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d20ogDY48KWL7MgG2HWAVRtGf3dYt1vl/Riq3mc+U6M=;
        b=OGW6u5Aq+GTSFdL4OSrnupfgmqM3iGp/W+2MkeAuqbX0CS3LoazD/lheERlgZFP1GN
         BPpNi6oaUv1Pr7P8Ga8XxDQyhizzAdb+xizb3/TNxduL2DfxzXqEmh4ljuPy890cHcAF
         Gyp5HqabjvodWitwuiKm9IBOeKehRLDi9Mie+Ek5RMrFy+uVfkjzXKI2aIwqfCBLZo+L
         TZ2JXwwyIq3YabFE5XfY0+MFo+KyL40TJtW2bvNNeU8ewQmOZMlwQmrj9OhfjiqZAu//
         XfPfYPopHTp+zh+Qvqxedi3aJ3xX0Bpk6/C6sYB5z4Dt2BAf7rrqi/y+9+Q/zUE8zwmN
         UAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748252311; x=1748857111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d20ogDY48KWL7MgG2HWAVRtGf3dYt1vl/Riq3mc+U6M=;
        b=BeszupzgdgqBn8eCNCVEeEGtifRAZQBoideEfKO0Y4aSTpQMh6YmUxC16HHq0DTaNH
         iJlOoPhVYy5UVQ+r3RmRgk4ttHsHr3Wy/gbadb29/2Uzlk5VZzXvlgpffFBtDv6KnYed
         GUw1F4gv7hQ6EUviDxXqCKGAD9ecVrfk3lA3w9lKtXvwIK3y3+cKcHXvDdxkCH5wxAsb
         cvKRYxcN6uAsT14YMHVjosh9ZGq+IbydBLAOE3VCJMV75xr05+QaHshAKJg47V+fDlYo
         +xSwJvPv9cjoz1FefUxCficBvuZCjsPEYZZEISNmmNbUdC4Ek5qo5ZswONPPGLcHZRHm
         O7rQ==
X-Gm-Message-State: AOJu0Yx6qqUFpANggNIYJ1563oeuBs53bqOKZyILXnMWb23jR7lzdJML
	/5z1F1XjzlbjIuc3m2jrdx8fnq4maeQ8H6uraEkApLx0MLO5DuT6Dp39Y9EJp0lIU3ou1pg+c/M
	DhsH4
X-Gm-Gg: ASbGncupir5ib70nkqlQk3lyI0HCpxJwjnGcI7p/QMjI8sXrlYtYTOzVJ5WknQUKSJq
	iun+AIYO/WWX+5vOcUHfUxThWuyYxPKW8wB2FtY/LMAHjnpFV5uZICKvUNx2G24+AAom/m8+b6d
	IC+RMCoNm1/Df5oeIWxqoeFZ2VrvWEJWayljYsEhW0Vio4eJSkQKFBZOgYXycwqkqac/QoKWD8n
	W5xIQV+1kfYiMcWRK4L+ts1YDkqn/Z2K+g/VWh3GjCGPwpiHKcxfyQZmnM9F1zBJQn3MXtfv7Gk
	hbcuKY3HU41ijyYH38p11jWsgSz+X01IEeog24IIKxiOxmkk4M65Ogj54t1F+uHDluwGwUvo4w=
	=
X-Google-Smtp-Source: AGHT+IEfPYKZ8iproPXMcEcAUe9IRKDgK0K700KcFWvYaN7hyL2eQ3OUSHEs0jj6z1nR8GrZoz1o3A==
X-Received: by 2002:a17:902:f611:b0:234:883:c9dc with SMTP id d9443c01a7336-23414f490c8mr142627515ad.4.1748252311591;
        Mon, 26 May 2025 02:38:31 -0700 (PDT)
Received: from always-zbook.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2347ee700fcsm5882725ad.14.2025.05.26.02.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 02:38:31 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH] AUTHORS: update Zhenwei Pi email
Date: Mon, 26 May 2025 17:37:57 +0800
Message-ID: <20250526093817.951024-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I will be leaving ByteDance so updating my email in AUTHORS to my
personal email.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 AUTHORS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/AUTHORS b/AUTHORS
index ad9ae703b..df9a88567 100644
--- a/AUTHORS
+++ b/AUTHORS
@@ -15,7 +15,7 @@ PAST MAINTAINERS:
 AUTHORS (merged projects & commands):
 
       blkdiscard:      Lukas Czerner <lczerner@redhat.com>
-      blkpr:           zhenwei pi <pizhenwei@bytedance.com>
+      blkpr:           zhenwei pi <zhenwei.pi@linux.dev>
       blkzone:         Shaun Tancheff <shaun@tancheff.com>
                        Damien Le Moal <damien.lemoal@wdc.com>
       enosys:          Thomas Weißschuh <thomas@t-8ch.de>
@@ -33,7 +33,7 @@ AUTHORS (merged projects & commands):
       hardlink:        Jakub Jelinek <jakub@redhat.com>
       hwclock:         Bryan Henderson <bryanh@giraffe-data.com>
       ipcmk:           Hayden James <hayden.james@gmail.com>
-      irqtop/lsirq:    Zhenwei Pi <pizhenwei@bytedance.com>
+      irqtop/lsirq:    Zhenwei Pi <zhenwei.pi@linux.dev>
                        Sami Kerola <kerolasa@iki.fi>
       last/lastb:      [merged from sysvinit]
                        Miquel van Smoorenburg <miquels@cistron.nl>
-- 
2.43.0

