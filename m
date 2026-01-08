Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F0430FC25
	for <util-linux@vger.kernel.org>; Thu,  8 Jan 2026 18:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767897109; cv=none; b=n7vDq675OTEvzy7t1Eu5S4ztXUGCKShr2lsxfoAo3gZ/9dpfCjnLMMMz/bcjchqjJE2QN6h/GSGgG83BDFEE1st77u+1RvshoOplLKeeV1d7lXrLwAhLXfD/mRG0FXU3OBOUC3AVIbetL069sUJnXkWtTei3o+Y8EKlv5GwyCUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767897109; c=relaxed/simple;
	bh=CYs0LRmp6k8BbC1dKtprvSbjOV40W3pKOKkq1W0H71c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTlcnKZstlpmsGDigWTp0QjQDAYGz2cWXRMMxoF+ZzolSBq8auFntjtIITgEFAZKK4r1+C+f2iK6NarnvRCcE2jZZUWjfxQ5e0U/Xa72ZhsMv0NBwmhpPQHWaCkivrNw/p0erjkOhih+8mWF0da790JbsQdDVuOzrnVATS56TDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B61T40sg; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B61T40sg"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-559836d04f6so2518973e0c.0
        for <util-linux@vger.kernel.org>; Thu, 08 Jan 2026 10:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767897106; x=1768501906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hf15JRpUhMNuwT6rQc0BHUzCL6QRlV/R+6rRBHccrUc=;
        b=B61T40sg4fVaYtYHm6LxlX6laJBkSSlOCfmwUhfyr2KuxvE88fNynjHfIhwL7WHyGu
         pkWxSti8vgjTis+UWf4wH4TJec80qSjk8m1qlrAH3duj9IXxItr8S/6Xl9Zd4aaCQdPh
         pSpg7I17UvZj21NlVCuYAUSrXvFEwYzo7mnneokO70MJNHACKWqJa+yBH+d2o2EYFOen
         Y6haCGzeSzkJIi0+yhyTI/+v4HmugmMsgUV7VuJDXsmO3xEk+RptOvAOSOzFBLgnddhO
         DLownxFGjuSNdIOcL/n9qOfiTmM6UEy6a0wXymN7ps5z5G5MPJfK6azlyYjYxeXkjeH7
         H90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767897106; x=1768501906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hf15JRpUhMNuwT6rQc0BHUzCL6QRlV/R+6rRBHccrUc=;
        b=Znu2OkIrsLOedsRDH+cCJ+hlPZwx5E2ESGfCLzobbRu9a354eXkQjIUAyT5B4eVa8+
         T0E40eGPfs1LUhypQcvpBGAwlLEKqlwSAPbEPRPjvEIX4NPVEgHSOOihS+w6OnV/+86r
         Z+FTDwqFFex/O3QEggw+/032/NsbwLWXNOQDvZZbzppBBZGDKvfsDXip0hKNqlU7L6ZP
         4n7Qjc26Tjz6IfKEdqUvJWM0c3+AXkIqZnFcUx/6VlHum2JDfq9iAbT+ZQTt1lY+xYza
         vGb7DHnCyAtv1i3Fs8AnD8uHH+zAOte1jwNoZryRqtjZdC3xIWOW5FJQaYTQZbE43W/V
         0J4w==
X-Gm-Message-State: AOJu0YwT1D1aQWHFpk/OtztmeVD3AuaJJRhBzZgXReqjIJVDmvNs++py
	kYzLatn2HwmjGMUU4lRUucLu+ypnbsbMtr1ouzG4yha/rlmj6ioliSRrFz3s4g==
