Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7100A1D540
	for <util-linux@vger.kernel.org>; Mon, 27 Jan 2025 11:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737976180; cv=none; b=fh6AsZypPS528XNKPbXJJM66XMjgCd0G6C1V9sWroe0yonuDKFS6I9uVKyGnWtyJfMCV0hfHZBmE65vnz6ee/kdHOZuKSIRFHyyhdL3DiZ6cWIwkVrFZFpSgTMiV3/FMeaEGBIQLikaurBSrKz1YC0BJYUB8rVh8PmL2CvffXwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737976180; c=relaxed/simple;
	bh=FUWsPbLum+L3DVLVCcvFWQSUY3dpmsCGm0By573dgq0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=K4WIt5Mq3ghVkjnXXqAMSWLdDtNz2Bd3rvYZrdd1GL61m+GGlaqM1yr5N2SLcsFDNqa8ZzXVhRrQBBerzKadmE2ycCC2/ZqlKAb7SmHVcc8+Syik2T+3dW5ECWNCMo9sWpDDE9SKTV59Bak99T1suk2VtmeecihNzmMQ7aLTe2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=iyuZJBVB; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="iyuZJBVB"
X-KPN-MessageId: 3eaf65c4-dc9f-11ef-aff5-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3eaf65c4-dc9f-11ef-aff5-005056abad63;
	Mon, 27 Jan 2025 12:09:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=Vl4GuGjvcFRULhi30WOpjroScxBOUXT9e1kFEeNhlNY=;
	b=iyuZJBVB8WctdJcjd8Nkhaq3Zs+bWIGOcnjNOJyeAeE3uzwn5BbOABIkJS5jaYgxk3ULEvluUhOZp
	 66yTNZRk0YMN52k9/rmQlC6GhIxxb41wG9f7kLViG9G03dHSDriy1dvCA7AOC9Pdof6f5Em6DNwURg
	 6ZQhiwUa2Gzn/vek=
X-KPN-MID: 33|BhyBqobqnLh9r+bNn7/tLetLXo2JVnx2ln7X5AgXzUeVU1Z/nKZlmDGk4c85u8L
 3e5N7kyD33gQ8pmueof6oYQ==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|1R/3kl+/dMe24MUQc+Kv7cZdUAvRxxZkojXHv9bi0Oq7A5l9Rs4z4VPU/iMDLCw
 zSrkMySW4ABXGpJjWYNkZmA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 08866d23-dc9f-11ef-a313-005056abf0db;
	Mon, 27 Jan 2025 12:08:27 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH] logger: do not show arguments of --socket-errors as optional in --help
Date: Mon, 27 Jan 2025 12:08:25 +0100
Message-ID: <20250127110825.7219-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also, show them without angular brackets, as they are literal values.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/logger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index f696287d7..bcdff0614 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -1101,7 +1101,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_("     --sd-param <data>    rfc5424 structured data name=value\n"), out);
 	fputs(_("     --msgid <msgid>      set rfc5424 message id field\n"), out);
 	fputs(_(" -u, --socket <socket>    write to this Unix socket\n"), out);
-	fputs(_("     --socket-errors[=<on|off|auto>]\n"
+	fputs(_("     --socket-errors on|off|auto\n"
 		"                          print connection errors when using Unix sockets\n"), out);
 #ifdef HAVE_LIBSYSTEMD
 	fputs(_("     --journald[=<file>]  write journald entry\n"), out);
-- 
2.48.1

