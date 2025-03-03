Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26FB1DB551
	for <util-linux@vger.kernel.org>; Mon,  3 Mar 2025 10:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997380; cv=none; b=qWAIHvmJVtt8hnZBVwU1wzkSvnx9pa94C+H8tS3TfQbe5ZcphrK1jnoDK3wyHHjW00gLmq8SRH3WXbnrgCsDHWCZld/OZJpCfwgtxTXghUBJ+MzOAmZ1zniKdju0+pGz2yTUrcIWsENj+3lIbsTOf06EZekb8qCMLFdn9NqrcA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997380; c=relaxed/simple;
	bh=I8FslVqSipla4Yc23lEI5NWKhAn/1eUwhp1AKhMzrxg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nyM1sFRz37AEsIpjD+JJrkAXaT2JWhGaAY+8g7GyT9jSS3JgDJBUVXp2c5zuyJWCt/Rmj7w6ITFB0X3Bn/bide8iJaggBnMxzd1r2U4MTPzUx3dgNwfhgiKEuz9z6J/6zBS/IvSAFBlPktcMAPjTz/gozwtaq5cKTVD+wQuJt2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=To+Zw/hI; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="To+Zw/hI"
X-KPN-MessageId: 51a45c59-f819-11ef-a82c-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 51a45c59-f819-11ef-a82c-005056abad63;
	Mon, 03 Mar 2025 11:21:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=3YYR+PcKHzQZ7RYAte7TwcomRVYOVPh25rnQ67XKjoM=;
	b=To+Zw/hIGgqgrEHpsv/yEdwBy0j6+V83foNK1yUMWgOFfKMGVNSeDT40R257Xjz4C0Q2/WI8XK67M
	 pK/Lt2rqNUHN3au2CUWYwbewYcJDHzzwi2Ijzqrkzi8y1D6WIP9RXx1DSjzMGNenEE4jI8MTfRcXCB
	 uucJ/DOuHf3JGYso=
X-KPN-MID: 33|UB69DeJCy/4g2bH0Ij5/9utTZHnYHjmiiuSmggKSfxQHTnliGu8RkHjcbdn6ASa
 WafIPb/YcNeMblEAd5AigIcOhvnH+jhpgZDD/c5EJdKc=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|1Vqg9oi0LwUPfi2CRx7m/oP+wiaHEEeaoiUa6Spt98T3wESzHpvSyXdfeWc/k9X
 BI9XHKHGPN6Fz5cWjHKGcKg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 5092ca1f-f819-11ef-84be-005056ab7584;
	Mon, 03 Mar 2025 11:21:48 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH] column: replace a mistaken word in an error message
Date: Mon,  3 Mar 2025 11:21:37 +0100
Message-ID: <20250303102137.4020-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 text-utils/column.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/text-utils/column.c b/text-utils/column.c
index 85a303455..470c2729a 100644
--- a/text-utils/column.c
+++ b/text-utils/column.c
@@ -1065,7 +1065,7 @@ int main(int argc, char **argv)
 			free(ctl.input_separator);
 			ctl.input_separator = mbs_to_wcs(optarg);
 			if (!ctl.input_separator)
-				err(EXIT_FAILURE, _("failed to use input separator"));
+				err(EXIT_FAILURE, _("failed to parse input separator"));
 			ctl.greedy = 0;
 			break;
 		case 'T':
-- 
2.48.1

