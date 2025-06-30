Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBD8242D6C
	for <util-linux@vger.kernel.org>; Mon, 30 Jun 2025 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751272897; cv=none; b=Bkm+y78WQxJGe+/OBZbwNDuGx5PfYn6gCSf60nopiYIWZJbMu0LHigJoWj7dsej6vwTojaI2WxGZM4QQNy/QEkKCeyGVXCPVQNKOkhJxsUY+DlYPEQFI6brtRLYDXtW+Vna7U7L29V4bfr1B1IDxAcCTFPxRPytpr+w8Jha5Z7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751272897; c=relaxed/simple;
	bh=8Wy6AZGMbEAdfUKIqmU0ErxoH2mgnRE/FrovbbxYCZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxgW3WLwJbo8rsHPFWbrx/Fyj1iulSRiGK2hzx/HVnpfwEJuAk9YVz0tYp3aRWGoAYyxNpLrpdoatc8JxrYkwJgbJo7+mr3Z8WkTOAHrRxS6zVpoNj8HOz47ZOZvze+jZQlW6noX5PlPuDh/KMCh0BKyvEvhVQjgHEOTemLl/4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=g4CsN8SV; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="g4CsN8SV"
X-KPN-MessageId: 376b8f44-558e-11f0-b9a4-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 376b8f44-558e-11f0-b9a4-005056abbe64;
	Mon, 30 Jun 2025 10:42:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:mime-version:message-id:date:subject:to:from;
	bh=MdBzC2g5DeSYQ1uvPX/ODycJZWSC8wCkMl5a3PDqdgw=;
	b=g4CsN8SVb9ZNX177LejKYdKr0Qvabqs/C/P4atPySMFFm/rvHO7ooOacMkTlvbRypuyqwHhSRRrut
	 8y6h4OgJtD2YgFS3PCEDsKffyfZSJtxhj2hvoxoUx5PGSeee9LfZRVLAHO+peRBUurn/VPxSdHY2AU
	 oqEEXprfSeSt13UM=
X-KPN-MID: 33|9oWmBqab7/iXMMl8ZRNsBDnfJJ+zMsDFa3STdTnK6Ehm9aQXb2m3luQmCZKvlBo
 Bj9QAKgLXEjfBNfV+SfOsa/lPpv7b7wk9D6Dp8ittQZI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|0XI6qyxrJpFsnUu1E2rj/7Fv1jrJPfQrb6tjA38U0MLItPe0s33FMqznYsRWQdh
 HQ/oIrSUJ2aPeXq07LJu/xQ==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 06911d84-558e-11f0-95b7-005056abf0db;
	Mon, 30 Jun 2025 10:41:33 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH 4/4] chrt: do not try to interpret any other option as a PID either
Date: Mon, 30 Jun 2025 10:40:50 +0200
Message-ID: <20250630084052.11041-4-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250630084052.11041-1-bensberg@telfort.nl>
References: <20250630084052.11041-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index f5ecae6e1..f358bb273 100644
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
@@ -507,18 +503,20 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (argc - optind < (ctl->pid > -1 ? 1 : 2))
+	if (argc - optind < (ctl->pid == 0 ? 1 : 2))
 		errx(EXIT_FAILURE, _("too few arguments"));
 
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

Dobjátok a Dunába a kis diktátort.

2.48.1

