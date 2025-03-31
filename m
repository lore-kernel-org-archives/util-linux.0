Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9F718B46E
	for <util-linux@vger.kernel.org>; Mon, 31 Mar 2025 09:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743414352; cv=none; b=d9rmtDIG+i9+L911E4jI3rbPIVOCIJqRfTWbDSGrEF82cpGnP3h4hraWc3+RkaK9/ozijLsVzzZkiDO2mBlYqZQZs+RaEeMzDZc2G9qjNoekmPFmUUocirOO8ojIBDkZ574qisl14aUWLF0nUAVLtsWeVCF9e4wFp6hiZuQvX1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743414352; c=relaxed/simple;
	bh=EubfCZeaMjOtRvpW836kYqm1COgIe6BZlxpSPsRyh64=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRePkTNpqRJPRV1/OZLhWxUd7KQJDbXLE7wsPWhYz+NWw+41X2L4rhLRW8nSt3Eky6XDRPnQc6axYS5RKhOleqwIcD4wcIIhkAOtY7/12njkbORJf/2RScDFnZNqlAjPYF6uXIV9JHzno0wZNyQpQbstu+1jORax3KgMTpMXsbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=jDOCF79S; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="jDOCF79S"
X-KPN-MessageId: febc05b5-0e14-11f0-86cb-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id febc05b5-0e14-11f0-86cb-005056aba152;
	Mon, 31 Mar 2025 11:46:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=DT47Hps7FbFsh/Gj0xchX4zyUR2GIvPdbwl7nlcEKww=;
	b=jDOCF79Ss3hzsRaUXJg0RptjJycV7qNZlbMWjZmyG2vzy+ksiVkHDTTXSmUvXYBnN50wQDbsOrbbO
	 xYZCtkCydTsIwi1oq+olqDZLtv4be9X/SKE+7ni5GxGciO5c4UTwHmC5qmSdvf3VAm1vp79IL0EKsp
	 1vdHhNqsP9CVpOyI=
X-KPN-MID: 33|FswoqN7m+pdJpyJ04afZeqESLsYKXZ629IKl5Hb+v8YW2s95wygjR/FUi9VNw2S
 qsqTm2XN3CXNHooRyXhmykjr5t36+IlIfp2X6EwUWw3k=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|uAOwQpg8WJJdPjYmgMlMsY6psZw0V/NBCI70vwYs1eIOTHGBTclBZGohJII2L2A
 jK1E1KZstrtgyiITo49IFOQ==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id ed87d164-0e14-11f0-9598-005056abf0db;
	Mon, 31 Mar 2025 11:45:49 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 08/10] lsblk: (man) remove the incorrect spaces between the arguments of --ct
Date: Mon, 31 Mar 2025 11:44:41 +0200
Message-ID: <20250331094443.9619-8-bensberg@telfort.nl>
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

Also, unabbreviate some needless abbreviations,
and improve some wordings and markup.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/lsblk.8.adoc | 52 +++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/misc-utils/lsblk.8.adoc b/misc-utils/lsblk.8.adoc
index 7a0a15d3a..742fe5f68 100644
--- a/misc-utils/lsblk.8.adoc
+++ b/misc-utils/lsblk.8.adoc
@@ -105,45 +105,51 @@ Produce output in the form of key="value" pairs. The output lines are still orde
 *-p*, *--paths*::
 Print full device paths.
 
-*-Q*, *--filter* _expr_::
-Print only the devices that meet the conditions specified by the expr. The
-filter is assessed prior to lsblk collecting data for all output columns. Only
+*-Q*, *--filter* _expression_::
+Print only the devices that meet the conditions specified by _expression_. The
+filter is assessed prior to *lsblk* collecting data for all output columns. Only
 the necessary data for the lazy evaluation of the expression is retrieved from
 the system. This approach can enhance performance when compared to
-post-filtering, as commonly done by tools such as grep(1).
+post-filtering, as commonly done by tools such as *grep*(1).
 +
-This feature is EXPERIMENTAL. See also *scols-filter*(5). For example
-exclude sda  and sdb, but print everything else ('!~' is a negative regular
-expression matching operator):
+This feature is EXPERIMENTAL. See also *scols-filter*(5).
++
+For example, to exclude sda and sdb, but print everything else
+('!~' is a negative regular-expression matching operator):
 ____
  lsblk --filter 'NAME !~ "sd[ab]"'
 ____
 
-*--highlight* _expr_::
-Colorize lines matching the expression.
+*--highlight* _expression_::
+Colorize lines matching _expression_.
++
 This feature is EXPERIMENTAL. See also *scols-filter*(5).
 
-*--ct* _name_ [: _param_ [: _function_ ]]::
-Define a custom counter. The counters are printed after the standard output.
-The _name_ is the custom name of the counter, the optional _param_ is the name of the column
-to be used for the counter, and the optional _function_ specifies
-the aggregation function, supported functions are: count, min, max, or sum. The
-default is count.
+*--ct* _name_[**:**_parameter_[**:**_function_]]::
+Define a custom counter. Custom counters are printed after the standard output.
+The _name_ is the custom name of the counter, the optional _parameter_ is the name
+of the column to be used for the counter, and the optional _function_ specifies
+the aggregation function. Supported functions are: *count*, *min*, *max*, *sum*.
+The default function is *count*. If _parameter_ is not specified, then the counter
+counts the number of lines.
 +
-If the _param_ is not specified, then the counter counts the number of lines. This
-feature is EXPERIMENTAL. See also *--ct-filter*.
+This feature is EXPERIMENTAL. See also *--ct-filter*.
 +
-For example, *--ct MyCounter:SIZE:sum* will count the summary for SIZE from all lines;
-and to count the number of SATA disks, it is possible to use:
+For example, *--ct MyCounter:SIZE:sum* reports the total of the SIZE values.
+To report the number of SATA disks, one can use:
 ____
 
- lsblk --ct-filter 'TYPE=="disk" && TRAN=="sata"' --ct "Number of SATA devices"
+ lsblk --ct-filter 'TYPE=="disk" && TRAN=="sata"' \
+       --ct "Number of SATA devices"
 ____
 
 
-*--ct-filter* _expr_::
-Define a restriction for the next counter. This feature is EXPERIMENTAL. See also *--ct*
-and *scols-filter*(5). For example, aggregate sizes by device type:
+*--ct-filter* _expression_::
+Define a restriction for the next counter.
++
+This feature is EXPERIMENTAL. See also *--ct* and *scols-filter*(5).
++
+For example, to aggregate sizes by device type:
 ____
  lsblk --ct-filter 'TYPE=="part"' --ct Partitions:SIZE:sum \
        --ct-filter 'TYPE=="disk"' --ct WholeDisks:SIZE:sum
-- 
2.48.1

