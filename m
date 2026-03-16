Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6272773CA
	for <util-linux@vger.kernel.org>; Mon, 16 Mar 2026 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773659413; cv=none; b=bsYtTethzYaX7xld05NdkfMb0640SzZmfkT9RNpGV5OQ60yT9LJ6pzWxKX9HIf5oCHu+ruVV44viDB2PWZoR8fPPJBOwasKAnfR9I4JQMrhp4UpnrJQ0u1SEtA/NBpx07FAzIOuTfHnoUmE1PZhSWOqHHkOyd5/og994tL1/GLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773659413; c=relaxed/simple;
	bh=d2pNoO4iazplm9yndTAG43msxkFGFKiRRv8unFy0zpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QfRuKfewgO/xfmx9qRFIHuMniBHHX5zJmrPbSGJnY4mWceTFUVJJVxaGk7ehBksG/demnJpi8a1TcUnpiXnb91Rd95b9wY0+saRMC+VfMjEhl8EwSyjbPbC6VE/gplIhjjrz/FuV69DwrN3vjKiqg/cR8H/8XG/H+8IdoYqdkJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=YLmV8KZf; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="YLmV8KZf"
X-KPN-MessageId: b257413a-2128-11f1-8a99-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id b257413a-2128-11f1-8a99-005056ab378f;
	Mon, 16 Mar 2026 12:10:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=9gbxYyTRHqX6cQ4Rc8RneK7gvQBoBRypCpJIII2vA2M=;
	b=YLmV8KZfeSey/mkkiRLoWqA13XA3Bu5lEcw4u1mevu7C+GgeBuGVY9FZo7maI5MXI8S7kQ+l2U2ba
	 SIOgCRx9XUdzwpWeGZOZJoMPA/GrZClvRCKeAZyhK3M0bOko7mzN8mgNeWVwUQ2z6WCpdnkFtQybW7
	 I4fDm/YJEwiWzbq0=
X-KPN-MID: 33|UK5ZwO29NkwG2xv7LSGvlak0D9EYOAGvToIbSvK/UsNmtPaubDm/FE2jBsFyeaU
 gUc6hTls5Tyqfnns8gT9dMyB1PH42bhoSWpSJPbaN0Qw=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|egtJA/nPi4QQ0mU/SWqQv31MH5vDaZab1ux7ivtkc9oUf07My1yoUIll/HqIA16
 RyjXsOGrrUFVnHLX4jToFOA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id b2292b41-2128-11f1-b8e4-005056ab7584;
	Mon, 16 Mar 2026 12:10:09 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Dick Marinus <dick@mrns.nl>
Subject: [PATCH 2/2] copyfilerange: simply report "too few arguments", not misleading messages
Date: Mon, 16 Mar 2026 12:09:38 +0100
Message-ID: <20260316110938.5119-2-bensberg@telfort.nl>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316110938.5119-1-bensberg@telfort.nl>
References: <20260316110938.5119-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running ./copyfilerange without any arguments would report:

  copyfilerange: source file is required

giving the impression that only a source file is required.
But running ./copyfilerange with one argument would report:

  copyfilerange: destination file is required

giving the impression that specifying two files would be enough.
But running ./copyfilerange with two arguments would report:

  copyfilerange: nothing to do, no ranges supplied

Instead of these custom messages, let's report what other tools
report when given too few arguments: "too few arguments".

This change also prevents `copyfilerange` from creating an empty
destination file when given just two arguments, when it reported
that there was nothing to do.

Furthermore, correct a parameter of a call of err(),
from `argv[2]` to `range.out_filename`.

CC: Dick Marinus <dick@mrns.nl>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/copyfilerange.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/misc-utils/copyfilerange.c b/misc-utils/copyfilerange.c
index 71b21bb28..2ebe43b3b 100644
--- a/misc-utils/copyfilerange.c
+++ b/misc-utils/copyfilerange.c
@@ -244,27 +244,20 @@ int main(const int argc, char **argv)
 			range.out_filename = argv[rem_optind];
 	}
 
-	if (!range.in_filename)
-		errx(EXIT_FAILURE, _("source file is required"));
-
-	if (!range.out_filename)
-		errx(EXIT_FAILURE, _("destination file is required"));
+	if (!range.out_filename || (rem_optind == argc && !nrange_files))
+		errx(EXIT_FAILURE, _("too few arguments"));
 
 	range.in_fd = open(range.in_filename, O_RDONLY);
 	if (range.in_fd < 0)
 		err(EXIT_FAILURE, _("cannot open source %s"), range.in_filename);
 
-
 	if (fstat(range.in_fd, &sb) == -1)
 		err(EXIT_FAILURE, _("cannot determine size of source file %s"), range.in_filename);
 	range.in_st_size = sb.st_size;
 
 	range.out_fd = open(range.out_filename, O_WRONLY | O_CREAT, 0666);
 	if (range.out_fd < 0)
-		err(EXIT_FAILURE, _("cannot open destination %s"), argv[2]);
-
-	if (rem_optind == argc && !nrange_files)
-		errx(EXIT_FAILURE, _("nothing to do, no ranges supplied"));
+		err(EXIT_FAILURE, _("cannot open destination %s"), range.out_filename);
 
 	if (nrange_files)
 		handle_range_files(&range, nrange_files, range_files);
-- 
2.53.0

