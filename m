Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2EA3803DE
	for <util-linux@vger.kernel.org>; Tue, 13 Jan 2026 17:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768325414; cv=none; b=DEfyvXBF6aC2F21OYtDHcistPfdB4uDDG8Vde5QI4izbj1igw3ZKGmtyBkU8TF2ZjA7Cta8SyvF2pshFBllZcD901FM/k20QuP4vFtGTbLfNyGhLuVuCV2yqKbGdWLii9m8DnMRudlaaWHuPZwqlbqtgS2NZfAVnSx6YDxAC/hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768325414; c=relaxed/simple;
	bh=YICIzJ+zCQCI1Y9N8LCTm8Hma5x9Ad+R4JEO/Z10kos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0WvZXktBoowS1HN6rU28MbCyE+OQ0mmXV+BnpEO7/hp84tLSMlRgBIsiKzfMN5uWiFrwKEjcjiYRylovXsUqES0XkiYbFijaYntH8EkGE3cgIaOMzuGZ3mL5Fs7mbJRjkPatWsEoqxtZSk84VEFVSbINoBpUl5s6043hBCDqaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luSaQpeS; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luSaQpeS"
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so1642779166b.2
        for <util-linux@vger.kernel.org>; Tue, 13 Jan 2026 09:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768325411; x=1768930211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hc2rLnqFqeN4pnh6IFvjfInTqepMlJpDfy2Wkvhm0K0=;
        b=luSaQpeSUMEvU7RjWyKP0OKkqH5Jv+7R+sYdCEjBZydqgzlJ58uo8kBlfG/jZAsQeE
         8WGU2jmmRDjPyMFOO/Mijps3PSmsbFp+niKr+AtAhbR+EfXTjn0mkC0qPOJ7ekt+keUH
         vnkY2nEoTzsd4FA/VGVnf7YRCRyQWbAw84guq5o2jVx1zqNz2N/WGlKcOcANHXNuT+IQ
         WBAIBePGM/KMipB4mI6/HPsk3k/1DG8fZSN4T0/4+R0eY0kAUtJt0lmxTIPUbmhRl0ST
         kTdKWQgOP2EubOpyMArnN7XLXgHi+bGD1zF5TibKaGdv393fUR91DRC3qSIumoX51T/s
         Yhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768325411; x=1768930211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hc2rLnqFqeN4pnh6IFvjfInTqepMlJpDfy2Wkvhm0K0=;
        b=uGafi7fbAukziAOUEiCr5B+ant8k1dpSJgW+erTfYDPrbM/ALdL2Lc2GyhlZuZrzTA
         ZeXJfqnCScWe2BPxiGZ6reOBU7v1VtM2cR/KMrYJgFAml2ckpFv9grkQy2lDyFEF7ekN
         IkRZkcD3VMQMj67wSDafpl7PzYnkuX49f5Z3dx1LA/uO7cbNP7UqgYuHa3xDhx/YQVbs
         zP4vPchVnYwYfLEvDPkOtuA+nlg/pqp8tNd53zsimjd4pTTygxfa98uHsy/QG0v9NG5o
         lU99j6KvcygtlYTGCIlYA3PhV10LgdbfzNivBUws3mHeF3RI2t+jMWFdLUP50M4I6l91
         OvhA==
X-Gm-Message-State: AOJu0YzcM9UP+fH6VCTQkW5GfqBSBDCPzcAluj97qNJkAMA+6/hgCuc9
	56vVMjh8XHelEDcPbEyFllGl/izNQ31zEpgehUyknmvJyez0HSgNzVxlf/gMTHLS54OmeA==
