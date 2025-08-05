Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47C0183CC3
	for <util-linux@vger.kernel.org>; Tue,  5 Aug 2025 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754385967; cv=none; b=gyN2T7y67N9JLDYDSpezn/94x0W1etkaCdgmfb/bbLOPQEHEOLYQjm5gyeb/OhFk+1JJQfbLCrooCpft9Lw76BUkX3yp9aHmQ6YhhVYdkcBvoo68gAnhxleGNyRDxJetnegAdAJyiCKfdCVb6ZZneosGbkx8YMlQlGCJnR4ovz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754385967; c=relaxed/simple;
	bh=XvxuojGkhE0jId4i7wWmXkzCuvlTdP7lZdOgmRV0dEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ImfAjL5h+4Tc7SjANDy13hxXku7mdL+xosbvtWsvz/TBAdDD+YcxsJmvXela/Khl3nFnIO9xMXV+JkKEl9tXq1IHdTo/cNU7eFWefmmNsgLBeGHRBSvCqJOODS8/HljRHq7DV/frVkLTF/b8xbDBhs9AV0ftMBmfYYwvayJ8T48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=b4T5ZFqW; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="b4T5ZFqW"
X-KPN-MessageId: 1c6aca8c-71de-11f0-b7a6-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 1c6aca8c-71de-11f0-b7a6-005056abbe64;
	Tue, 05 Aug 2025 11:25:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=Tm0wyRWcwt61UbxWXQp/D+e24N5xkSSKK018Y64hmkU=;
	b=b4T5ZFqWjgJxDIwYK2cVW5flzJQy5V0ATqYpslLJSrSLNKY6180kkpnDZ9fkiWOQ58WPHWIEL1wYO
	 MPg+wso1zRWhQRKJDBHMykDo/+xQAGU3R38Du+g0MFEXAmG8xUKZBpHktWylfJE3k1DHe40SvzcaBp
	 oiwHngKl9s1rzvG4=
X-KPN-MID: 33|/sNfYe5+7VZpamHzH9fBqw1pZRiu+1yYVRhBejFFsF3xqtbjHcBNE42ay6aSWas
 nSBqrpKyzQKMaCLogwccJVrXiNc/8+oIJ4jjE6aSbFQY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|sRG81yQTYJ+5RN20IWMUNhtltssidqZ6myZRmrZl8WvpdBP95eSA0zfLPPVRUXM
 YpV63oXNDh3PLTf37PC7BVg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 0b0288fe-71de-11f0-b443-005056ab7584;
	Tue, 05 Aug 2025 11:24:53 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH 1/4] chrt: produce better error message for missing priority with implied -r
Date: Tue,  5 Aug 2025 11:24:40 +0200
Message-ID: <20250805092443.5847-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.2
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 4c425142844d, the following two equivalent commands produce
different error messages:

  # chrt -r ls NEWS
  chrt: invalid priority argument: 'ls'
  # chrt ls NEWS
  chrt: unsupported priority value for the policy: 0: see --max for valid range

The latter error message is enigmatic: where did the user specify '0'?

Before the mentioned commit, the second command would produce the same
error message as the first.  Restore that behavior.

CC: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 schedutils/chrt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index 1a9522728..e07284e41 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -524,6 +524,9 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (ctl->policy == SCHED_RR)
+		need_prio = true;
+
 	if (ctl->verbose)
 		show_sched_info(ctl);
 
-- 
2.48.2

