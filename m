Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8DC2036ED
	for <util-linux@vger.kernel.org>; Fri, 23 May 2025 12:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748001928; cv=none; b=tTptkTJrIYCER8TJv47xjTZ++dKQoNhiOFDtpLC+vR9YvPtWoMp39+nE+p6BxzD2zaADwjB/7UaBuvbQOwGmMEZ/BeU894SzG3Chu2mjGpmtKDjCE8Yq3BBZDDmkbGnn7gSoiCXv35CknicNay3y5CL1eVjFKDd3TKBmCQIcbWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748001928; c=relaxed/simple;
	bh=LwxQDkj4KsU7vbH4bmesiz69Xggp+pqpnx4BabJ4u1U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qo9bp6sYyQAhw3vPIn2gksWSPkujzy4v96vB4eYVP6i6LwYcYgmTWs7dqL/2FEhYhrULQj4cWi7YH44DfRHpBsnURSzhlJZGdrB68eE0QBZcr/xgRlRiUxq1diOuvvQhaGi1FHRSxEGR7UfPdBTF0tVRBScgjrUUCqg34fya7U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=XJIm25yO; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="XJIm25yO"
X-KPN-MessageId: 2e51d8d3-37ce-11f0-86ce-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 2e51d8d3-37ce-11f0-86ce-005056aba152;
	Fri, 23 May 2025 14:05:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=+e1dOFEMAs8586rS8odzlpsBIvVaLR3PUl26jqR6RIU=;
	b=XJIm25yOonSW1iu7cBS2BlYurWX2dssE3iHpiPS50Ws0CZ6cppqAIDVSTQogl0dI+GbBZVU7SUgdw
	 h8+2nz8NCkq7jg0SOGyv1yciir76Bbrz03u1mYdZWAoC2+lkcJpvHKFfHmTFMPKBeMtZjkFq9w4t3Z
	 wMMyyhuIruFAu62s=
X-KPN-MID: 33|aUmd82yAk+CAL2AbkQoDe9tkbvOl854PJtS7yp2YQkYENppnRy4Afo2TaCIvRc/
 cFwjoBdbEmqmzoZfO18WWTAcHw7CXd19/YkUT7CETxKc=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|jYK4/eufMUjYabCjyfBboXLuTmM2/gSPrWRocHbORdVYeFitpw/a0vWp+ph0Q8V
 7nkVtrUtzI6IVAJOjdTzyrg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 0ca35263-37ce-11f0-8584-005056ab7584;
	Fri, 23 May 2025 14:04:16 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/4] hexdump: (man) put a list item on a single line, to avoid a warning
Date: Fri, 23 May 2025 14:04:04 +0200
Message-ID: <20250523120407.75188-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Asciidoctor annoyingly warned for every translation that
unindented content was added to a list item.  Avoid this
by not breaking the list item into two lines.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 text-utils/hexdump.1.adoc | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/text-utils/hexdump.1.adoc b/text-utils/hexdump.1.adoc
index c92733a51..33f889258 100644
--- a/text-utils/hexdump.1.adoc
+++ b/text-utils/hexdump.1.adoc
@@ -118,8 +118,7 @@ The format is required and must be surrounded by double quote (" ") marks. It is
 
 . An asterisk (*) may not be used as a field width or precision.
 
-. A byte count or field precision _is_ required for each *s* conversion character
-(unlike the *fprintf*(3) default which prints the entire string if the precision is unspecified).
+. A byte count or field precision _is_ required for each *s* conversion character (unlike the *fprintf*(3) default which prints the entire string if the precision is unspecified).
 
 . The conversion characters *h*, *l*, *n*, *p*, and *q* are not supported.
 
-- 
2.48.1

