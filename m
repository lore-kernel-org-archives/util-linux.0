Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BE22FA0C6
	for <util-linux@vger.kernel.org>; Thu,  8 Jan 2026 18:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767897106; cv=none; b=UCjyFp/CNDQszpFjy/l3Pls5VW6Kju0HwHGuS7bmL1zaHdir2otZKlYc1I2j3czW3fsvewtQ6O36Aaz98rL5Cd8JwkqbL+sM/tBC4+3dfGj0WYPUL8JEkrXvSoCTTHoHzwg4jPpSL23fYo40Q2Ha8Gyx8KNajkpJIZhacqcMuiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767897106; c=relaxed/simple;
	bh=gC8BRS1FfZWUO80zjUL52D9hU/Za7oZqlO1yy4ADKzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4btbR1u78vd7ZfFwPjwkoFIaOMhlsrF6PBaxa1Y/SO77PcfqLaPPtFRfn769sUOp9kVfhJrsb9Qlxlt/g3/G9WMVIpIckwi8s2N/euq0MWFpTBWMpOjv/MoG+qTWLLnNF6f8b5loZaGyU8+JckbZItXC0XurqayrrFnIlDqZHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIXmdjWr; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIXmdjWr"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-559836d04f6so2518929e0c.0
        for <util-linux@vger.kernel.org>; Thu, 08 Jan 2026 10:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767897103; x=1768501903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lU4wak5974Kdj6wR2mtmjZdxhbhmbHR7egP7cKXMYk=;
        b=IIXmdjWr1hhoULiZBnn6wB0EDzI1c6hcL0XzTv6sR2KS8ZrSPMPEhFnd8SrdHlc+Rq
         Jri+Mxr/qfPt1wEWVE9A7actHTGtqbFJHq8WB+1jZhzMMsBKDvrvJbJsixnGUhRpkAIS
         WYKR1/Si+bdPzDISgmxZ4cuECpahUWn/yTHPg1ABT5O5S4LJbt0OmE98CSwFGvBEg024
         Anhu+5wZNa/7FmHUwDx7GqXdEbPXYJEIGGLlGKdMc/iW7wQ1IfkUkZTe8vvsK0XyWLLZ
         AavONTEby07CGhF+r7w0MQsF7KIkZxMWQMaqdLWTSPpoRclggCu8k0jvu5zmUUjxc5Q5
         Lf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767897103; x=1768501903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8lU4wak5974Kdj6wR2mtmjZdxhbhmbHR7egP7cKXMYk=;
        b=DL9it1/Qn+KunjZ4jQQVN7Ft1nuJ4tlTi2UQjwwRbBnc7ChVuva53nA8aYxSfJNG1J
         sdsoSbdk1+5fWAsV3LDrX6OlDrJNu58nWuAUuP3nC5ScpGn42UjaeYVH6JBpBwhUVibP
         tsmKqGoWMfQkejp+PfJiPJn3lY1cWCX/GkhetTotJfRp6n3yiRCSWT57ybk1jfv+z/X7
         I7cgQW+GEL2Sla2/2i/uExydqvOx4eid6Uk8EzacY0JfFQTzJQb35Uc57jN2MTbgGyff
         3JHvZdg1XRhlXE+OLQQXy8z8jVmxXq8qayaS4VfhLfH5BVFD3w5hox7lgM6bCrt1yQgy
         8EFg==
X-Gm-Message-State: AOJu0YxaKMRroOvpdGYmgYUSCIg0VG5CNQvfDj7WkStcizkAD5IbBHl5
	nca/JfwKW9dGU3H2Z46q9H45tNpZ+Yu1s2Dn2Zd2dHI/9JhY8CIedDYF1N8oHg==
X-Gm-Gg: AY/fxX6Kmpp20K9up16VTUeMVwv2ndfUIImeCkLA96Lp5tTuAslzbgbn1PF6Mf1A4GM
	00lPm5ANNm7PePs8NLpKnSMWgocN8HdvfEofSQLdYXM6u5pz7+9NnLbrybfQY5zRm4cTnmbPxAv
	uEfgtRepcldUlvsT1sINklbNc1dwesjxDm5aaMRme3AXL9MOWut6aeYtGi8gefcAUdiYCuDY1G7
	IPChRvb786dtO4yIbCaxguRDT7HTMETxJaCg7hGfxMwFAmuYrSwpP2kT1jIIg+e78ncUWbkfJC2
	BAQl7RM6z3ksKs80ANtq3VyY8ssOn0OGYZwv2nYXgreO3dkJniRZEY6zrBib7IiQRtJ1qhNFXgL
	8DJgFKyMsiSuRu9EIEOKgdm5XshqlW1GpNg+0uNGQ9+AC6I7JBKOTQVsgAOj8XMyKKfevQHEyiW
	smUhQFX/FTqG/Hvtbv
X-Google-Smtp-Source: AGHT+IF3dmHHEwb8UUSUtZP+nyoZcYAOqjWvP63dIrcUeW/NYaTX/CVvxnte/zLiQS28faX4dIDkjw==
X-Received: by 2002:a05:6122:3210:b0:559:6e78:a434 with SMTP id 71dfb90a1353d-5634735b8e6mr2858614e0c.0.1767897103430;
        Thu, 08 Jan 2026 10:31:43 -0800 (PST)
Received: from penguin.lxd ([155.117.189.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5633a1ea753sm7087287e0c.4.2026.01.08.10.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 10:31:43 -0800 (PST)
From: Kiran Rangoon <kiranrangoon0@gmail.com>
To: util-linux@vger.kernel.org
Cc: Kiran Rangoon <kiranrangoon0@gmail.com>
Subject: [PATCH 2/5] unshare: add signal forwarding handler
Date: Thu,  8 Jan 2026 13:31:31 -0500
Message-ID: <20260108183134.23980-3-kiranrangoon0@gmail.com>
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

Add forward_signal() function that forwards SIGTERM/SIGINT from the
parent process to the child process. This will be installed as a
signal handler in the next step.

Signed-off-by: Kiran Rangoon <kiranrangoon0@gmail.com>
---
 sys-utils/unshare.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 6df53666a..3850e5f4a 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -122,6 +122,19 @@ static void setgroups_control(int action)
 	close(fd);
 }
 
+/**
+ * forward_signal() - Forward signal to child process
+ * @sig: Signal number to forward
+ *
+ * Signal handler that forwards SIGTERM/SIGINT from parent to child.
+ * This allows the child to handle signals properly when using --fork.
+ */
+static void forward_signal(int sig)
+{
+	if (child_pid > 0)
+		kill(child_pid, sig);
+}
+
 static void map_id(const char *file, uint32_t from, uint32_t to)
 {
 	char *buf;
-- 
2.47.3

