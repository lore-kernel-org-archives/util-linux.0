Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C702E3390
	for <util-linux@vger.kernel.org>; Mon, 31 Mar 2025 09:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743414346; cv=none; b=LEIGxMpUabmFQbAhFiYB0LrdZW769A6Hf2eIqZz5zh7E0hHKayue4Ig8HRx4EITcbuVhZFeY82U8UHZPwhIy3z7AS4B5kVwRCUpt4YwjQJTVszFWARiT0gpdK41WIeMcUTTzaQKGdxB0KQi8GJ+2hKs0BX+NKs6guWmTra03cZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743414346; c=relaxed/simple;
	bh=oQP4RfyKc5fQ69ChPCYfO7iLbW14n+JrLxJB4j5qdA8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJyW+xtT7SafIfboifXf+9TFIH4smDOzroev7iX9e+GXnGAPtxSmq/SSNPQeU27sjZEMXpeMQ9EO9/d40Tmi1HJaqDTDRNDzym1XSZG5sosMDN3XFF3n1j0nQ9LbFqFmZpE74xatidyI+UiHUlvs31TfiMO38/WpJ3LW8V90JfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=JoQzASqV; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="JoQzASqV"
X-KPN-MessageId: fb2aa9b6-0e14-11f0-86cb-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id fb2aa9b6-0e14-11f0-86cb-005056aba152;
	Mon, 31 Mar 2025 11:46:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=oWmiCn7LuwfQ24fkNvgsSCjZY2yA2hVipJni3yMp9Gc=;
	b=JoQzASqVDRhKZjjegibm6S16TEO+5MnsV8bipMnk3nYxqDjDe5IDILdoSC8VvERGKXvTe/NQ3C+cC
	 sI36oRnSVjsg/UxFpGka+YanPZn0YJ9hejvMUwowJ9GpXgR+sLwzCUPSWXmKBxvNPVoR49l2tHZvja
	 cbMkvDIvHzfzMjOg=
X-KPN-MID: 33|rTBcavB1cdtV7SSE52ymFpFitZhz4CzGhhDXU9HLNPqq275x4qp9k5BDk2H3cjK
 Iu+LbgXTFw4VjfFAGe5gB7BcB4ffYBQmhZSrBHW46xq4=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|FwFJXwnRLM59X2+rccrECJTW3nTVkFaDkUXfsrutcFzKK4z7msx/hBbfumaSrfA
 A/9AzcDvInFjpxUTZ7zAikw==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id e9f5a72e-0e14-11f0-9598-005056abf0db;
	Mon, 31 Mar 2025 11:45:43 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 07/10] hardlink: fix typoed semicolon to colon in error message
Date: Mon, 31 Mar 2025 11:44:40 +0200
Message-ID: <20250331094443.9619-7-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331094443.9619-1-bensberg@telfort.nl>
References: <20250331094443.9619-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/hardlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/hardlink.c b/misc-utils/hardlink.c
index ae8215901..0849f9102 100644
--- a/misc-utils/hardlink.c
+++ b/misc-utils/hardlink.c
@@ -1385,7 +1385,7 @@ static int parse_options(int argc, char *argv[])
 				else if (strcmp(optarg, "never") == 0)
 					reflink_mode = REFLINK_NEVER;
 				else
-					errx(EXIT_FAILURE, _("unsupported reflink mode; %s"), optarg);
+					errx(EXIT_FAILURE, _("unsupported reflink mode: %s"), optarg);
 			}
 			if (reflink_mode != REFLINK_NEVER)
 				reflinks_skip = 1;
-- 
2.48.1

