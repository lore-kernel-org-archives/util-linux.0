Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BBC23F40A
	for <util-linux@vger.kernel.org>; Mon, 30 Jun 2025 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751272895; cv=none; b=U5z/ewHdCEbi0J2BB5EVqJ0P224w5sWVU74yY6yoDEPP0aY07FdQ1rVbRIY48uzd7V9k4iFJOPuYLo2Wl9XX+r31b5jjmM+Rr1fnThQcZKiSx4oXJFkD/PBNanNNoh2xy/HS3iY+v5pOjmIZn+KR3GNEKdQSrJi5Sw9lgx0XrVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751272895; c=relaxed/simple;
	bh=2Y7Bd+kVzHdYvcQcltM1YnI7dmBRJBwPggCcChzPS1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2sX3LiGs7e38BvRtu9T7iysHQWkIJXsmwbuEe/mRv/UpZVoXj8cL8QkRGuDXx3x5/AMBlMvVXNePpfsJhdMJTE6VBkI2JVRFLycy8eptgt1EzfW8Zw8UFz5prbDxYzOAe504ZiUWKoto3KLY2tsFmbF+GQIghzFvBHyrRS8bdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=nvDt9RFf; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="nvDt9RFf"
X-KPN-MessageId: 33227e5b-558e-11f0-b9a4-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 33227e5b-558e-11f0-b9a4-005056abbe64;
	Mon, 30 Jun 2025 10:42:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:mime-version:message-id:date:subject:to:from;
	bh=FPwL9wjzbA1SlWXPowrIsct9WlTdbv1VEc5BLfNBLYQ=;
	b=nvDt9RFflsjCKVe4+X4VrrjIeLeLzat27o42h26K8MTWlwOEO6tGDO9R3aBNhN982RAnoqE5axCXq
	 9KyZVRxcZPuhnng6Fu5Xvdrm1PMgm/amrAFE+Q+ig3ik26pHdF4GTZ3dU0bSNU5qTMvGAYmz0MrcuH
	 YyFsjCAH+Og5RbZ0=
X-KPN-MID: 33|9jYFC4yE+WVw67SZLDd1nIV/mysDK3jTF+EYqc/eCCuNZu3zsfy07rfwb3PWWrq
 t6NmE8qm1tK8YLcCEmBU+Bt2w/KARTpWVew85jhbBkUU=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|M1ny7SoojRKIujRxgZjJTw/8mIK2r+DKt0VifKe55mqTYWdPSzJkcSOD/s1BR8U
 w0zsWdY8BvrrPZ4ChZXasZg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 024598e6-558e-11f0-95b7-005056abf0db;
	Mon, 30 Jun 2025 10:41:26 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH 3/4] chrt: simplify the other check for too few arguments
Date: Mon, 30 Jun 2025 10:40:49 +0200
Message-ID: <20250630084052.11041-3-bensberg@telfort.nl>
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

Without option --pid, always at least two arguments are needed:
the <priority> value and a <command>.  (The 'need_prio' variable
is relevant only for the --pid case.)

Also, make the error message more informative, and do not annoyingly
suggest that the user try `chrt --help`.

CC: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 schedutils/chrt.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index 8ed4d69f3..f5ecae6e1 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -507,11 +507,8 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (((ctl->pid > -1) && argc - optind < (need_prio ? 1 : 0)) ||
-	    ((ctl->pid == -1) && argc - optind < (need_prio ? 2 : 1))) {
-		warnx(_("bad usage"));
-		errtryhelp(EXIT_FAILURE);
-	}
+	if (argc - optind < (ctl->pid > -1 ? 1 : 2))
+		errx(EXIT_FAILURE, _("too few arguments"));
 
 	/* pid exists but priority not given */
 	if (ctl->pid > -1 && argc - optind == 1) {
@@ -530,11 +527,10 @@ int main(int argc, char **argv)
 	if (ctl->verbose)
 		show_sched_info(ctl);
 
-	errno = 0;
-
-	if (need_prio || argc - optind > 1)
+	if (argc - optind > 1) {
+		errno = 0;
 		ctl->priority = strtos32_or_err(argv[optind], _("invalid priority argument"));
-	else
+	} else
 		ctl->priority = 0;
 
 	if (ctl->runtime && !supports_runtime_param(ctl->policy))
-- 

Dobjátok a Dunába a kis diktátort.

2.48.1