X-Gm-Gg: AY/fxX4T34gFq5W31JKKlJB46O58G0EjIKX5yVWP1+Rrxstu4QP37z4hDHqieH/snzp
	y9qyzZUcYBsfgbj06XORTELEZbOWxDzXGZFqlJjBSJPkrNmHdSbwTE3ONmi3xqq7ohJIK64feY4
	lMvEicDsdsUK5TRal1mdBT7gah6lxP6MlRxyUDhLX//1fMcjSzp9cdb5KhVuQ/8+crmH3pf+IeN
	mVICyfC2YR9Vao3fwPJygkw3TeRrTkzqIjKZH78zdjksbaKzW3NSy+zWckSp3zyECvFH9i0arIp
	kpHnRelxT6fKIdL6+8fx4hxb5wVfNKSosTyfCsEzw5ER2OufIkBzX/axiOgJrOx6Ee7L8b67+Qf
	UQ68FPsaL1D9eMLOeRad0h70Jt5l481lPB8NyZVaVfJ1uQ2e5bAHhUfEhsTAaGxfOjWpc71gWBM
	DJXi3KaA7HMkVYmrrZ
X-Google-Smtp-Source: AGHT+IH1Rp1T1TkNRd0ICr23nCvzM6IbBwv5tRTP+qKCdxPoZ3e0zlhGH8gg36XyV2xuw7ltRh2ddw==
X-Received: by 2002:a05:6122:9001:b0:55a:e007:4c7e with SMTP id 71dfb90a1353d-56347d6e735mr2539963e0c.6.1767897104980;
        Thu, 08 Jan 2026 10:31:44 -0800 (PST)
Received: from penguin.lxd ([155.117.189.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5633a1ea753sm7087287e0c.4.2026.01.08.10.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 10:31:44 -0800 (PST)
From: Kiran Rangoon <kiranrangoon0@gmail.com>
To: util-linux@vger.kernel.org
Cc: Kiran Rangoon <kiranrangoon0@gmail.com>
Subject: [PATCH 3/5] unshare: replace signal blocking with signal handlers
Date: Thu,  8 Jan 2026 13:31:32 -0500
Message-ID: <20260108183134.23980-4-kiranrangoon0@gmail.com>
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

Replace sigprocmask(SIG_BLOCK) with sigaction() to install signal
handlers for SIGTERM and SIGINT. This allows the parent to catch
signals and forward them to the child, instead of just blocking them.

The forward_signal() handler installed in the previous commit will
now be called when SIGTERM/SIGINT is received.

Signed-off-by: Kiran Rangoon <kiranrangoon0@gmail.com>
---
 sys-utils/unshare.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 3850e5f4a..9255ff4f8 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -1116,11 +1116,23 @@ int main(int argc, char *argv[])
 		settime(monotonic, CLOCK_MONOTONIC);
 
 	if (forkit) {
+		struct sigaction sa;
+
+		/* Set up signal handler to forward signals to child */
+		memset(&sa, 0, sizeof(sa));
+		sa.sa_handler = forward_signal;
+		sigemptyset(&sa.sa_mask);
+		sa.sa_flags = SA_RESTART;
+
+		if (sigaction(SIGTERM, &sa, NULL) == -1)
+			err(EXIT_FAILURE, _("sigaction SIGTERM failed"));
+		if (sigaction(SIGINT, &sa, NULL) == -1)
+			err(EXIT_FAILURE, _("sigaction SIGINT failed"));
+
+		/* Save old mask for child to restore */
 		if (sigemptyset(&sigset) != 0 ||
-			sigaddset(&sigset, SIGINT) != 0 ||
-			sigaddset(&sigset, SIGTERM) != 0 ||
-			sigprocmask(SIG_BLOCK, &sigset, &oldsigset) != 0)
-			err(EXIT_FAILURE, _("sigprocmask block failed"));
+			sigprocmask(SIG_SETMASK, NULL, &oldsigset) != 0)
+			err(EXIT_FAILURE, _("sigprocmask failed"));
 #ifdef HAVE_PIDFD_OPEN
 		if (kill_child_signo != 0) {
 			/* make a connection to the original process (parent) */
-- 
2.47.3