X-Gm-Gg: AY/fxX7ximfloF3Mn/0UBLyC9WQvFGsxn8cDvhahM37Ygb3xEyw9lpx00PpWNMOq5QO
	Z5k8i4s+QLqoH6YlroLLqtGO30X0fetg2Zj0TbeD1P+OFJVT/9uFv2U7LhMrTAKXYYCQkXLSHl6
	AD1meNgfBJ908yc2sm7tB128pPxcsaR9jDzMd5rGUDcMFpgy49GXG9QrrOD9oE6kY8L07Z8/2Ln
	km7Ei7FNJh/PKTR4ksuKhiO0fOTP+XH80OQ7JWV38AWbOzO9pDSoX2gFE1TH8SAyk5QQlNWw9Rs
	PUNBv8sfdCVKMxe1LPAbBabo6p1g4YkhuLwMSNfL/Udi0vxNFpJccsn+G2szsO0gllQFpyrKQ7U
	J2ab6Eb03+ekgBK4KyzokvAo1y9bsARV+Pe/JTKm+LWHekK68VLvSmXoVQQt2VLH6RbXFxH9fg8
	+laRHw28aecGBz0g==
X-Google-Smtp-Source: AGHT+IGhDPS90BAFwT69pqvlxtB+wa9OU5z7W4ca1s0M0jMQN6z8XS9v8ZYS8i8K+NFm3MDeg3MY3g==
X-Received: by 2002:a17:907:e90:b0:b80:2b9b:39e4 with SMTP id a640c23a62f3a-b844501195dmr2138177266b.55.1768325411294;
        Tue, 13 Jan 2026 09:30:11 -0800 (PST)
Received: from penguin.lxd ([149.88.27.131])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b8c4484sm20835469a12.7.2026.01.13.09.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 09:30:11 -0800 (PST)
From: Kiran Rangoon <kiranrangoon0@gmail.com>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com,
	Kiran Rangoon <kiranrangoon0@gmail.com>
Subject: [V2 3/4] unshare: document --forward-signals in man page
Date: Tue, 13 Jan 2026 12:29:41 -0500
Message-ID: <20260113172942.10678-4-kiranrangoon0@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113172942.10678-1-kiranrangoon0@gmail.com>
References: <3tysdpabjulwlmr3hkm4pr7romwtf6cofhghth7buyuxnmwr5r@pliehv2xicmy>
 <20260113172942.10678-1-kiranrangoon0@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation for the new --forward-signals option, explaining
its use case (graceful shutdown during reboot/system management)
and interaction with the --fork option.

Signed-off-by: Kiran Rangoon <kiranrangoon0@gmail.com>
---
 sys-utils/unshare.1.adoc | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sys-utils/unshare.1.adoc b/sys-utils/unshare.1.adoc
index 85d00af3c..fa0b61df1 100644
--- a/sys-utils/unshare.1.adoc
+++ b/sys-utils/unshare.1.adoc
@@ -81,6 +81,19 @@ Create a new time namespace. If _file_ is specified, then the namespace is made
 *-f*, *--fork*::
 Fork the specified _program_ as a child process of *unshare* rather than running it directly. This is useful when creating a new PID namespace. Note that when *unshare* is waiting for the child process, then it ignores *SIGINT* and *SIGTERM* and does not forward any signals to the child. It is necessary to send signals to the child process.
 
+*--forward-signals*::
+Forward *SIGTERM* and *SIGINT* signals received by the parent *unshare* process to the child process.
+When this option is not specified, *unshare* ignores these signals while waiting for the child process
+to exit (the default behavior since util-linux 2.36). This allows the parent to remain alive while
+the child process handles the signals.
++
+This option is useful when the parent *unshare* process will receive *SIGTERM* or *SIGINT* signals
+(for example, during system reboot or from a process manager), and you want the child process to
+be notified of graceful shutdown requests so it can perform cleanup operations. If your child
+process has signal handlers (such as shell trap handlers), enabling this option allows them to execute.
++
+This option implies *--fork*.
+
 *--keep-caps*::
 When the *--user* option is given, ensure that capabilities granted in the user namespace are preserved in the child process.
 
-- 
2.47.3

