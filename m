Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFC672610
	for <util-linux@vger.kernel.org>; Thu,  3 Jul 2025 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554121; cv=none; b=rgtCx40n0ZPxqxVr0nhsx+2nDW21/HxeMw/53CZtWMaSwVQaT7bydC3ZrppZh6KTH7ILaWtkWOfohk9e7DF1TmNLKJPT5U2Mp2g6aR4Xwo2MaHCIdaQmCZOOsxpimoToPAO5mvQXIhvAJmZbyI4iT2zbhHRqBse2yVXoNQOZjyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554121; c=relaxed/simple;
	bh=VnysAa4+1AC1z+3scPY3N3S2jEFdTTcP3MFVOxga7pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGFRECjA/SuymV8GsX2K7UJP8goJ0qwVnMw/9idYGMsSak2Pu2XN2tzMl5ctn2kWF2LaWtZ86+H+keCotMnzVNWibgPlu7Hxv0QZqvfEhG74WidmDpESKyVtmqd/vOmDUxhDKzjqbfIGEp+IozMzU0oFlZIOdBY3aq34JbOGajk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=FvvtSmAK; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="FvvtSmAK"
X-KPN-MessageId: ec9a2bdc-581c-11f0-bc2f-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id ec9a2bdc-581c-11f0-bc2f-005056ab378f;
	Thu, 03 Jul 2025 16:49:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=p4SqJsYVFLuxbDeATCu/bswjSJ940vWs8yNUYCS+Ib4=;
	b=FvvtSmAKg5Cn2s90e3Tkm66QM87NDuBuwfP67ni3ecnSssVbaG2mBkJ98sZoGkGrseRszSSjhojwo
	 mycBiJ7Mh1xTUfh0X4NPDletOOum9OkKgZx82YaXCAt5X87xJ3kcOMb9rEvgtUp0Hf0m7hGqO6b/tc
	 hkdziF4g0IYLsHgQ=
X-KPN-MID: 33|hRddNYN57BEn9vHS0Ss1msMAehbBqGEkzWJK3WY9m3Lx+93mQ0F6yjHbL+pv9x6
 +ib4bOGnpJvGKkFfkKcT2b+NoFjivRqPOy8r1GQbu+D8=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|E3R6YPQ0wSPnW+K92kwqb1ITZo9hEnN33M+WttIPpJ5fGAy4QpcFXT1UAMCIaAQ
 pR+powi9/kWlBe9zOxrkzzg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id c8901642-581c-11f0-9c45-005056ab1411;
	Thu, 03 Jul 2025 16:48:29 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH 4/4 V2] chrt: do not try to interpret any other option as a PID either
Date: Thu,  3 Jul 2025 16:47:52 +0200
Message-ID: <20250703144752.29971-4-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250703144752.29971-1-bensberg@telfort.nl>
References: <20250703144752.29971-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When doing, for example, `chrt --pid --max`, it would report:

  chrt: invalid PID argument: '--max'

This mistakenly gave the impression that the PID argument has to follow
directly after the --pid option.

Avoid this by delaying the parsing of a PID until after all options have
been parsed.  Temporarily set 'ctl->pid' to zero to indicate that a PID
needs to be read.

After this change, `chrt --pid --max` will simply report the minimum and
maximum valid priorities.  And `chrt --pid -v`:

  chrt: too few arguments

Also, add a missing call of gettext() for the other error message.

CC: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 schedutils/chrt.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index 731f995bb..10ba7fbf6 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -474,11 +474,7 @@ int main(int argc, char **argv)
 			policy_given = true;
 			break;
 		case 'p':
-			if (argc - optind == 0)
-				errx(EXIT_FAILURE, _("too few arguments"));
-			errno = 0;
-			/* strtopid_or_err() is not suitable here; 0 can be passed.*/
-			ctl->pid = strtos32_or_err(argv[argc - 1], _("invalid PID argument"));
+			ctl->pid = 0;  /* indicate that a PID is expected */
 			break;
 		case 'r':
 			ctl->policy = SCHED_RR;
@@ -507,20 +503,22 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (argc - optind < (ctl->pid > -1 ? 1 : 2)) {
+	if (argc - optind < (ctl->pid == 0 ? 1 : 2)) {
 		warnx(_("too few arguments"));
 		errtryhelp(EXIT_FAILURE);
 	}
 
-	/* pid exists but priority not given */
-	if (ctl->pid > -1 && argc - optind == 1) {
-		/* Error if priority is missing for a policy that requires it */
-		if (policy_given && need_prio)
-			errx(EXIT_FAILURE, ("policy %s requires a priority argument"),
+	/* If option --pid was given, parse the very last argument as a PID. */
+	if (ctl->pid == 0) {
+		if (need_prio && argc - optind < 2)
+			errx(EXIT_FAILURE, _("policy %s requires a priority argument"),
 						get_policy_name(ctl->policy));
+		errno = 0;
+		/* strtopid_or_err() is not suitable here, as 0 can be passed. */
+		ctl->pid = strtos32_or_err(argv[argc - 1], _("invalid PID argument"));
 
-		/* If no policy specified, show current settings */
-		if (!policy_given) {
+		/* If no policy nor priority was given, show current settings. */
+		if (!policy_given && argc - optind == 1) {
 			show_sched_info(ctl);
 			return EXIT_SUCCESS;
 		}
-- 
2.48.1

