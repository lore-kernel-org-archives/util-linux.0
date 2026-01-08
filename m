Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E480731A04F
	for <util-linux@vger.kernel.org>; Thu,  8 Jan 2026 18:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767897124; cv=none; b=eGcCbFmfGF6+j4I+FZKUBqqQ9GJ846QhAw1o/9GKn+H2zipP7MNaB8w9eo8Bl1MDQ4L1/nFcbtrF5JYS2puwIzRuKddj9BsZaPaAAACpC3lO/u9nEU7767GYzH3OAQXEvBPGr0YkQEwU0HEeI3c2xfnJCvw0LjyySNUxKNRnIX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767897124; c=relaxed/simple;
	bh=qHvGoWotypj77cLekNx5vqWQRC3fNBZXs3iZYUB6i2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lD1ba7Gdsv6aVSiSjYWKRG0KOTaoIHQnIYFhTm/QT/7bBExhmuXyU892gAdmZ1i0MCw/qBSxcNA5IsnJZMDK+uAsvw542yLG0Y29+fFpaAQI3gPt64OPGbXrm/p8Wnh8VaQDzdp8kTrIP3aOQ7+qv3xiI+z4PPFNqXXQ2J6zZtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLRNwhpe; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLRNwhpe"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56021b53e9eso1065946e0c.2
        for <util-linux@vger.kernel.org>; Thu, 08 Jan 2026 10:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767897118; x=1768501918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soA6/9828eijvLiVNqGi/XomQPfh0N3MEmcso4HRzBY=;
        b=MLRNwhpeAkOOVJ7/8NqFf6Njq3PRQl6O4AVYIfSi2+9rbXrCE8trYGWTCXRURoQ/HP
         5M0tSXdIx1K8bMGvRuknJPMC8uV6JHUR4fUT/hZVeN/q4QNinrI4DGGKuf827tsqJGD3
         bA6lVNITdq9vqZQ/DD1EbEEEFYJZ7dht8sv/e8HaVZy2wWCwxADRZG7Fkb045IHz8Ydk
         7b7A09SpliHUH0+7fdXUPJUW0cbxNziv97FIGn3i3as8ORDP7P8v9DPhSe+BlcLCgpS1
         Bbmmo3zieo55lWoamF9fvGB5f2x+AV6JLlZNTfYpnWRz8KyjbOEq5URRyTRxU9Zo3yhM
         wjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767897118; x=1768501918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=soA6/9828eijvLiVNqGi/XomQPfh0N3MEmcso4HRzBY=;
        b=ZDXFYw05mWXHJPFV8Sc6pwBxXK3NQXqH3IGdDWqLB5VVW420Q2DfgWnadMxN3riT9K
         woYxq9GkCuSrkP3tAkqJ0/e4BGGmMUntXNecYgJDRxs9DD1wIOnLSAvkyro2U9MbLh6/
         CKEfoTmoDHhWo8EpF2mqdDh1uIhKeC3Cq75818gxK3ACtLAVmpBPo+r1emU1yYlYV+bR
         t4hQwYcrK5/6172fQjuvgM6z7Ah6WK4CAmbmw/RhFml1EMpE7/ujOZ4pUu4OuCZxBAe9
         27AEggiCvg5P8tmXY1X+BvLZVxJLfR83Dzrw0TydISQqgx9vd3XsBouXJNTHF9tWl04d
         8y+A==
X-Gm-Message-State: AOJu0YzUALtf+RSQ0LZoTk+rHRZSn06zED8WtO5AhWy+B6MZvfL9g5YI
	MYxbtKg3+GWyMbOuTnADcB9hoOKYryHobMOury+8qSHnVayG/7vCEKTpp5E4jg==
X-Gm-Gg: AY/fxX7qhkRKD/7TljvY6A74+CzBPbM+WDZuVL9+l0d14+futoxOyN/rfj78DtCJ8FE
	nqfKoJNEcds9BvQXXLjFjxVi83N8/8a8ZobcDJ45rQlMeVBtDe9LhCDjuLeESNcdHzzS9Ym1ljQ
	eZrB7BcG0m6dIwoSoH6CN67c//xzMOdGaTszaHU4JNMPsk6ibyfVZJdD5+TQkdEGwguSav0HuYC
	rCkIZZSF+Qsj1+sp2ZP3UkHexFgaDFGn+WZdzGBYZoXABNVSeYuFaDRGKrrURqnh073JweLX7uR
	ka0JhhjFX+jjfjNQOcSj7W0jQx2d815PnKkYCpOyC845Z9lnn/58ToeBwak8VU1/HzXYFdfGzjk
	3qHP7d55iioKNd7LdcAF/Q431yuS958pzUDXJeEzu9LV6+/V2NB6GWmbeuhegn2iyV+VUVoF0JB
	vUBrUw//vAH3a2PUmL
X-Google-Smtp-Source: AGHT+IGOt9EJ4fuRP3liihr44SxqdoLKc70Q3wqRcMlH+stDE2/9Umzd1yGZO/y6uw7ba684Kgvsnw==
X-Received: by 2002:a05:6122:d15:b0:544:75d1:15ba with SMTP id 71dfb90a1353d-56347d61e20mr2216651e0c.8.1767897118527;
        Thu, 08 Jan 2026 10:31:58 -0800 (PST)
Received: from penguin.lxd ([155.117.189.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5633a1ea753sm7087287e0c.4.2026.01.08.10.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 10:31:58 -0800 (PST)
From: Kiran Rangoon <kiranrangoon0@gmail.com>
To: util-linux@vger.kernel.org
Cc: Kiran Rangoon <kiranrangoon0@gmail.com>
Subject: [PATCH 5/5] unshare: handle EINTR in waitpid loop
Date: Thu,  8 Jan 2026 13:31:34 -0500
Message-ID: <20260108183134.23980-6-kiranrangoon0@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108183134.23980-1-kiranrangoon0@gmail.com>
References: <20260108183134.23980-1-kiranrangoon0@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify waitpid() to retry on EINTR. When the signal handler forwards
a signal to the child, waitpid() can be interrupted. We need to retry
in this case instead of failing.

Signed-off-by: Kiran Rangoon <kiranrangoon0@gmail.com>
---
 sys-utils/unshare.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 8bc805e05..2ced8b7a8 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -1172,7 +1172,14 @@ int main(int argc, char *argv[])
 	}
 
 	if (pid) {
-		if (waitpid(pid, &status, 0) == -1)
+		int rc;
+
+		/* Wait for child, handling EINTR from signal forwarding */
+		do {
+			rc = waitpid(pid, &status, 0);
+		} while (rc == -1 && errno == EINTR);
+
+		if (rc == -1)
 			err(EXIT_FAILURE, _("waitpid failed"));
 
 		if (WIFEXITED(status))
-- 
2.47.3

