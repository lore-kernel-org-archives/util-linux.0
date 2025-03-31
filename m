Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06011DE3C7
	for <util-linux@vger.kernel.org>; Mon, 31 Mar 2025 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743414309; cv=none; b=ZXilYnqDeBWRIBIpQxDzCrKE3EVlEoDT2g0v6hSN9bwtMRERZxDyyJYoEoDklG1B70GJEWUbY70Ps0Oqijr2tUq+aYrYOR1RXPmmYzB/0PLiIDYSNw2w9pzLd9I0OWIvDpzr87D+fgH38Th5nB9ynCAnklOHn5hnak5Jj6zTNRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743414309; c=relaxed/simple;
	bh=OAULgm1k1R0Bg0qsIw3jOHtHvrees9FFTcrWwSHvM5A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTteGbnr3+u8czWTRB2w0qDUPAUPcEnEXa9/0dpuwkdPwHbz/YRvxLiOaO/+dhJK1+GJVQMRxBAwaNKtM8cjq0KpxAcMk8QGEnwV5UO9YwPkjD5ofKmFDgA5HN5re+Z8lNl1TU1k+ZiMQ6A60J/WQ0ypop2NQJx0ZvrDlF3DocI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=dWFZj3W1; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="dWFZj3W1"
X-KPN-MessageId: e04edeac-0e14-11f0-bc28-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id e04edeac-0e14-11f0-bc28-005056ab378f;
	Mon, 31 Mar 2025 11:45:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=ks4qjTjEX6obfOGllkLd5VFR5Bk1Sn9Y1Ybkd0CFKQk=;
	b=dWFZj3W10JyaOgGHpAbI9Z8AbQ2qm8KF1zpWuQr3WGXwLHJ0y5YPUcwkhhE4bgAde990x0GjxOopi
	 /5zxNkRXFSTCn622IALlLlP3Y6MI7Qcc/CltU3p++L8fmNfzZQQRoO5iewHp9yDTi4w7FgWEyg2Qzp
	 NyltfcahMwnd9MRY=
X-KPN-MID: 33|mP9BnZRt2Q5jEJFfC0OlNWVEGddXDToEf1rAIvtyhh9nNuRhJVax/t4QEzU9hi1
 CjnegpSBQZVNlHuBoWPnBhQTbPmuwqjnjgxkaSoLDW4g=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|pjQlkfLsxyBO5nST4Lxf4I/zgAaO/Tqyk1K3MF96AV3Kld+ArqUoB5GPYb7eUQf
 J+I/aTiUJQuiGQOD43B9aJA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id cf0df994-0e14-11f0-8516-005056ab7584;
	Mon, 31 Mar 2025 11:44:58 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 02/10] uclampset: simplify the synopsis in the --help usage text
Date: Mon, 31 Mar 2025 11:44:35 +0200
Message-ID: <20250331094443.9619-2-bensberg@telfort.nl>
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

The synopsis cannot express all possible forms of the command and still
stay readable, so do not even try.  Giving one, single synopsis is far
clearer.  Also, unabbreviate two words in the option descriptions.

Also, improve the markup and the wording in the man page.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 schedutils/uclampset.1.adoc | 4 ++--
 schedutils/uclampset.c      | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/schedutils/uclampset.1.adoc b/schedutils/uclampset.1.adoc
index 955881907..b3cdb4e7f 100644
--- a/schedutils/uclampset.1.adoc
+++ b/schedutils/uclampset.1.adoc
@@ -38,9 +38,9 @@ manipulate the utilization clamping attributes of the system or a process
 
 == SYNOPSIS
 
-*uclampset* [options] [*-m* _uclamp_min_] [*-M* _uclamp_max] _command argument_
+*uclampset* [options] [*-m* _minimum_] [*-M* _maximum_] *-p* _PID_
 
-*uclampset* [options] [*-m* _uclamp_min_] [*-M* _uclamp_max_] *-p* _PID_
+*uclampset* [options] [*-m* _minimum_] [*-M* _maximum_] _command_ [_argument_...]
 
 == DESCRIPTION
 
diff --git a/schedutils/uclampset.c b/schedutils/uclampset.c
index 4b37557a1..3aa198568 100644
--- a/schedutils/uclampset.c
+++ b/schedutils/uclampset.c
@@ -54,22 +54,22 @@ static void __attribute__((__noreturn__)) usage(void)
 
 	fputs(USAGE_HEADER, out);
 	fprintf(out,
-		_(" %1$s [options]\n"
-		  " %1$s [options] --pid <pid> | --system | <command> <arg>...\n"),
+		_(" %1$s [options] --pid <pid> | <command> [<arg>...] | --system\n"),
 		program_invocation_short_name);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_("Show or change the utilization clamping attributes.\n"), out);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -m <value>           util_min value to set\n"), out);
-	fputs(_(" -M <value>           util_max value to set\n"), out);
+	fputs(_(" -m <value>           minimum utilization value to set\n"), out);
+	fputs(_(" -M <value>           maximum utilization value to set\n"), out);
 	fputs(_(" -a, --all-tasks      operate on all the tasks (threads) for a given pid\n"), out);
 	fputs(_(" -p, --pid <pid>      operate on existing given pid\n"), out);
 	fputs(_(" -s, --system         operate on system\n"), out);
 	fputs(_(" -R, --reset-on-fork  set reset-on-fork flag\n"), out);
 	fputs(_(" -v, --verbose        display status information\n"), out);
 
+	fputs(USAGE_SEPARATOR, out);
 	fprintf(out, USAGE_HELP_OPTIONS(22));
 
 	fputs(USAGE_SEPARATOR, out);
-- 
2.48.1

