Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C307C13C3C4
	for <util-linux@vger.kernel.org>; Tue, 26 Mar 2024 15:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711468225; cv=none; b=gZ/7nLbw1GMDjnLGjWiER9i887MUarYvLmmJD0epPrhEGZ4xFOCUGG9OY50uLJOTYjarV7k0TNwAtt/bFweA7AsBByrrvmQlGXrSyNuTWqU0HfW6H3zaz75Zqlp16lMchI31HCDf7f+6KWM7x7lvRZIeFG5ct80X6gLEUvo+Emg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711468225; c=relaxed/simple;
	bh=ZOeTcIUV4HcxRQxtWjm6P52THbxAXApKazGsHIXRluY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MlTUUytYkRbRTRFOYy6dFuPiyQJUDw1KqpX3cHGX0sXzhEDOqDgt8l4qMdcuZdpiOTrluqQYEb31ff4Kais7/dlc9dmZ6juFEllrbaR5v1O8aGxnZ8kqOTPSEwgc/zlMBi7h8FM5bE4ejReZj2tHd2/QFvskLhtX/TarjceTvHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=eAvMJQwu; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="eAvMJQwu"
X-KPN-MessageId: 6568b17b-eb88-11ee-8fdf-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 6568b17b-eb88-11ee-8fdf-005056aba152;
	Tue, 26 Mar 2024 16:49:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=rzJqfgK6CIvWjj3WA8zfx04//JH00NV2EhtuQv1E8wE=;
	b=eAvMJQwuPARIHAJeIt1wfWrCgz5wXi1xHEgiUYZjXhfA7OGwkUtFAR5rYX9s+RlDb6Gm+IhUKk7dV
	 VoU4MvbzOLLr9ShezQxie/JPfVIEG5Px6c6ePbHcwA25tfb9pQI0ksp1vwLvWbj26wHzXvpUSFv+B5
	 eY20Nax4cpS5892I=
X-KPN-MID: 33|QAM6YUubhhTa/wnKYObTQAhEMYnwYp8WRDSyMx2pTOPEAwAwsVrnkWPW24JW4zj
 QXEmkSis9qGSMKC1b+CtQ3YUxqT/+m5S9V7heI6Sc7Pw=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|lJDB6i946wtxaV6h2NzIxpHSOqDcB0d6KJC7juTjE50JhZaK6BT0OVf5gXDpCGG
 lh/rYMs0Fza06ltgiX84J/w==
Received: from localhost (82-168-50-91.fixed.kpn.net [82.168.50.91])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 65a3e201-eb88-11ee-a20e-005056ab1411;
	Tue, 26 Mar 2024 16:49:15 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/2] lastlog2: begin descriptions of options with a lowercase letter
Date: Tue, 26 Mar 2024 16:48:22 +0100
Message-ID: <20240326154822.8959-2-bensberg@telfort.nl>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240326154822.8959-1-bensberg@telfort.nl>
References: <20240326154822.8959-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These descriptions are not full sentences and do not end with a period,
so they should not start with a capital either.
---
 misc-utils/lastlog2.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/misc-utils/lastlog2.c b/misc-utils/lastlog2.c
index 2b8365b40..7e511b036 100644
--- a/misc-utils/lastlog2.c
+++ b/misc-utils/lastlog2.c
@@ -108,15 +108,15 @@ static void __attribute__((__noreturn__)) usage(void)
 	fprintf(output, _(" %s [options]\n"), program_invocation_short_name);
 
 	fputs(USAGE_OPTIONS, output);
-	fputs(_(" -b, --before DAYS       Print only records older than DAYS\n"), output);
-	fputs(_(" -C, --clear             Clear record of a user (requires -u)\n"), output);
-	fputs(_(" -d, --database FILE     Use FILE as lastlog2 database\n"), output);
-	fputs(_(" -i, --import FILE       Import data from old lastlog file\n"), output);
-	fputs(_(" -r, --rename NEWNAME    Rename existing user to NEWNAME (requires -u)\n"), output);
-	fputs(_(" -s, --service           Display PAM service\n"), output);
-	fputs(_(" -S, --set               Set lastlog record to current time (requires -u)\n"), output);
-	fputs(_(" -t, --time DAYS         Print only lastlog records more recent than DAYS\n"), output);
-	fputs(_(" -u, --user LOGIN        Print lastlog record of the specified LOGIN\n"), output);
+	fputs(_(" -b, --before DAYS       print only records older than DAYS\n"), output);
+	fputs(_(" -C, --clear             clear record of a user (requires -u)\n"), output);
+	fputs(_(" -d, --database FILE     use FILE as lastlog2 database\n"), output);
+	fputs(_(" -i, --import FILE       import data from old lastlog file\n"), output);
+	fputs(_(" -r, --rename NEWNAME    rename existing user to NEWNAME (requires -u)\n"), output);
+	fputs(_(" -s, --service           display PAM service\n"), output);
+	fputs(_(" -S, --set               set lastlog record to current time (requires -u)\n"), output);
+	fputs(_(" -t, --time DAYS         print only lastlog records more recent than DAYS\n"), output);
+	fputs(_(" -u, --user LOGIN        print lastlog record of the specified LOGIN\n"), output);
 
 	fputs(USAGE_SEPARATOR, output);
 	fprintf(output, USAGE_HELP_OPTIONS(25));
-- 
2.42.1

