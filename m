Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CA422068A
	for <util-linux@vger.kernel.org>; Thu, 11 Dec 2025 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765469408; cv=none; b=AOO4h7HAq19i3ZhiJ1SUhQUDmieBrnj7ELOO6w/wR/RLkneKEw3zifTfw2HqCR7VHEiRGjf5Ffyh9+uD14fwnK3FQXnN+FRWkTybsEI9ayEEXn8OR5D1JSse7RpiYYPxsyhWYhrskeXJ7i3dZ5LKUrgt1ypY5CwJtLYMUpvcqzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765469408; c=relaxed/simple;
	bh=HR6JP2IMTzJMk+8nmqgF2G/T0Fv4lZiEphXia2o7l84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOZcDMneVw6k/IjA/60aTsPcBhyKtX1x+0xsr5wGRlLPhg7rH0HHbe7TY0a6k6KB5NNPFaTsSLKlvs2x5E2k1K3ewYX0g/X+nYNAxaCv5V8FuNwg2WFTSvJ706hHGlUgznckcencxo3zxuEJal596Fss/XO3lDqjZe1V2Ns7i/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MQRrczYO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQRrczYO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765469405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vcAtJtT+CmOOGWcbvIWXAllLYruJa4pW5eUesCmcya0=;
	b=MQRrczYOCin5WCXB5VTmjf+LO4FyOKy8CUq+wbH1+2Cn+5GiUKh73irOvdfURj1nx565bw
	pYsaJfWz8Tv8ugJ+g6q/1I7z76yiGKUXZXfUVOmKddQeXGnQa334vczPoHRhK9CSPgzj82
	O96GznFAchkYJr5KSbje/otLkOuXXEA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-CGRkBolPNN6Sn5jPvV_O7A-1; Thu,
 11 Dec 2025 11:10:01 -0500
X-MC-Unique: CGRkBolPNN6Sn5jPvV_O7A-1
X-Mimecast-MFC-AGG-ID: CGRkBolPNN6Sn5jPvV_O7A_1765469400
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C23021956068;
	Thu, 11 Dec 2025 16:10:00 +0000 (UTC)
Received: from localhost (unknown [10.2.16.208])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2DF8830001A2;
	Thu, 11 Dec 2025 16:09:59 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: util-linux@vger.kernel.org
Cc: pizhenwei@bytedance.com,
	hare@suse.de,
	kwolf@redhat.com,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 1/3] blkpr: prepare for _IOR() ioctls
Date: Thu, 11 Dec 2025 11:09:54 -0500
Message-ID: <20251211160956.1540114-2-stefanha@redhat.com>
In-Reply-To: <20251211160956.1540114-1-stefanha@redhat.com>
References: <20251211160956.1540114-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

parse_pr_command() returns the ioctl command constant for a given
command or -1 when the command is unknown. Up until now all ioctl
command constants were positive, so the following check worked:

  if (command < 0)
      err(EXIT_FAILURE, _("unknown command"));

The top two bits of ioctl command constants encode the direction (_IO,
_IOR, _IOW, _IOWR). ioctl commands defined with _IOR have negative ioctl
command constants.

Explicitly check for -1 to differentiate "unknown command" from valid
ioctls commands. Later commits will add ioctl commands that use _IOR.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 sys-utils/blkpr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/blkpr.c b/sys-utils/blkpr.c
index 03ca9f7e5..c6b030def 100644
--- a/sys-utils/blkpr.c
+++ b/sys-utils/blkpr.c
@@ -276,7 +276,7 @@ int main(int argc, char **argv)
 			break;
 		case 'c':
 			command = parse_pr_command(optarg);
-			if (command < 0)
+			if (command == -1)
 				err(EXIT_FAILURE, _("unknown command"));
 			break;
 		case 't':
-- 
2.52.0

