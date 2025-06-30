Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6588226165
	for <util-linux@vger.kernel.org>; Mon, 30 Jun 2025 08:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751272890; cv=none; b=TRUK7Xyd/5rMRMqmO9HFGk+Yum3ZK9AK3zMoWPuqlt4LjCioOSaJsCXCDi8ySHWogsrnPbRh66srwbTaBKIO6kbMoK3euYYLSqVYeULviTarBfxvVWUaSkEeGiyh7G/0nXtlL7B5ISuvJR0hw/BnAwoE+tRmNxsOvG4boPy4qHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751272890; c=relaxed/simple;
	bh=pl7WjjgX6h5s7y330EY+GOCYWqkIrh+u4yyri5v6WZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jMaQ2V9yaKhawmq7vQSN+gkUzZv3pVXjLevMedK9iCJw1luuG4hfzVTNucL/WseXNIoxkkn1iDe8AXqYJUfChKh8j56LRNwTIyTC8NNoEo7WDebFd5PdiusOSnXfc9/A3+14mDAnHmeEPwm7pl7i0T8RMf4TjUTksZva4EyPp5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=wuYl3/dJ; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="wuYl3/dJ"
X-KPN-MessageId: 20a794e8-558e-11f0-bc2f-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 20a794e8-558e-11f0-bc2f-005056ab378f;
	Mon, 30 Jun 2025 10:42:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:mime-version:message-id:date:subject:to:from;
	bh=RZ0nTVKJyCKJ6jbtadVi5M3qz+s06SkBmXn8HEU0+vg=;
	b=wuYl3/dJJ8Ki4Ik5ecmVExSlhzz44YqAV+Y0uVdfVCCQ4qEgoC61lEK9+Eca3HQK5H5Hc1L3RoXgX
	 X1JhL+U/9t/3BUMU8lDflp0Holv9BJG1dWVVN/WnCgmhAYCC+IXPmSytgGg/uZpSG8REDIriJoQ0zs
	 9wcYCNOARjr8IcB8=
X-KPN-MID: 33|hjbxlTeetOf/NJqXSZtz96YlFtBcrSQGwNAxeLdup+SRNh29AtHORA4fyziw3lG
 9/gAkvwqyiJi/Rft+ExVfX4mCX39nz68mUdclbBe1xtU=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|VxTuLU5gq4qLKRhs3JE4QmYZKCWw+KCw3xdDrEqo/HKx33ZuyyQjC1whPAOwgre
 N6E99p4PAsFqlpwu7oqoeYg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id fe2dae71-558d-11f0-9c87-005056ab7447;
	Mon, 30 Jun 2025 10:41:19 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH 2/4] chrt: do not try to interpret the --pid option itself as a PID
Date: Mon, 30 Jun 2025 10:40:48 +0200
Message-ID: <20250630084052.11041-2-bensberg@telfort.nl>
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

When not specifying a PID with --pid, `chrt` would report:

  chrt: invalid PID argument: '--pid'

That was silly.  After this change, `chrt --pid` will report:

  chrt: too few arguments

CC: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 schedutils/chrt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index 4c45eae80..8ed4d69f3 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -474,6 +474,8 @@ int main(int argc, char **argv)
 			policy_given = true;
 			break;
 		case 'p':
+			if (argc - optind == 0)
+				errx(EXIT_FAILURE, _("too few arguments"));
 			errno = 0;
 			/* strtopid_or_err() is not suitable here; 0 can be passed.*/
 			ctl->pid = strtos32_or_err(argv[argc - 1], _("invalid PID argument"));
-- 

Dobjátok a Dunába a kis diktátort.

2.48.1

