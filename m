Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC7A268C49
	for <util-linux@vger.kernel.org>; Thu, 13 Mar 2025 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741877596; cv=none; b=abJvdMdu/V9I2p8wkefhmQE0gBgBT3FLOYOI1/rJJi3ilKVqyygQwSgMN1OsOOAZByeEO9RRwl0aDqnR85lbmffE+JRZIWKj9qTaoqH5+dZk6MWNbTDZyBXZjMdckVuOB/uC5LLNDM+tn7pW8I7lGPAnsq05K+9uds9H7BzdcdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741877596; c=relaxed/simple;
	bh=7AmN4mFG/GUNx5Dc5s/IzgpOVzEdlW+WT4mcq6GnYCQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MLeQwNK1U/L8vBHqLxhSxjL9U+ZlsluOy124Xoe0BWx64LZmtZS4fPR2vJ8mRNvWb8atYM9gN/Vc3pMEQnT6mW6Af0zC82lBrMGjKqmO1mFyAzL9iYQBXlCozoBxScVLobW+2ex1qm77hp1RtLTZtuZq7DdDGGsSu6oN+Vg2ZBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=B+iQzp8z; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="B+iQzp8z"
X-KPN-MessageId: c4b0daf1-001a-11f0-86c9-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id c4b0daf1-001a-11f0-86c9-005056aba152;
	Thu, 13 Mar 2025 15:52:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=X3VGzG4Mh/MC7W+0YUnT8HiyyfAP3dxfIX+1AWT4C7U=;
	b=B+iQzp8zquTcFOBHpff2chLd3DIA2+JFanvRcmJn0xGu5JM98V51fp7n9MfhChsBI0/ptgW+Gv75V
	 O4butionmKP7mWBhRry8c87PmHvI7g71mm+ny0rFrZU4cBJtjy4Mr4PvKQb4W95KMaZTqFtgbl1hk1
	 pG0WUyMjD+emaf+E=
X-KPN-MID: 33|HiPok5s7K+7loRf9S3wnz3RqDp28mwHxcOnYPgMKUgXqwBjijTSi4SwK5Am0nqX
 yGk+MZkt8/zI51ePKWQ+Pp7f28n7jbAS6Q2r1DbXaxso=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|BvSjyWWfcVP+8xnIdNg68SzBCN+ARt+iO4Q+h0AVnCEB6HbUZPxDuYg0PzmN7HV
 B3evmLsiPNTUVJFzn+9Mn9g==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id b9c53a12-001a-11f0-958c-005056abf0db;
	Thu, 13 Mar 2025 15:52:03 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH] swapon: make options --help and --version override --summary
Date: Thu, 13 Mar 2025 15:51:49 +0100
Message-ID: <20250313145149.10323-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When -h or --help is among the given options, most utilities
print a help text, ignoring all other options and arguments.
Make `swapon --summary --help` conform to this general pattern.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/swapon.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index 419155d67..f7f82bbfb 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -145,6 +145,7 @@ struct swapon_ctl {
 		no_heading,		/* toggle --show headers */
 		raw,			/* toggle --show alignment */
 		show,			/* display --show information */
+		summarize,		/* display summary of swap use */
 		verbose;		/* be chatty */
 };
 
@@ -965,8 +966,8 @@ int main(int argc, char *argv[])
 			ctl.fix_page_size = 1;
 			break;
 		case 's':		/* status report */
-			status = display_summary();
-			return status;
+			ctl.summarize = 1;
+			break;
 		case 'v':		/* be chatty */
 			ctl.verbose = 1;
 			break;
@@ -1007,6 +1008,11 @@ int main(int argc, char *argv[])
 	}
 	argv += optind;
 
+	if (ctl.summarize) {
+		status = display_summary();
+		return status;
+	}
+
 	if (ctl.show || (!ctl.all && !numof_labels() && !numof_uuids() && *argv == NULL)) {
 		if (!ctl.ncolumns) {
 			/* default columns */
-- 
2.48.1

