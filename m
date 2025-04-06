Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7144D218593
	for <util-linux@vger.kernel.org>; Sun,  6 Apr 2025 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743952948; cv=none; b=NZ6313YfK/Ep0RWgDCJkVboqB3HsxaHAQSnJx9JxQd7mG0B3dTJBbed5XwJYNNqiRd6ZPRhM6L1nna0TReVcWu9VJVQWJRFaTLEeX9lviyCjCPTaT/ATL2K1FaSUN1WjL9EBj/MOT5Yfmwd++ZbR2IqeJXGAVyQ2RZZpsJJmWjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743952948; c=relaxed/simple;
	bh=yNNgxFAgKYsDn20iUeSGCt8V7hyl9qocwoRdhn5F/q0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfjYq2J7nGeoMhitS1WedZ/GIVf2OhafvJoOlsbH+rIEcnlrhhPEmXD6+R/qD3f756ZTpG7pxJk4p7joACqXGptj4eTSnLbsns4RZA/ef49swTP4L7b+ZOORuug7fx3W2ivyIgXyLiDDkDaxu598X3j8kgHZOP0RlDfGlKT/i44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=DxxcJCxZ; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="DxxcJCxZ"
X-KPN-MessageId: 068a02e5-12fb-11f0-86cb-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 068a02e5-12fb-11f0-86cb-005056aba152;
	Sun, 06 Apr 2025 17:23:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=zrteOTP84J1coEjS02/3xq6BJZJZXadJtQEpIzpaEEk=;
	b=DxxcJCxZdjduJiyuaV074fts5f0wntUTn9DneXa+7+AVYDMe/7KLFUQTAb6WxVEWnIzlzZz0skFa+
	 L/KUrU32LL/+OA5OyR2BmhXY1HZchoxEAwWge45eefkg6ymnw3n/RUqFogECAsnhUBS3BT2k5YJKRV
	 1C9XB722AmPPY/E4=
X-KPN-MID: 33|HfJlfjlYC5cHrQncF04fuN/N5Kyn+F9OiP27hZdkN1E4+Ufry39Vx5OstqoPwu6
 kLClmkGE6vHcWOEW/gviOz0ntu5uhtXu5gVonkNe5foY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|rTk0+jurzqYm5sWjHOA7duhYZa0v6sHFXPXtktmmxfceylevHqlSLmYdvtoqxOF
 DH09YK8VBfCmlAlVJqifTYw==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id f126a691-12fa-11f0-9b61-005056ab1411;
	Sun, 06 Apr 2025 17:22:24 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/4] zramctl: (man) mention the required arguments for -p and -r
Date: Sun,  6 Apr 2025 17:21:47 +0200
Message-ID: <20250406152147.9225-4-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250406152147.9225-1-bensberg@telfort.nl>
References: <20250406152147.9225-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also, sort the options strictly alphabetically ("r" before "raw").

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/zramctl.8.adoc | 15 +++++++++------
 sys-utils/zramctl.c      |  4 ++--
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/sys-utils/zramctl.8.adoc b/sys-utils/zramctl.8.adoc
index 4cc402e5c..c08f1e005 100644
--- a/sys-utils/zramctl.8.adoc
+++ b/sys-utils/zramctl.8.adoc
@@ -54,18 +54,21 @@ Define the status output columns to be used. If no output arrangement is specifi
 +
 The default list of columns may be extended if _list_ is specified in the format _+list_ (e.g., *zramctl -o+COMP-RATIO*).
 
-*-p*, *--algorithm-params*::
-Set the algorithm parameters, for example, *level=9 dict=/etc/dictionary* to set compression level and pre-trained dictionary. Parameters are algorithm specific.
-
 *--output-all*::
 Output all available columns.
 
+*-p*, *--algorithm-params* _parameter_...::
+Specify the parameters for the selected compression algorithm.
+For example, *level=9 dict=/etc/dictionary* sets the compression level
+and pre-trained dictionary. Parameters are algorithm-specific.
+
+*-r*, *--reset* _zramdev_...::
+Reset the specified zram device(s).
+The settings of a zram device can be changed only after a reset.
+
 *--raw*::
 Use the raw format for status output.
 
-*-r*, *--reset*::
-Reset the options of the specified zram device(s). Zram device settings can be changed only after a reset.
-
 *-s*, *--size* _size_::
 Create a zram device of the specified _size_. Zram devices are aligned to memory pages; when the requested _size_ is not a multiple of the page size, it will be rounded up to the next multiple. When not otherwise specified, the unit of the _size_ parameter is bytes.
 +
diff --git a/sys-utils/zramctl.c b/sys-utils/zramctl.c
index b9ea5998e..fdb173ea5 100644
--- a/sys-utils/zramctl.c
+++ b/sys-utils/zramctl.c
@@ -751,9 +751,9 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -n, --noheadings          don't print headings\n"), out);
 	fputs(_(" -o, --output <list>       columns to use for status output\n"), out);
 	fputs(_("     --output-all          output all columns\n"), out);
-	fputs(_(" -p, --algorithm-params <parameters>\n"
+	fputs(_(" -p, --algorithm-params <parameter>...\n"
 		"                           parameters for the compression algorithm\n"), out);
-	fputs(_(" -r, --reset               reset all specified devices\n"), out);
+	fputs(_(" -r, --reset <device>...   reset the specified zram devices\n"), out);
 	fputs(_("     --raw                 use raw status output format\n"), out);
 	fputs(_(" -s, --size <size>         device size\n"), out);
 	fputs(_(" -t, --streams <number>    number of compression streams\n"), out);
-- 
2.48.1

